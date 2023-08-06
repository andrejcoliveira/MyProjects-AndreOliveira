/**
 * 
 * Creates an Event specifically built to insert in a json file
 *
 */
public class Event {
	
	private String name;
	
	private String dateStart;
	
	private String dateEnd;
	
	private String username;

	/**
	 * Contructs a new Event
	 * @param name Event name
	 * @param dateStart event start
	 * @param dateEnd event end
	 * @param username event username
	 */
	public Event(String name, String dateStart, String dateEnd, String username) {
		this.name = name;
		this.dateStart = dateStart;
		this.dateEnd = dateEnd;
		this.username = username;
	}
 
	/**
	 * Default constructor
	 */
	public Event() {
	}

	/**
	 * Gets the username
	 * @return String Username
	 */
	public String getUsername() {
		return username;
	}

	/**
	 * Sets the username
	 * @param username username to set
	 */
	public void setUsername(String username) {
		this.username = username;
	}

/**
 * Gets the Name
 * @return String name
 */
	public String getName() {
		return name;
	}

	/**
	 * Gets start date
	 * @return String start date
	 */
	public String getDateStart() {
		return dateStart;
	}

	/**
	 * Gets the end date
	 * @return String End date
	 */
	public String getDateEnd() {
		return dateEnd;
	}

	/**
	 * To string method
	 */
	public String toString() {
		return "[" + name + " " + dateStart + " " + dateEnd + " " + username + "]";
	}
}
