package pt.iul.poo.firefight.starterpack;

import java.util.List;

import pt.iul.ista.poo.utils.Point2D;

public class FuelBarrel extends GameElement implements Burnable {
	public boolean isBurnt = false;
	private int count = 3;

	public FuelBarrel(Point2D position) {
		super(position);
	}

	@Override
	public String getName() {
		if (isBurnt)
			return "burntfuelbarrel";
		return "fuelbarrel";
	}

	@Override
	public int getLayer() {
		return 0;
	}

	@Override
	public double probabilidade() {
		return 90;
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
			List<Point2D> points = getPosition().getWideNeighbourhoodPoints();
			Explosion explosion = new Explosion(getPosition());
			GameEngine.getInstance().addGameElement(explosion);
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			GameEngine.getInstance().removeGameElement(explosion);
			for(Point2D p: points) {
				if(!GameEngine.getInstance().isFire(p) && GameEngine.getInstance().elementInPosition(p, 0) instanceof Burnable && !((Burnable) GameEngine.getInstance().elementInPosition(p, 0)).isBurnt() &&
						!(GameEngine.getInstance().elementInPosition(p, 3) instanceof Fireman) &&  !(GameEngine.getInstance().elementInPosition(p, 3) instanceof FiremanBot)) {
					GameEngine.getInstance().addGameElement(new Fire(p));
				}
			}
		}
	}

	@Override
	public boolean isBurnt() {
		return isBurnt;
	}

}

