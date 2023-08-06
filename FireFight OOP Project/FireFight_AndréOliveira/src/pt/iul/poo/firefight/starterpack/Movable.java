package pt.iul.poo.firefight.starterpack;

import pt.iul.ista.poo.utils.Point2D;

public interface Movable {
	public void move(int key);
	public boolean canMoveTo(Point2D position);
	public Point2D getPosition();
}
