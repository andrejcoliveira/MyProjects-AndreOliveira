package pt.iul.poo.firefight.starterpack;

import pt.iul.ista.poo.utils.Point2D;

public class Burnt extends GameElement{

	private String type;
	
	public Burnt(Point2D position, String type) {
		super(position);
		this.type = type;
	}

	@Override
	public String getName() {
		if(type.equals("Eucaliptus"))
			return "burnteucaliptus";
		else if(type.equals("Grass"))
			return "burntgrass";
		else if(type.equals("Pine"))
			return "burntpine";
		else 
			return "burnt";
	}

	@Override
	public int getLayer() {
		return 1;
	}

}
