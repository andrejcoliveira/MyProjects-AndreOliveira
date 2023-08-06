import java.awt.EventQueue;
import java.awt.Image;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.text.ParseException;

import javax.swing.ImageIcon;
import javax.swing.JFrame;
import javax.swing.JPanel;
import java.awt.Color;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.border.LineBorder;

import com.itextpdf.text.DocumentException;

import java.awt.Font;

public class FrameDashboard extends JFrame {

	private JPanel backgroundPane;
	private Image IconLogo = new ImageIcon(FrameLogin.class.getResource("Res/logo.png")).getImage().getScaledInstance(150,150,Image.SCALE_SMOOTH);
	private Image home = new ImageIcon(FrameLogin.class.getResource("Res/home.png")).getImage().getScaledInstance(50,50,Image.SCALE_SMOOTH);
	private PanelHome PanelHome2;
	private ImportPanel ImportPanel2;
	private ViewPanel ViewPanel2;
	
	/**
	 * Launch the application.
	 */

	/**
	 * Create the frame.
	 */
	public FrameDashboard() {
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setLocationRelativeTo(null);
		setBounds(100, 100, 807, 550);
		setUndecorated(false);
		backgroundPane = new JPanel();
		backgroundPane.setBackground(new Color(255, 255, 255));
		backgroundPane.setBorder(new LineBorder(new Color(0, 128, 128)));

		setContentPane(backgroundPane);
		backgroundPane.setLayout(null);
		
		PanelHome2 = new PanelHome();
		ImportPanel2= new ImportPanel();
		ViewPanel2 = new ViewPanel();
		
		//Menu Panel
		JPanel MenuPanel = new JPanel();
		MenuPanel.setBounds(0, 160, 219, 390);
		MenuPanel.setBackground(new Color(0, 128, 128));
		backgroundPane.add(MenuPanel);
		MenuPanel.setLayout(null);
		
		// Home Button
		JPanel panelHome = new JPanel();
		//panelHome.addMouseListener(new PanelButtomMouseAdapter(PanelHome2));
		panelHome.addMouseListener(new PanelButtomMouseAdapter(panelHome) {
			@Override
			public void mouseClicked(MouseEvent e){
				menuClicked(PanelHome2);
			}
		});
		panelHome.setBorder(new LineBorder(new Color(255, 255, 255)));
		panelHome.setForeground(new Color(255, 255, 255));
		panelHome.setToolTipText("");
		panelHome.setBackground(new Color(0, 128, 128));
		panelHome.setBounds(0, 35, 219, 47);
		MenuPanel.add(panelHome);
		panelHome.setLayout(null);
		
		// Text Home Button
		JLabel lblLabelHome = new JLabel("Home");
		lblLabelHome.setBounds(83, 6, 65, 35);
		lblLabelHome.setForeground(new Color(255, 255, 255));
		lblLabelHome.setFont(new Font("Dialog", Font.PLAIN, 16));
		panelHome.add(lblLabelHome);
		
		// Import Button
		JPanel ImportPanel = new JPanel();
		ImportPanel.addMouseListener(new PanelButtomMouseAdapter(ImportPanel) {
			@Override
			public void mouseClicked(MouseEvent e){
				menuClicked(ImportPanel2);
			}
		});
		ImportPanel.setBorder(new LineBorder(new Color(255, 255, 255)));
		ImportPanel.setToolTipText("");
		ImportPanel.setForeground(Color.WHITE);
		ImportPanel.setBackground(new Color(0, 128, 128));
		ImportPanel.setBounds(0, 81, 219, 47);
		MenuPanel.add(ImportPanel);
		ImportPanel.setLayout(null);
		
		// Text Import Button
		JLabel lblNewLabelImport = new JLabel("Import");
		lblNewLabelImport.setForeground(Color.WHITE);
		lblNewLabelImport.setFont(new Font("Dialog", Font.PLAIN, 16));
		lblNewLabelImport.setBounds(73, 6, 65, 35);
		ImportPanel.add(lblNewLabelImport);
		
		JPanel ViewPanel = new JPanel();
		ViewPanel.addMouseListener(new PanelButtomMouseAdapter(ViewPanel) {
			@Override
			public void mouseClicked(MouseEvent e){
				//menuClicked(ViewPanel2);
				CalendarEngine calendar = new CalendarEngine();
				try {
					calendar.startCalendar();
				} catch (InvocationTargetException | ParseException | IOException | DocumentException
						| InterruptedException e1) {
					e1.printStackTrace();
				}
			}
		});
		ViewPanel.setBorder(new LineBorder(new Color(255, 255, 255)));
		ViewPanel.setToolTipText("");
		ViewPanel.setForeground(Color.WHITE);
		ViewPanel.setBackground(new Color(0, 128, 128));
		ViewPanel.setBounds(0, 127, 219, 47);
		MenuPanel.add(ViewPanel);
		ViewPanel.setLayout(null);
		
		JLabel lblViewCalendars = new JLabel("View ");
		lblViewCalendars.setForeground(Color.WHITE);
		lblViewCalendars.setFont(new Font("Dialog", Font.PLAIN, 16));
		lblViewCalendars.setBounds(83, 6, 65, 35);
		ViewPanel.add(lblViewCalendars);
		
		//SignOutPanel
		JPanel signOutPane = new JPanel();
		signOutPane.addMouseListener(new PanelButtomMouseAdapter(signOutPane) {
			@Override
			public void mouseClicked(MouseEvent e){
				if(JOptionPane.showConfirmDialog(null, "Are you sure that you want to sign out?") == 0) {
					FrameLogin frameLogin = new FrameLogin();
					frameLogin.setVisible(true);
					setVisible(false);
					dispose();
				}
				
			}
		});
		signOutPane.setBorder(new LineBorder(new Color(255, 255, 255)));
		signOutPane.setToolTipText("");
		signOutPane.setForeground(Color.WHITE);
		signOutPane.setBackground(new Color(0, 128, 128));
		signOutPane.setBounds(0, 315, 219, 47);
		MenuPanel.add(signOutPane);
		signOutPane.setLayout(null);
		
		JLabel lblNewLabel = new JLabel("SIGN OUT");
		lblNewLabel.setFont(new Font("Dialog", Font.PLAIN, 16));
		lblNewLabel.setForeground(new Color(255, 255, 255));
		lblNewLabel.setBounds(63, 6, 83, 35);
		signOutPane.add(lblNewLabel);
		
		JLabel lblLogoLabel = new JLabel("");
		lblLogoLabel.setBounds(22, 17, 174, 135);
		backgroundPane.add(lblLogoLabel);
		lblLogoLabel.setIcon(new ImageIcon(IconLogo));
		
		JPanel panelMain = new JPanel();
		panelMain.setBackground(new Color(255, 255, 255));
		panelMain.setBounds(235, 67, 551, 433);
		backgroundPane.add(panelMain);
		panelMain.setLayout(null);
		
		panelMain.add(PanelHome2);
		panelMain.add(ImportPanel2);
		panelMain.add(ViewPanel2);
		
		menuClicked(PanelHome2);
	}
	
	/**
	 * Show only the menu that was clicked
	 * @param panel
	 */
	public void menuClicked(JPanel panel) {
		PanelHome2.setVisible(false);
		ImportPanel2.setVisible(false);
		ViewPanel2.setVisible(false);
		
		
		panel.setVisible(true);
		
	}
	
	private class PanelButtomMouseAdapter extends MouseAdapter{
		JPanel panel;
		public PanelButtomMouseAdapter(JPanel panel) {
			this.panel = panel;
		}
		
		@Override
		public void mouseEntered(MouseEvent e) {
			panel.setForeground(new Color(112, 128, 144));
		
		}
		@Override
		public void mouseExited(MouseEvent e) {
			panel.setForeground(new Color(47, 79, 79));
			
		}
		
		@Override
		public void mousePressed(MouseEvent e) {
			panel.setForeground(new Color(60, 179, 113));
			
			
		}
		
		@Override
		public void mouseReleased(MouseEvent e) {
			panel.setForeground(new Color(112, 128, 144));
			
		}
	}
}
