package pt.iul.poo.firefight.starterpack;

import java.awt.event.KeyEvent;

import pt.iul.ista.poo.utils.Point2D;

public class Water extends GameElement {
	
	private int key;
	
	public Water(Point2D position, int key) { //Passar a key e fazer os if's
		super(position);
		this.key = key;
	}

	@Override
	public String getName() {
		if (key == KeyEvent.VK_DOWN) {
			return "water_down";
		}

		if (key == KeyEvent.VK_UP) {
			return "water_up";
		}

		if (key == KeyEvent.VK_LEFT) {
			return "water_left";
		}

		if (key == KeyEvent.VK_RIGHT) {
			return "water_right";
		}
		
		return "water";
	}

	@Override
	public int getLayer() {
		return 5;
	}

}
