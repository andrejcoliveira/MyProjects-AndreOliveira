import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import javax.imageio.ImageIO;
import javax.swing.JFrame;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.pdf.PdfWriter;

/**
 * 
 * Class with functions that deal with transforming a Frame into a PDF
 *
 */

public class JFrameToPDF {
	/**
	 * Generates a PDF with a given frame
	 * @param frame frame to pass to PDF
	 * @throws IOException 
	 * @throws DocumentException
	 */
	public static void ToPDF(JFrame frame) throws IOException, DocumentException {
		BufferedImage image = new BufferedImage(frame.getWidth(), frame.getHeight(), BufferedImage.TYPE_INT_RGB);
		Graphics2D graph2d = image.createGraphics();
		frame.printAll(graph2d);
		graph2d.dispose();
		ImageIO.write(image, "png", new File("calendarImage.png"));
		Document pdfDocument1 = new Document(PageSize.A2.rotate(), 0, frame.getHeight(), 0, frame.getWidth());
		PdfWriter.getInstance(pdfDocument1, new FileOutputStream("HelloPdf.pdf"));
		pdfDocument1.open();
		pdfDocument1.add(com.itextpdf.text.Image.getInstance("calendarImage.png"));
		pdfDocument1.close();
	}
}
