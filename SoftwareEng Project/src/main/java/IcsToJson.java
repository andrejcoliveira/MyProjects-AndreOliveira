import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import static java.nio.file.StandardCopyOption.REPLACE_EXISTING;
import java.io.FileWriter;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.text.Normalizer;
import java.util.ArrayList;
import java.util.Scanner;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
/**
 * 
 * Class with functions that deal with transforming webcal link to json file
 *
 */
public class IcsToJson {
	
	//Url
	private URL url;

	//Constructor
	/**
	 * Creates new Class
	 * @param link link to connect
	 * @throws MalformedURLException
	 */
	public IcsToJson(String link) throws MalformedURLException {
		this.url = new URL(link.replace("webcal:", "https:"));
	}

	//Get json from ics file
	/**
	 * Gets the json from url and returns a file with it
	 * @param user user
	 * @return A file with json 
	 * @throws IOException
	 */
	public File getJson(String user) throws IOException {

		Files.copy(url.openStream(), Paths.get("icsfile.txt"), REPLACE_EXISTING);
		Scanner scan = new Scanner(new File("icsfile.txt"));
		String startDate = null;
		String endDate = null;

		File file = new File("agenda.txt");

		if (file.exists()) {
			file.delete();
		}

		while (scan.hasNextLine()) {
			BufferedWriter writer = new BufferedWriter(new FileWriter("agenda.txt", true));
			if (scan.nextLine().equals("BEGIN:VEVENT")) {
				scan.nextLine();

				startDate = scan.nextLine().split(":")[1].replace("T", "").replace("Z", "");

				endDate = scan.nextLine().split(":")[1].replace("T", "").replace("Z", "");

				String description = scan.nextLine();

				String line = scan.nextLine();
				if (line.contains("UID:")) {
					description = description + line.strip();
				}
				if (description.contains("Teste:") || description.contains("Exame:")
						|| description.contains("AvaliaÃ§Ã£o ContÃ­nua:")) {
					description = description.split(":")[2] + " - Exame";
					description = description.strip();
				} else {
					description = description.split(":")[1];
				}

				String l = "\n" + description + "\n" + startDate + "\n" + endDate + "\n \n";
				writer.write(l);
				writer.close();
				
			}

		}
		scan.close();
		String a = user.toLowerCase();
		String fileName = Normalizer.normalize(a, Normalizer.Form.NFD).replaceAll("[^\\p{ASCII}]", "") + ".json";
		File finalFile = new File(fileName);
		if (!finalFile.exists()) {
			Gson gson = new GsonBuilder().setPrettyPrinting().create();
			ArrayList<Event> eventos = listEvents(user);
			String json = gson.toJson(eventos);
			FileWriter writer = new FileWriter(fileName);
			writer.write(json);
			writer.close();
		}
		return finalFile;
	}

	//List Event from a user
	/**
	 * Lists the events from a user
	 * @param user user
	 * @return list of events
	 * @throws FileNotFoundException
	 */
	public ArrayList<Event> listEvents(String user) throws FileNotFoundException {

		ArrayList<Event> list = new ArrayList<>();
		Scanner scan = new Scanner(new File("agenda.txt"));

		while (scan.hasNextLine()) {
			scan.nextLine();
			String name = scan.nextLine();
			String dateStart = scan.nextLine();
			String dateEnd = scan.nextLine();
			scan.nextLine();

			Event event = new Event(name, dateStart, dateEnd, user);

			list.add(event);
		}
		scan.close();
		return list;
	}
}