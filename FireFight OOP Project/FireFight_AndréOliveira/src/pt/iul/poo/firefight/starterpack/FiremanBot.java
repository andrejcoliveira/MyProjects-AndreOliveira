package pt.iul.poo.firefight.starterpack;

import java.awt.event.KeyEvent;
import java.util.List;

import pt.iul.ista.poo.utils.Direction;
import pt.iul.ista.poo.utils.Point2D;

public class FiremanBot extends GameElement implements Movable{

	private Direction direction;
	
	public FiremanBot(Point2D position) {
		super(position);
	}

	@Override
	public String getName() {
		if(direction == Direction.LEFT)
			return "firemanbot_left";
		if(direction == Direction.RIGHT)
			return "firemanbot_right";
		return "firemanbot";
	}

	@Override
	public int getLayer() {
		return 3;
	}

	@Override
	public void move(int key) {
		List<Point2D>  firePositions = GameEngine.getInstance().firePositions();
		Point2D closerFire = firePositions.get(0);
		for(Point2D p: firePositions) {
			if(getPosition().distanceTo(closerFire) > getPosition().distanceTo(p)) {
				closerFire = p;
			}
		}
		Point2D newPosition = null;
		if(closerFire != null)
			direction = getPosition().directionTo(closerFire);
		if(direction != null) {
			newPosition = getPosition().plus(direction.asVector());
		}
		if(newPosition != null && !GameEngine.getInstance().isFire(newPosition) && !(GameEngine.getInstance().elementInPosition(newPosition, 3) instanceof Fireman) && canMoveTo(newPosition))
			setPosition(newPosition);
		else if(GameEngine.getInstance().isFire(newPosition)) {
			if(direction == Direction.DOWN)
				GameEngine.getInstance().waterAnimation(newPosition, KeyEvent.VK_DOWN);
			if(direction == Direction.UP)
				GameEngine.getInstance().waterAnimation(newPosition, KeyEvent.VK_UP);
			if(direction == Direction.LEFT)
				GameEngine.getInstance().waterAnimation(newPosition, KeyEvent.VK_LEFT);
			if(direction == Direction.RIGHT)
				GameEngine.getInstance().waterAnimation(newPosition, KeyEvent.VK_RIGHT);
			GameEngine.getInstance().removeFire(newPosition);
			
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
