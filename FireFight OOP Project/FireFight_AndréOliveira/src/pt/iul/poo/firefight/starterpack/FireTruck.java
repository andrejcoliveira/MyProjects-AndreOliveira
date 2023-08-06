package pt.iul.poo.firefight.starterpack;

import java.awt.event.KeyEvent;
import java.util.List;

import pt.iul.ista.poo.utils.Direction;
import pt.iul.ista.poo.utils.Point2D;

public class FireTruck extends GameElement implements Movable {

	private int key;
	
	public FireTruck(Point2D position) {
		super(position);
	}

	@Override
	public String getName() {
		if(key == KeyEvent.VK_LEFT)
			return "firetruck_left";
		if(key == KeyEvent.VK_RIGHT)
			return "firetruck_right";
		return "firetruck";
 	}

	@Override
	public int getLayer() {
		return 7;
	}

	@Override
	public void move(int key) {
		this.key = key;
		Point2D newPosition = null;
		Direction direction = null;
		if (key == KeyEvent.VK_DOWN) {
			direction = Direction.DOWN;
			newPosition = getPosition().plus(direction.asVector());
		} 

		if (key == KeyEvent.VK_UP) {
			direction = Direction.UP;
			newPosition = getPosition().plus(direction.asVector());
		}

		if (key == KeyEvent.VK_LEFT) {
			direction = Direction.LEFT;
			newPosition = getPosition().plus(direction.asVector());
		}

		if (key == KeyEvent.VK_RIGHT) {
			direction = Direction.RIGHT;
			newPosition = getPosition().plus(direction.asVector());
		}
		
		if (newPosition != null && direction != null && !GameEngine.getInstance().isFire(newPosition) && canMoveTo(newPosition)) {
			setPosition(newPosition);
		}else if(GameEngine.getInstance().isFire(newPosition) ) {
			List <Point2D> frontRect = newPosition.getFrontRect(direction, 3, 2);
			for(Point2D p: frontRect) {
				if(GameEngine.getInstance().isFire(p)) {
					GameEngine.getInstance().removeFire(p);
				}
			}
		}
	}

	@Override
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
