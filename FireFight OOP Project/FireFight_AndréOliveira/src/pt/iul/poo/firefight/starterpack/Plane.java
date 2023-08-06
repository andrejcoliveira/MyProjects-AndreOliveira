package pt.iul.poo.firefight.starterpack;

import pt.iul.ista.poo.utils.Point2D;

public class Plane extends GameElement implements Movable {

	public Plane(Point2D position) {
		super(position);
	}

	@Override
	public String getName() {
		return "plane";
	}

	@Override
	public int getLayer() {
		return 4;
	}

	@Override
	public void move(int key) {
		Point2D newPosition = (new Point2D(getPosition().getX(), getPosition().getY() - 2));
		if(newPosition.getY() >= 1) {
			if(GameEngine.getInstance().isFire(newPosition))
				GameEngine.getInstance().removeFire(newPosition);
			if(GameEngine.getInstance().isFire(new Point2D(newPosition.getX(), newPosition.getY() + 1)))
				GameEngine.getInstance().removeFire(new Point2D(newPosition.getX(), newPosition.getY() + 1));
			setPosition(newPosition);
		}else if(newPosition.getY() <= 0){
			if(GameEngine.getInstance().isFire(new Point2D(newPosition.getX(), newPosition.getY() + 1)))
				GameEngine.getInstance().removeFire(new Point2D(newPosition.getX(), newPosition.getY() + 1));
			GameEngine.getInstance().removePlane();;
		}
	}

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
