package pt.iul.poo.firefight.starterpack;

import pt.iul.ista.poo.utils.Point2D;
import pt.iul.ista.poo.gui.ImageTile;


public abstract class GameElement implements ImageTile {

	private Point2D position;

	public GameElement(Point2D position) {
		this.position = position;
	}

	public void setPosition(Point2D point) {
		this.position = point;
	}

	public Point2D getPosition() {
		return position;
	}

	public static GameElement returnGameElement(String c, Point2D position) {
		switch (c) {
		case "p":
			return new Pine(position);
		case "e":
			return new Eucaliptus(position);
		case "m":
			return new Grass(position);
		case "_":
			return new Land(position);
		case "a":
			return new Abies(position);
		case "b":
			return new FuelBarrel(position);
		case "Fireman":
			return new Fireman(position);
		case "Bulldozer":
			return new Bulldozer(position);
		case "Fire":
			return new Fire(position);
		case "FiremanBot":
			return new FiremanBot(position);
		case "FireTruck":
			return new FireTruck(position);
		default: 
			throw new IllegalArgumentException();
			}

	}
}
