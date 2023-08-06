package pt.iul.poo.firefight.starterpack;

import pt.iul.ista.poo.utils.Point2D;

import java.util.List;

public class Fire extends GameElement {

	public Fire(Point2D position) {
		super(position);
	}

	@Override
	public String getName() {
		return "fire";
	}

	@Override
	public int getLayer() {
		return 1;
	}

	@Override
	public String toString() {
		return "Fire [getName()=" + getName() + ", getLayer()=" + getLayer() + "]";
	}
	
	public void propaga() {
		List<Burnable> burnables = GameEngine.getInstance().getBurnables(getPosition());
		for(Burnable b: burnables) {
			double r = Math.random()*100;
			if(!((Burnable) b).isBurnt()) {
				b.burn(r);
			}
		}
	}
}
