import java.awt.EventQueue;
import java.awt.Image;

import javax.swing.ImageIcon;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import java.awt.Color;
import javax.swing.border.LineBorder;
import java.awt.Label;
import java.awt.Panel;
import javax.swing.JTextField;
import java.awt.Font;
import javax.swing.SwingConstants;
import javax.swing.JPasswordField;
import java.awt.event.FocusAdapter;
import java.awt.event.FocusEvent;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
/**
 * 
 * Class to create new login frame
 *
 */
public class FrameLogin extends JFrame {

	private JPanel contentPane;

	// Images
	private Image IconLogo = new ImageIcon(FrameLogin.class.getResource("Res/logo.png")).getImage()
			.getScaledInstance(200, 200, Image.SCALE_SMOOTH);
	private Label label;
	private JTextField txtUsername;
	private JTextField txtLogin;
	private JPasswordField pwdPassword;
	private JLabel lblLoginMessage;

	/**
	 * Create the frame.
	 */
	public FrameLogin() {
		setBackground(new Color(230, 230, 250));
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 807, 419);
		// setUndecorated(true);
		contentPane = new JPanel();
		contentPane.setForeground(new Color(0, 0, 139));
		contentPane.setBackground(new Color(47, 79, 79));
		contentPane.setBorder(new LineBorder(new Color(0, 0, 139), 0));

		setContentPane(contentPane);
		contentPane.setLayout(null);

		JPanel panel_1 = new JPanel();
		panel_1.setBackground(new Color(255, 255, 255));
		panel_1.setBorder(new LineBorder(new Color(255, 255, 255)));
		panel_1.setBounds(466, 120, 300, 40);
		contentPane.add(panel_1);
		panel_1.setLayout(null);

		txtUsername = new JTextField();
		txtUsername.addFocusListener(new FocusAdapter() {
			@Override
			public void focusGained(FocusEvent e) {
				if (txtUsername.getText().equals("Username")) {
					txtUsername.setText("");
				} else {
					txtUsername.selectAll();
				}
			}

			@Override
			public void focusLost(FocusEvent e) {
				if (txtUsername.getText().equals("")) {
					txtUsername.setText("Username");
				}
			}
		});
		txtUsername.setBorder(new LineBorder(new Color(255, 255, 255)));
		txtUsername.setFont(new Font("Arial", Font.PLAIN, 13));
		txtUsername.setText("Username");
		txtUsername.setBounds(6, 6, 266, 26);
		panel_1.add(txtUsername);
		txtUsername.setColumns(10);

		JPanel panel_1_1 = new JPanel();
		panel_1_1.setBackground(new Color(255, 255, 255));
		panel_1_1.setLayout(null);
		panel_1_1.setBorder(new LineBorder(new Color(255, 255, 255)));
		panel_1_1.setBounds(466, 200, 300, 40);
		contentPane.add(panel_1_1);

		pwdPassword = new JPasswordField();
		pwdPassword.addFocusListener(new FocusAdapter() {
			@Override
			public void focusGained(FocusEvent e) {
				if (pwdPassword.getText().equals("Password")) {
					pwdPassword.setEchoChar('●');
					pwdPassword.setText("");
				} else {
					pwdPassword.selectAll();
				}

			}

			@Override
			public void focusLost(FocusEvent e) {
				if (pwdPassword.getText().equals("")) {
					pwdPassword.setText("Password");
					pwdPassword.setEchoChar((char) 0);
				}
			}
		});
		pwdPassword.setBorder(new LineBorder(new Color(255, 255, 255)));
		pwdPassword.setEchoChar((char) 0);
		pwdPassword.setText("Password");
		pwdPassword.setFont(new Font("Arial", Font.PLAIN, 13));
		pwdPassword.setBounds(6, 6, 229, 26);
		panel_1_1.add(pwdPassword);

		JPanel pnlBtnLogin = new JPanel();
		pnlBtnLogin.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				if (txtUsername.getText().equals("admin") && pwdPassword.getText().equals("admin123")) {
					lblLoginMessage.setText("");
					JOptionPane.showMessageDialog(null, "Login Successful");

					// Opening the Frame Dashboard
					FrameDashboard frame = new FrameDashboard();
					frame.setVisible(true);
					setVisible(false);
					dispose();

				} else if (txtUsername.getText().equals("") || txtUsername.getText().equals("Username")
						|| pwdPassword.getText().equals("") || pwdPassword.getText().equals("Password")) {
					lblLoginMessage.setText("Please input all requirements!");
				} else {
					lblLoginMessage.setText("Invalid inputs! Please try again.");
				}
			}

			@Override
			public void mouseEntered(MouseEvent e) {
				pnlBtnLogin.setBackground(new Color(30, 60, 60));
			}

			@Override
			public void mouseExited(MouseEvent e) {
				pnlBtnLogin.setBackground(new Color(128, 128, 128));
			}

			@Override
			public void mousePressed(MouseEvent e) {
				pnlBtnLogin.setBackground(new Color(60, 80, 80));
			}

			@Override
			public void mouseReleased(MouseEvent e) {
				pnlBtnLogin.setBackground(new Color(30, 60, 60));
			}
		});
		pnlBtnLogin.setBackground(new Color(128, 128, 128));
		pnlBtnLogin.setFont(new Font("Arial Black", Font.PLAIN, 13));
		pnlBtnLogin.setLayout(null);
		pnlBtnLogin.setBorder(new LineBorder(new Color(255, 255, 255)));
		pnlBtnLogin.setBounds(466, 298, 300, 40);
		contentPane.add(pnlBtnLogin);

		txtLogin = new JTextField();
		txtLogin.setBorder(new LineBorder(new Color(128, 128, 128)));
		txtLogin.setHorizontalAlignment(SwingConstants.CENTER);
		txtLogin.setBackground(new Color(128, 128, 128));
		txtLogin.setText("LOGIN");
		txtLogin.setFont(new Font("Arial", Font.PLAIN, 13));
		txtLogin.setColumns(10);
		txtLogin.setBounds(115, 6, 75, 28);
		pnlBtnLogin.add(txtLogin);

		JLabel lblIconLogo = new JLabel("");
		lblIconLogo.setIcon(new ImageIcon(IconLogo));
		lblIconLogo.setBounds(120, 102, 237, 258);
		contentPane.add(lblIconLogo);

		lblLoginMessage = new JLabel("");
		lblLoginMessage.setForeground(new Color(255, 255, 255));
		lblLoginMessage.setBounds(472, 268, 283, 16);
		contentPane.add(lblLoginMessage);
		setLocationRelativeTo(null);
	}
}
