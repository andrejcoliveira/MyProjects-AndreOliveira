

import java.awt.*;
/**
 * 
 * Creates a Click Event Listener
 *
 */
public class CalendarEventClickEvent extends AWTEvent {

    private CalendarEvent calendarEvent;

    /**
     * Creates a new Calendar Click listener
     * @param source source object
     * @param calendarEvent event
     */
    public CalendarEventClickEvent(Object source, CalendarEvent calendarEvent) {
        super(source, 0);
        this.calendarEvent = calendarEvent;
    }

    /**
     * gets the Calendar Event
     * @return a calendarEvent object
     */
    public CalendarEvent getCalendarEvent() {
        return calendarEvent;
    }
}
