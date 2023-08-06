import java.awt.Color;
import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

/**
 * 
 * Class User: to crate a single user that can be added to calendar system
 *
 */
public class User {

	private String userName;

	private String link;

	private Color colorPreference;

	private File userFile;

	/**
	 * To get a user using a link
	 * @param userName username
	 * @param link link
	 * @param colorPreference color preference
	 */
	public User(String userName, String link, Color colorPreference) {
		this.link = link;
		this.colorPreference = colorPreference;
		this.userName = userName;
	}
	
	/**
	 * To get a user giving a File
	 * @param userName username
	 * @param userFile user file
	 * @param colorPreference user color
	 */
	public User(String userName, File userFile, Color colorPreference) {
		this.userName = userName;
		this.userFile = userFile;
		this.colorPreference = colorPreference;
	}
	
	/**
	 * Gets the file
	 * @return the user file
	 */
	public File getUserFile() {
		return userFile;
	}
	
	/**
	 * Sets the user file
	 * @param f file to set
	 */
	public void setUserFile(File f) {
		this.userFile = f;
	}

	/**
	 * Gets the Color Preference 
	 * @return Color preference
	 */
	public Color getColorPreference() {
		return colorPreference;
	}
	
	/**
	 * Gets the user link
	 * @return String with link
	 */
	public String getLink() {
		return link;
	}

	/**
	 * Gets Event list from a link
	 * @return events list
	 * @throws ParseException
	 * @throws IOException
	 */
	public ArrayList<Event> getEventListFromLink() throws ParseException, IOException {
		return FillCalendar.returnEventListFromLink(this.link, this.userName);
	}
	
	/**
	 * Gets Event list from a file
	 * @return events list
	 * @throws ParseException
	 * @throws IOException
	 */
	public ArrayList<Event> getEventListFromFile() throws ParseException, IOException {
		return FillCalendar.returnEventListFromFile(this.userFile.getName(), this.userName);
	}

	/**
	 * Gets user Event list
	 * @return CalendarEvent list
	 * @throws ParseException
	 * @throws IOException
	 */
	public ArrayList<CalendarEvent> getCalendarEventList() throws ParseException, IOException {
		ArrayList<CalendarEvent> calendarEvents = new ArrayList<CalendarEvent>();
		ArrayList<Event> events = new ArrayList<>();
		if(this.link == null && this.userFile != null) {
			events = getEventListFromFile();
		}else if(this.userFile == null && this.link != null) {
			events = getEventListFromLink();
		}else {
			events = getEventListFromFile();
		}
		for (Event e : events) {
			LocalDateTime StartDate = toDate(e.getDateStart());
			LocalDateTime EndDate = toDate(e.getDateEnd());

			if (!(StartDate.getYear() == 0 || StartDate.getMonthValue() == 0 || StartDate.getDayOfMonth() == 0
					|| EndDate.getYear() == 0 || EndDate.getMonthValue() == 0 || EndDate.getDayOfMonth() == 0)) {

				calendarEvents.add(new CalendarEvent(this, StartDate.toLocalDate(), StartDate.toLocalTime(), EndDate.toLocalTime(),
						cutAfterTrace(insertPeriodically(e.getName(), "\n", 34))));

			}
		}
		for(CalendarEvent ce: calendarEvents) {
			ce.setColor(colorPreference);
		}
		return calendarEvents;
	}

	/**
	 * Removes "TZ" from String
	 * @param a String to substring
	 * @return String without "TZ"
	 */
	public static String removeTZ(String a) {
		a = a.replaceAll("T", "");
		a = a.replaceAll("Z", "");
		return a;
	}

	/**
	 * COnverts string in LocalDateTime
	 * @param a String to convert
	 * @return LocalDateTime
	 * @throws ParseException
	 */
	public static LocalDateTime toDate(String a) throws ParseException {
		String date = removeTZ(a);
		String pattern = "yyyyMMddHHmmss";
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern(pattern);
		LocalDateTime d = LocalDateTime.parse(date, formatter);
		return d;
	}

	/**
	 * Inserts in String a character all period characters
	 * @param text text to insert
	 * @param insert characters to insert
	 * @param period period characters
	 * @return String
	 */
	public static String insertPeriodically(String text, String insert, int period) {
		StringBuilder builder = new StringBuilder(text.length() + insert.length() * (text.length() / period) + 1);

		int index = 0;
		String prefix = "";
		while (index < text.length()) {
			// Don't put the insert in the very first iteration.
			// This is easier than appending it *after* each substring
			builder.append(prefix);
			prefix = insert;
			builder.append(text.substring(index, Math.min(index + period, text.length())));
			index += period;
		}
		return builder.toString();
	}

	/**
	 * GIves all information until "-"
	 * @param str String to cut
	 * @return String
	 */
	public static String cutAfterTrace(String str) {
		int index = str.indexOf("-");
		if (index >= 0)
			str = str.substring(0, index);
		return str;
	}
	
	/**
	 * Gets the userName
	 * @return userName
	 */
	public String getUserName() {
		return this.userName;
	}
	
	/**
	 * to string method
	 */
	public String toString() {
		return userName;
	}
	
	/**
	 * equals method
	 */
	public boolean equals(Object a) {
		if(((User) a).getUserName().equals(this.getUserName())){
			return true;
		}
		return false;
	}

}
