

import java.util.EventListener;

/**
 * 
 * Creates a Event Click listener interface
 *
 */
public interface CalendarEventClickListener extends EventListener {
    // Event dispatch methods
	/**
	 * Create the calendar event click
	 * @param e CalendarEventClick
	 */
    void calendarEventClick(CalendarEventClickEvent e);
}
