
import java.awt.Color;
import java.io.*;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import org.bson.Document;
import org.bson.conversions.Bson;

import com.mongodb.MongoWriteException;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;

import java.util.ArrayList;
import java.util.Random;
import java.util.stream.Collectors;

/**
 * 
 * Class to deal with MOngoDB funtions
 *
 */
public class MongoDB {

	// conectar mongoDB
	private static MongoClient client = MongoClients
			.create("mongodb+srv://testUser:BolaRebola@projesgrupo18.4wd7mpv.mongodb.net/?retryWrites=true&w=majority");

	private static MongoDatabase db = client.getDatabase("schedule");

	private static MongoCollection<org.bson.Document> collection = db.getCollection("week");

	/**
	 * Constructor
	 */
	public MongoDB() {
		
	}
	
	/**
	 * Gets users list form db
	 * @return list with users
	 * @throws IOException
	 */
	public ArrayList<User> getUsers() throws IOException {
		ArrayList<String> userIDs = new ArrayList<>();
		FindIterable<Document> iterobj = collection.find();
		MongoCursor<Document> itr = iterobj.iterator();
		while(itr.hasNext()) {
			Document doc = itr.next();
			String s = doc.getString("_id");
			userIDs.add(s);
		}
		ArrayList<User> users = new ArrayList<>();
		for(String s: userIDs) {
			File f = outputData(s);
			Random rand = new Random();
			float r = rand.nextFloat();
			float g = rand.nextFloat();
			float b = rand.nextFloat();
			
			User user = new User(s,f,new Color(r,g,b));
			users.add(user);
		}
		return users;
	}


	/**
	 * Imports a file to DB
	 * @param filename name file
	 * @throws IOException
	 */
	public static void importData(String filename) throws IOException {

		BufferedReader reader = new BufferedReader(new FileReader(filename));

		try {

			String[] n = filename.split("\\.");

			String json;
			json = reader.lines().collect(Collectors.joining("\n"));


			Document sampleDoc = new Document("_id", n[0]).append("name", json);

			FindIterable<Document> iterobj = collection.find();

			// Print the documents using iterators
			MongoCursor<Document> itr = iterobj.iterator();
			if(!itr.hasNext()) {
				collection.insertOne(sampleDoc);
				System.out.println("Documento inserido");
			}
			while (itr.hasNext()) {
				
				Document doc = itr.next();
				String s = doc.toString();

				if (s.contains("_id=" + n[0])) {
					Bson filter = Filters.eq("_id", n[0]);
					collection.findOneAndReplace(filter, sampleDoc);
					System.out.println("Documento substituido");
				} else if(!itr.hasNext()){			
					collection.insertOne(sampleDoc);
					System.out.println("Documento inserido");
				}
			}

		} catch (MongoWriteException e) {
			System.out.println(e.getMessage());
		} finally {
			reader.close();
		}

	}
	
	/**
	 * Exports a file from DB
	 * @param name name
	 * @return a File from DB
	 * @throws IOException
	 */
	public File outputData(String name) throws IOException {
		FindIterable<Document> iterobj = collection.find();

		// Print the documents using iterators
		MongoCursor<Document> itr = iterobj.iterator();
		String json=null;
		while (itr.hasNext()) {
			
			Document doc = itr.next();
			String s = doc.toString();

			if (s.contains("_id=" + name)) {
				json=doc.getString("name");
			} 
		
		}
		
		FileWriter fw= new FileWriter(name+".json");
		fw.write(json);
		fw.close();
		File f= new File(name+".json");
		return f;
	}
	
}