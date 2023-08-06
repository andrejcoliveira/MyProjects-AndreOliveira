package pt.iul.poo.firefight.starterpack;

import pt.iul.ista.poo.utils.Direction;
import java.awt.event.KeyEvent;
import pt.iul.ista.poo.utils.Point2D;

public class Fireman extends GameElement implements Movable {
	
	private int key;
	private Movable vehicle;
	
	public Fireman(Point2D position) {
		super(position);
		
	}
	
	// Metodos de ImageTile
		@Override
		public String getName() {
			if (key == KeyEvent.VK_LEFT) {
				return "fireman_left";
			}

			if (key == KeyEvent.VK_RIGHT) {
				return "fireman_right";
			}
			return "fireman";
		}

		@Override
		public int getLayer() {
			return 3;
		}
		
	public void move(int key) {
		this.key = key;
		Point2D newPosition = null;
		if (key == KeyEvent.VK_DOWN) {
			Direction direction = Direction.DOWN;
			newPosition = getPosition().plus(direction.asVector());
		} else if (key == KeyEvent.VK_UP) {
			Direction direction = Direction.UP;
			newPosition = getPosition().plus(direction.asVector());
		}else if (key == KeyEvent.VK_LEFT) {
			Direction direction = Direction.LEFT;
			newPosition = getPosition().plus(direction.asVector());
		}else if (key == KeyEvent.VK_RIGHT) {
			Direction direction = Direction.RIGHT;
			newPosition = getPosition().plus(direction.asVector());
		}else if(key == KeyEvent.VK_ENTER && vehicle != null) {
			setPosition(vehicle.getPosition());
			GameEngine.getInstance().addGameElement(this);
			vehicle = null;
		}
		
		if(GameEngine.getInstance().elementInPosition(newPosition, 3) instanceof Bulldozer) {
				vehicle = GameEngine.getInstance().getBulldozer(newPosition);
				GameEngine.getInstance().removeGameElement(this);
		
		}else if(GameEngine.getInstance().elementInPosition(newPosition, 7) instanceof FireTruck) {
				vehicle = GameEngine.getInstance().getFireTruck(newPosition);
				GameEngine.getInstance().removeGameElement(this);
		}
		
		if(vehicle !=  null) {
			vehicle.move(key);
		}
		
		if(newPosition != null && vehicle == null) {
			if (canMoveTo(newPosition) && GameEngine.getInstance().isFire(newPosition)) {
				GameElement water = new Water(newPosition, key);
				 GameEngine.getInstance().addGameElement(water);
				try {
					Thread.sleep(1000);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
				 GameEngine.getInstance().removeGameElement(water);
				GameEngine.getInstance().removeFire(newPosition);
			}else if (canMoveTo(newPosition) && !GameEngine.getInstance().isFire(newPosition)) {
				setPosition(newPosition);
			}
		}
	}


	// Verifica se a posicao p esta' dentro da grelha de jogo
	public boolean canMoveTo(Point2D p) {

		if (p.getX() < 0)
			return false;
		if (p.getY() < 0)
			return false;
		if (p.getX() >= GameEngine.GRID_WIDTH)
			return false;
		if (p.getY() >= GameEngine.GRID_HEIGHT)
			return false;
		return true;
	}
}
