import java.awt.Color;
import java.awt.Font;
import java.awt.event.FocusAdapter;
import java.awt.event.FocusEvent;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;

import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.border.LineBorder;
import javax.swing.JPasswordField;
import javax.swing.SwingConstants;
/**
 * 
 * Class to create new login panel
 *
 */
public class ImportPanel extends JPanel {
	private JTextField txtUsername;
	private JTextField txtURL;
	private JTextField textField_submit;
	private JLabel lblSubmitMessage;
	private JPanel pnlBtnSubmit;
	private JLabel lblNewLabel;

	/**
	 * Create the panel.
	 */
	public ImportPanel() {
		setBackground(new Color(255, 255, 255));
		setSize(551,433);
		setLayout(null);
		
		JPanel panel_1 = new JPanel();
		panel_1.setLayout(null);
		panel_1.setBorder(new LineBorder(new Color(255, 255, 255)));
		panel_1.setBackground(Color.WHITE);
		panel_1.setBounds(107, 128, 300, 40);
		add(panel_1);
		
		txtUsername = new JTextField();
		txtUsername.setBackground(new Color(192, 192, 192));
		txtUsername.addFocusListener(new FocusAdapter() {
			@Override
			public void focusGained(FocusEvent e) {
				if (txtUsername.getText().equals("Username")) {
					txtUsername.setText("");
				}
				else {
					txtUsername.selectAll();
				}
			}
			@Override
			public void focusLost(FocusEvent e) {
				if(txtUsername.getText().equals("")) {
					txtUsername.setText("Username");
				}
			}
		});
		txtUsername.setText("Username");
		txtUsername.setFont(new Font("Arial", Font.PLAIN, 13));
		txtUsername.setColumns(10);
		txtUsername.setBorder(new LineBorder(new Color(255, 255, 255)));
		txtUsername.setBounds(6, 6, 266, 26);
		panel_1.add(txtUsername);
		
		JPanel panel_1_1 = new JPanel();
		panel_1_1.setLayout(null);
		panel_1_1.setBorder(new LineBorder(new Color(255, 255, 255)));
		panel_1_1.setBackground(Color.WHITE);
		panel_1_1.setBounds(107, 208, 300, 40);
		add(panel_1_1);
		
		txtURL = new JTextField();
		txtURL.setBackground(new Color(192, 192, 192));
		txtURL.addFocusListener(new FocusAdapter() {
			@Override
			public void focusGained(FocusEvent e) {
				if (txtURL.getText().equals("URL Calendar")) {
					txtURL.setText("");
				}
				else {
					txtURL.selectAll();
				}
			}
			@Override
			public void focusLost(FocusEvent e) {
				if(txtURL.getText().equals("")) {
					txtURL.setText("URL Calendar");
				}
			}
		});
		txtURL.setText("URL Calendar");
		txtURL.setFont(new Font("Arial", Font.PLAIN, 13));
		txtURL.setColumns(10);
		txtURL.setBorder(new LineBorder(new Color(255, 255, 255)));
		txtURL.setBounds(6, 6, 267, 26);
		panel_1_1.add(txtURL);
		
		pnlBtnSubmit = new JPanel();
		pnlBtnSubmit.setLayout(null);
		pnlBtnSubmit.setFont(new Font("Arial Black", Font.PLAIN, 13));
		pnlBtnSubmit.setBorder(new LineBorder(new Color(255, 255, 255)));
		pnlBtnSubmit.setBackground(Color.GRAY);
		pnlBtnSubmit.setBounds(107, 296, 300, 40);
		add(pnlBtnSubmit);
		
		textField_submit = new JTextField();
		textField_submit.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				
				String user = txtUsername.getText();
				
				try {
					IcsToJson icsToJson = new IcsToJson(txtURL.getText());
					File jsonFile = icsToJson.getJson(user);
					MongoDB.importData(jsonFile.getName());
					
				} catch (MalformedURLException e1) {
					e1.printStackTrace();
				} catch (IOException e2) {
					e2.printStackTrace();
				}
				lblSubmitMessage.setText("Calendar submitted by " + user);
				JOptionPane.showMessageDialog(null,"Import Calendar Successful");
				
			}
			@Override
			public void mouseEntered(MouseEvent e) {
				pnlBtnSubmit.setBackground(new Color(30, 60, 60));
			}
			@Override
			public void mouseExited(MouseEvent e) {
				pnlBtnSubmit.setBackground(new Color(128, 128, 128));
			}
			@Override
			public void mousePressed(MouseEvent e) {
				pnlBtnSubmit.setBackground(new Color(60, 80, 80));
			}
			@Override
			public void mouseReleased(MouseEvent e) {
				pnlBtnSubmit.setBackground(new Color(30, 60, 60));
			}
		});
		textField_submit.setText("SUBMIT");
		textField_submit.setHorizontalAlignment(SwingConstants.CENTER);
		textField_submit.setFont(new Font("Arial", Font.PLAIN, 13));
		textField_submit.setColumns(10);
		textField_submit.setBorder(new LineBorder(new Color(128, 128, 128)));
		textField_submit.setBackground(Color.GRAY);
		textField_submit.setBounds(115, 6, 75, 28);
		pnlBtnSubmit.add(textField_submit);
		
		lblSubmitMessage = new JLabel("");
		lblSubmitMessage.setForeground(new Color(255, 255, 255));
		lblSubmitMessage.setBounds(472, 268, 283, 16);
		add(lblSubmitMessage);
		
		lblNewLabel = new JLabel("Import Calendar:");
		lblNewLabel.setFont(new Font("Dialog", Font.ITALIC, 20));
		lblNewLabel.setForeground(new Color(0, 128, 128));
		lblNewLabel.setBounds(122, 65, 267, 31);
		add(lblNewLabel);

	}
}	
	
	
	
	


