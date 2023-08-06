package pt.iul.poo.firefight.starterpack;

import java.awt.event.KeyEvent;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

import pt.iul.ista.poo.gui.ImageMatrixGUI;
import pt.iul.ista.poo.gui.ImageTile;
import pt.iul.ista.poo.observer.Observed;
import pt.iul.ista.poo.observer.Observer;
import pt.iul.ista.poo.utils.Point2D;

public class GameEngine implements Observer {

	// Dimensoes da grelha de jogo
	public static final int GRID_HEIGHT = 10;
	public static final int GRID_WIDTH = 10;

	private ImageMatrixGUI gui; // Referencia para ImageMatrixGUI (janela de interface com o utilizador)
	private List<ImageTile> tileList; // Lista de imagens
	private Fireman fireman; // Referencia para o bombeiro
	private Plane plane; // Referencia para o avi�o
	private int points; // Pontos do jogador
	private int levelNumber = 1; // N�mero correspondente ao n�vel atual
	private int numberOfLevels = 6; // N�mero total de n�veis
	private String nickname; // Nickname do jogador

	private static GameEngine INSTANCE;

	public static GameEngine getInstance() { // Construtor (Solit�o)
		if (INSTANCE == null)
			INSTANCE = new GameEngine();
		return INSTANCE;
	}


	private GameEngine() {

		gui = ImageMatrixGUI.getInstance(); // 1. obter instancia ativa de ImageMatrixGUI
		gui.setSize(GRID_HEIGHT, GRID_WIDTH); // 2. configurar as dimensoes
		gui.registerObserver(this); // 3. registar o objeto ativo GameEngine como observador da GUI
		gui.go(); // 4. lancar a GUI
		tileList = new ArrayList<>();
	}

	@Override
	public void update(Observed source) {

		int key = gui.keyPressed(); // obtem o codigo da tecla pressionada
		
		if (key == KeyEvent.VK_P) // Caso o jogador carregue na tecla P, chama a fun��o callPlane que faz aparecer o avi�o
			callPlane(); 
		else if (existsPlane()) // Caso j� exista um avi�o, movimenta-o
			plane.move(key);

		fireman.move(key); //Mover o fireman
		moveFiremanBots(key); //Mover os firemanBots
		atualizaObjetos(); //Chama a fun��o update de cada "updatable"
		gui.update(); // redesenha as imagens na GUI, tendo em conta as novas posicoes

		gui.setStatusMessage("Points: " + points + "        Player: " + nickname);

		if (checkEndOfLevel() && levelNumber < numberOfLevels) { // Caso j� n�o haja mais fogos, muda de n�vel
			saveScores(); // Guarda as pontua��es
			changeLevel(); // Muda de n�vel
		} else if (checkEndOfLevel() && levelNumber == numberOfLevels) { //Caso j� n�o haja mais fogos e seja o �ltimo n�vel, o jogo acaba
			gui.setMessage("Jogo Terminado. \n Pontua��o: " + points);
			saveScores(); //Guarda as pontua��es
			System.exit(0); // Fecha a janela
		}
	}

	// Criacao dos objetos e envio das imagens para GUI
	public void start() {
		gui.setStatusMessage("FireFighter - Projeto POO 2021 || Andr� Oliveira & Alexandra Monteiro");
		if (levelNumber < 2) {
			gui.setMessage(
					"                                        Bem Vindo! \n Por favor, introduza o seu nickname na consola para come�ar.");
			System.out.println("Insira o seu nickname: \n");
			Scanner in = new Scanner(System.in);
			nickname = in.nextLine();
			in.close();
		}
		createTerrainFromFile("levels/level" + levelNumber + ".txt");
		sendImagesToGUI();
		gui.update();
	}

