package pt.iul.poo.firefight.starterpack;

import java.awt.event.KeyEvent;

import pt.iul.ista.poo.utils.Direction;
import pt.iul.ista.poo.utils.Point2D;

public class Bulldozer extends GameElement implements Movable {

	private int key;

	public Bulldozer(Point2D position) {
		super(position);
	}

	@Override
	public String getName() {
		if (key == KeyEvent.VK_DOWN) {
			return "bulldozer_down";
		} else

		if (key == KeyEvent.VK_UP) {
			return "bulldozer_up";
		} else

		if (key == KeyEvent.VK_LEFT) {
			return "bulldozer_left";
		} else

		if (key == KeyEvent.VK_RIGHT) {
			return "bulldozer_right";
		} else

			return "bulldozer_up";
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
		}

		if (key == KeyEvent.VK_UP) {
			Direction direction = Direction.UP;
			newPosition = getPosition().plus(direction.asVector());
		}

		if (key == KeyEvent.VK_LEFT) {
			Direction direction = Direction.LEFT;
			newPosition = getPosition().plus(direction.asVector());
		}

		if (key == KeyEvent.VK_RIGHT) {
			Direction direction = Direction.RIGHT;
			newPosition = getPosition().plus(direction.asVector());
		}

		if (newPosition != null) {
			if (canMoveTo(newPosition)) {
				if (GameEngine.getInstance().elementInPosition(newPosition, 0) instanceof Burnable
						&& !GameEngine.getInstance().isFire(newPosition)) {
					GameEngine.getInstance().turnInLand(newPosition);
				}
				if (!GameEngine.getInstance().isFire(newPosition))
					setPosition(newPosition);
			}
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
