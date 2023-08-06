import javax.swing.JPanel;
import javax.swing.JLabel;
import java.awt.Color;
import java.awt.Font;
/**
 * 
 * Class to create new Panel Home
 *
 */
public class PanelHome extends JPanel {

	/**
	 * Create the panel.
	 */
	
	public PanelHome() {
		setBackground(new Color(255, 255, 255));
		setSize(551,433);
		setLayout(null);
		
		JLabel lblNewLabel = new JLabel("Welcome to 4Agenda!");
		lblNewLabel.setForeground(new Color(0, 128, 128));
		lblNewLabel.setFont(new Font("Dialog", Font.BOLD, 27));
		lblNewLabel.setBounds(86, 52, 332, 44);
		add(lblNewLabel);
		
		JLabel lblNewLabel_1 = new JLabel("This is an application for Teams.");
		lblNewLabel_1.setFont(new Font("Lucida Grande", Font.ITALIC, 15));
		lblNewLabel_1.setBounds(117, 94, 321, 30);
		add(lblNewLabel_1);
		
		JLabel lblNewLabel_2 = new JLabel("Develop by:");
		lblNewLabel_2.setFont(new Font("Lucida Grande", Font.PLAIN, 15));
		lblNewLabel_2.setBounds(154, 168, 118, 23);
		add(lblNewLabel_2);
		
		JLabel lblNewLabel_3 = new JLabel("Alexandra Monteiro");
		lblNewLabel_3.setBounds(154, 203, 138, 16);
		add(lblNewLabel_3);
		
		JLabel lblNewLabel_4 = new JLabel("André Oliveira");
		lblNewLabel_4.setBounds(154, 231, 132, 16);
		add(lblNewLabel_4);
		
		JLabel lblNewLabel_5 = new JLabel("Madalena Jorge");
		lblNewLabel_5.setBounds(154, 259, 138, 16);
		add(lblNewLabel_5);
		setVisible(true);
		
		
		
	}
}
