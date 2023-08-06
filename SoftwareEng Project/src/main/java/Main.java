import java.awt.EventQueue;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.text.ParseException;

import com.itextpdf.text.DocumentException;
/**
 * 
 * Main Class
 *
 */
public class Main {
	/**
	 * 
	 * @param args arguments to create main function
	 * @throws ParseException
	 * @throws IOException
	 * @throws DocumentException
	 * @throws InvocationTargetException
	 * @throws InterruptedException
	 */
	public static void main(String [] args) throws ParseException, IOException, DocumentException, InvocationTargetException, InterruptedException {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					FrameLogin frame = new FrameLogin();
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
		
	}
}
