

import java.util.EventListener;
/**
 * 
 * Create single EmptyClickListener interface
 *
 */
public interface CalendarEmptyClickListener extends EventListener {
    // Event dispatch methods
	/**
	 * 
	 * @param e CalendarEmptyClickEvent
	 */
    void calendarEmptyClick(CalendarEmptyClickEvent e);
}
