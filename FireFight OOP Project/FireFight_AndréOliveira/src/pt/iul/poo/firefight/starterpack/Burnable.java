package pt.iul.poo.firefight.starterpack;

public interface Burnable {
	public double probabilidade();
	public void burn(double prob);
	public boolean isBurnt();
	public void update();
}
