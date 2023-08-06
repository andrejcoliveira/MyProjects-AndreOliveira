package pt.iul.poo.firefight.starterpack;

import pt.iul.ista.poo.utils.Point2D;

public class Abies extends GameElement implements Burnable {
	public boolean isBurnt = false;
	private int count = 20;

	public Abies(Point2D position) {
		super(position);
	}

	@Override
	public String getName() {
		if (isBurnt)
			return "burntabies";
		return "abies";
	}

	@Override
	public int getLayer() {
		return 0;
	}

	@Override
	public double probabilidade() {
		return 5;
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
