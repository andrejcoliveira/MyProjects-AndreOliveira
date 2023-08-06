import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.ArrayList;
/**
 * 
 * Class that creates a week to insert in calendar
 *
 */
public class Week {

    private ArrayList<LocalDate> days;

     /**
     * Gets week variables from any date (can be within week)
     * @param date date
     */
    public Week(LocalDate date) {
        days = new ArrayList<>();
        LocalDate monday = getStartOfWeek(date);
        days.add(monday);
        for (int i = 1; i < 7; i++) {
            days.add(monday.plusDays(i));
        }
    }
/**
 * Gets the satrt of the Week
 * @param date date
 * @return LocalDate
 */
    public static LocalDate getStartOfWeek(LocalDate date) {
        LocalDate day = date;
        while (day.getDayOfWeek() != DayOfWeek.MONDAY) {
            day = day.minusDays(1);
        }
        return day;
    }
    
    /**
     * Gets LocalDate from DayOfWeek
     * @param dayOfWeek day of the week
     * @return  returns localdate
     */
    public LocalDate getDay(DayOfWeek dayOfWeek) {
        // DayOfWeek enum starts with monday == 1
        return days.get(dayOfWeek.getValue() - 1);
    }

    /**
     * Gets next week
     * @return Week
     */
    public Week nextWeek() {
        final LocalDate friday = getDay(DayOfWeek.FRIDAY);
        return new Week(friday.plusDays(3));
    }

    /**
     * Gets previous week
     * @return Week
     */
    public Week prevWeek() {
        final LocalDate monday = getDay(DayOfWeek.MONDAY);
        return new Week(monday.minusDays(3));
    }

    /**
     * To string method
     */
    public String toString() {
        return "Week of the " + getDay(DayOfWeek.MONDAY);
    }
}