	public void saveScores() { // Guarda as pontua��es de cada n�vel num ficheiro corresponde
		List<String> highscore = new ArrayList<>();
		File f = new File("Highscores/level" + levelNumber + ".txt");
		try {
			Scanner s = new Scanner(f);
			if(s.hasNextLine())
				s.nextLine();
			
			while (s.hasNextLine()) {
				String line = s.nextLine();
				highscore.add(line);
			}
			s.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		highscore.add(nickname + ": " + points + " pts");
		highscore.sort((String a, String b) -> (Integer.parseInt(b.split(" ")[1]) - Integer.parseInt(a.split(" ")[1])));
		try {
			PrintWriter fileWriter = new PrintWriter(new File("Highscores/level" + levelNumber + ".txt"));
			fileWriter.println("TOP 5 PLAYERS - LEVEL " + levelNumber + ":");
			int i = 1;
			for (String s : highscore) {
				if (i <= 5)
					fileWriter.println(s);
				i++;
			}
			fileWriter.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}

	}

	public Bulldozer getBulldozer(Point2D pos) { // Devolve o bulldozer
		for(ImageTile i: tileList) {
			if(i.getPosition().equals(pos) && i instanceof Bulldozer) {
				return (Bulldozer) i;
			}
		}
		return null;
	}
	
	public FireTruck getFireTruck(Point2D pos) { //Devolve o FireTruck
		for(ImageTile i: tileList) {
			if(i.getPosition().equals(pos) && i instanceof FireTruck) {
				return (FireTruck) i;
			}
		}
		return null;
	}
	
	public void atualizaObjetos() { //Atualiza os objetos e propaga o fogo
		propagaFogo();
		updateBurnables();
	}

	public int numberOfFires() { // Devolve o numero de fogos no mapa
		int count = 0;
		for (ImageTile i : tileList) {
			if (i instanceof Fire)
				count++;
		}
		return count;
	}

	public boolean checkEndOfLevel() { // Se j� n�o existir fogos, devolve true
		if (numberOfFires() == 0)
			return true;
		return false;
	}

	public void changeLevel() { //Muda para o proximo nivel
		levelNumber++;
		removePlane();
		gui.clearImages();
		tileList.clear();
		points = 0;
		start();
	}

	public void waterAnimation(Point2D pos, int key) { //Faz aparecer a �gua numa certa posi��o
		GameElement water = new Water(pos, key);
		addGameElement(water);
		try {
			Thread.sleep(500);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		removeGameElement(water);
	}

	public void increasePoints() {
		points += 2;
	}

	public void decreasePoints() {
		points--;
	}

	private void createTerrainFromFile(String fileName) { // Cria o terreno a partir do terreno
		try {
			Scanner s = new Scanner(new File(fileName));
			int line = 0;
			while (s.hasNextLine() && line < GRID_HEIGHT) {
				String column = s.nextLine();
				for (int x = 0; x < GRID_WIDTH; x++)
					tileList.add(GameElement.returnGameElement(String.valueOf(column.charAt(x)), new Point2D(x, line)));
				line++;
			}

			while (s.hasNextLine()) {
				String[] line2 = s.nextLine().split(" ");
				GameElement e = GameElement.returnGameElement(line2[0],
						new Point2D(Integer.parseInt(line2[1]), Integer.parseInt(line2[2])));
				if (line2[0].equals("Fireman")) {
					fireman = (Fireman) e;
				}
				tileList.add(e);
			}
			s.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
	}
 
	public void moveFiremanBots(int key) {  //Movimenta todos os FiremanBots da lista
		List<Movable> aux = new ArrayList<>();
		for (ImageTile i : tileList) {
			if (i instanceof FiremanBot)
				aux.add((Movable) i);
		}

		for (Movable m : aux) {
			m.move(key);
		}
	}

	public boolean isFire(Point2D pos) { //Devolve true, se houver fogo numa dada posi��o
		for (ImageTile i : tileList) {
			if (i.getPosition().equals(pos)) {
				if (i instanceof Fire)
					return true;
			}
		}
		return false;
	}

	public Fire getFireInPosition(Point2D pos) { //Devolve o objeto Fire numa dada posi��o
		for (ImageTile i : tileList) {
			if (i.getPosition().equals(pos) && i instanceof Fire) {
				return (Fire) i;
			}
		}
		return null;
	}

	public void updateBurnables() { //Update a todos os burnables da lista
		List<ImageTile> aux = new ArrayList<>();
		for (ImageTile i : tileList) {
			if (i instanceof Burnable)
				aux.add(i);
		}

		for (ImageTile i : aux) {
			((Burnable) i).update();
		}
	}

	public void removeGameElement(ImageTile i) { // Remove um dado elemento da lista
		if (i != null) {
			tileList.remove(i);
			gui.removeImage(i);
		}
	}

	public void addGameElement(ImageTile i) { // Adiciona um dado elemento � lista
		if (i != null) {
			tileList.add(i);
			gui.addImage(i);
		}
	}

	public void removeFire(Point2D pos) { // remove o Fogo de uma dada posi��o
		ImageTile i = null;
		for (ImageTile i2 : tileList) {
			if (i2 instanceof Fire && i2.getPosition().equals(pos)) {
				i = i2;
			}
		}
		removeGameElement(i);
		increasePoints();
	}

	public List<Burnable> getBurnables(Point2D pos) { // Devolve as posi��es par as quais � poss�vel alastrar o fogo

		List<Burnable> burnableList = new ArrayList<>();
		List<Point2D> lista = pos.getNeighbourhoodPoints();

		for (ImageTile i : tileList) {
			if ((lista.get(0).equals(i.getPosition()) || lista.get(1).equals(i.getPosition())
					|| lista.get(2).equals(i.getPosition()) || lista.get(3).equals(i.getPosition()))
					&& !isFire(i.getPosition()) && !i.getPosition().equals(fireman.getPosition())
					&& !(i instanceof Movable)) {
				if (i instanceof Burnable) {
					burnableList.add((Burnable) i);
				}
			}
		}
		return burnableList;
	}

	public void propagaFogo() { //Propaga o em cada objeto Fogo
		List<Fire> fireList = new ArrayList<>();
		for (ImageTile i : tileList) {
			if (i instanceof Fire) {
				fireList.add((Fire) i);
			}
		}

		for (Fire f : fireList) {
			f.propaga();
		}

	}

	public GameElement elementInPosition(Point2D pos, int layer) { //Devolve o elemento numa dada posi��o e camada
		ImageTile i = null;
		for (ImageTile i2 : tileList) {
			if (i2.getPosition().equals(pos) && i2.getLayer() == layer) {
				i = i2;
			}
		}
		return (GameElement) i;
	}

	public void turnInLand(Point2D pos) { // Transforma qualquer posi��o em terra
		ImageTile it = null;
		for (ImageTile i : tileList) {
			if (i.getPosition().equals(pos) && i instanceof Burnable) {
				it = i;
			}
		}
		removeGameElement(it);
		addGameElement(new Land(pos));
	}

	public int getX() { //Devolve a posi��o X para a qual o avi�o vai
		List<Integer> list = new ArrayList<>();
		int count = 0;
		for (int x = 0; x < GRID_WIDTH; x++) {
			for (int y = 0; y < GRID_HEIGHT; y++) {
				if (isFire(new Point2D(x, y))) {
					count++;
				}
			}
			list.add(count);
			count = 0;
		}

		int aux = 0;
		int aux2 = -1;
		int X = -1;
		for (Integer i : list) {
			X++;
			if (i > aux) {
				aux = i;
				aux2 = X;
			}
		}
		return aux2;
	}

	public boolean existsPlane() { // Devolve true, se houver um avi�o no mapa
		for (ImageTile i : tileList) {
			if (i instanceof Plane) {
				return true;
			}
		}
		return false;
	}

	public void callPlane() { // Faz com que o avi�o apare�a
		removePlane();
		Point2D pos = new Point2D(getX(), 9);

		if (isFire(pos))
			removeFire(pos);

		plane = new Plane(pos);

		if (!existsPlane())
			addGameElement(plane);
	}

	public void removePlane() {
		removeGameElement(plane);
		plane = null;
	}

	public List<Point2D> firePositions() { // Devolve todas as posi��es em que h� fogo
		List<Point2D> firePositions = new ArrayList<>();
		for (ImageTile i : tileList) {
			if (i instanceof Fire)
				firePositions.add(i.getPosition());
		}
		return firePositions;
	}

	// Envio das mensagens para a GUI - note que isto so' precisa de ser feito no
	// inicio
	// Nao e' suposto re-enviar os objetos se a unica coisa que muda sao as posicoes
	private void sendImagesToGUI() {
		gui.addImages(tileList);
	}
}
