package pt.iul.poo.firefight.starterpack;

import pt.iul.ista.poo.utils.Point2D;

public class Eucaliptus extends GameElement implements Burnable {

	private boolean isBurning = false;
	public boolean isBurnt = false;
	private int count = 5;
	
	public Eucaliptus(Point2D position) {
		super(position);
	}
	
	public void setIsBurning(boolean b) {
		this.isBurning = b; 
	}
	
	@Override
	public String getName() {
		if(isBurnt)
			return "burnteucaliptus";
		return "eucaliptus";
	}

	@Override
	public int getLayer() {
		return 0;
	}

	@Override
	public void burn(double prob) {
		if(isBurning) {
			return;
		}else if(prob <= probabilidade()) {
			GameEngine.getInstance().addGameElement(new Fire(getPosition()));
			isBurning = true;
		}
	}

	@Override
	public double probabilidade() {
		return 10;
	}

	@Override
	public void update() {
				
		if(GameEngine.getInstance().isFire(getPosition())) {
			count--;
		}
		
		if(count == 0 && !isBurnt) {
			isBurnt = true;
			Fire fire = GameEngine.getInstance().getFireInPosition(getPosition());
			GameEngine.getInstance().removeGameElement(fire);
			GameEngine.getInstance().decreasePoints();
		}
	}

	@Override
	public boolean isBurnt() {
		return isBurnt;
	}

}
