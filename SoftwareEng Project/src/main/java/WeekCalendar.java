import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.ArrayList;
/**
 * 
 * Week Calendar class
 *  *
 */
public class WeekCalendar extends Calendar {
	
	
    private Week week;

    /**
     * Crates week calendar
     * @param events events list
     */
    public WeekCalendar(ArrayList<CalendarEvent> events) {
        super(events);
        week = new Week(LocalDate.now());
    }

    @Override
    public boolean dateInRange(LocalDate date) {
        return Week.getStartOfWeek(date).equals(week.getDay(DayOfWeek.MONDAY));
    }

    @Override
    protected LocalDate getDateFromDay(DayOfWeek day) {
        return week.getDay(day);
    }

    @Override
    protected int numDaysToShow() {
        return 7;
    }

    @Override
    protected DayOfWeek getStartDay() {
        return DayOfWeek.MONDAY;
    }

    @Override
    protected DayOfWeek getEndDay() {
        return DayOfWeek.SUNDAY;
    }

    @Override
    protected void setRangeToToday() {
        week = new Week(LocalDate.now());
    }

    @Override
    protected double dayToPixel(DayOfWeek dayOfWeek) {
        return TIME_COL_WIDTH + getDayWidth() * (dayOfWeek.getValue() - 1);
    }

    /**
     * Gets the nexts week
     */
    public void nextWeek() {
        week = week.nextWeek();
        repaint();
    }

    /**
     * Gets the previous week
     */
    public void prevWeek() {
        week = week.prevWeek();
        repaint();
    }

    /**
     * Gets the next month
     */
    public void nextMonth() {
        week = new Week(week.getDay(DayOfWeek.MONDAY).plusWeeks(4));
        repaint();
    }

    /**
     * Gets the previous month
     */
    public void prevMonth() {
        week = new Week(week.getDay(DayOfWeek.MONDAY).minusWeeks(4));
        repaint();
    }

}
