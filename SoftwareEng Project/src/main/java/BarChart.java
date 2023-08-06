
import javax.swing.JFrame;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartPanel;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.data.category.DefaultCategoryDataset;
/**
 * 
 * Class to create a Bar Chart
 *
 */
public class BarChart extends JFrame {
	
	private static final long serialVersionUID = 1L;
	private DefaultCategoryDataset dataset = new DefaultCategoryDataset();
	/**
	 * Constructs a BarChart to represent the information of avaliability 
	 * from a Calendar
	 * @param appTitle Title to give to the app
	 */
	public BarChart(String appTitle) {
		super(appTitle);
		// Create chart
		
		JFreeChart chart = ChartFactory.createBarChart("Percentagem de Ocupação diária", // Chart Title
				"User", // Category axis
				"Percentagem de ocupação do dia", // Value axis
				dataset, PlotOrientation.VERTICAL, true, true, false);

		ChartPanel panel = new ChartPanel(chart);
		setContentPane(panel);
	}

	/**
	 * Adds to Data Set the values
	 * @param value
	 * @param user
	 * @param day
	 */
	public void addToDataSet(double value, String user, String day) {
		dataset.addValue(value, user, day);
	}
}
