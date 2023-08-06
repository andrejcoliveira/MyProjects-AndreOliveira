package pt.iul.poo.firefight.starterpack;

import pt.iul.ista.poo.utils.Point2D;

public class Explosion extends GameElement {

	public Explosion(Point2D position) {
		super(position);
	}

	@Override
	public String getName() {
		return "explosion";
	}

	@Override
	public int getLayer() {
		return 6;
	}

}
