package pt.iul.poo.firefight.starterpack;

import pt.iul.ista.poo.utils.Point2D;

public class Grass extends GameElement implements Burnable {

	public boolean isBurnt = false;
	private int count = 3;
	
	public Grass(Point2D position) {
		super(position);
	}

	@Override
	public String getName() {
		if (isBurnt)
			return "burntgrass";
		return "grass";
	}

	@Override
	public int getLayer() {
		return 0;
	}

	@Override
	public double probabilidade() {
		return 15;
	}

	@Override
	public void burn(double prob) {
		if (prob <= probabilidade()) {
			GameEngine.getInstance().addGameElement(new Fire(getPosition()));
		}
	}

	@Override
	public void update() {

		if (GameEngine.getInstance().isFire(getPosition())) {
			count--;
		}

		if (count == 0 && !isBurnt) {
			isBurnt = true;
			Fire fire = GameEngine.getInstance().getFireInPosition(getPosition());
			GameEngine.getInstance().removeGameElement(fire);
			GameEngine.getInstance().decreasePoints();
		}
	}

	@Override
	public boolean isBurnt() {
		return isBurnt;
	}

}
