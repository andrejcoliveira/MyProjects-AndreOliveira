import static org.junit.jupiter.api.Assertions.*;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.ArrayList;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class WeekCalendarTest {
	
	static WeekCalendar w1,w2,w3,w4;

	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		ArrayList<CalendarEvent> w1_l = new ArrayList<>();
		ArrayList<CalendarEvent> w2_l = new ArrayList<>();
		ArrayList<CalendarEvent> w3_l = new ArrayList<>();
		ArrayList<CalendarEvent> w4_l = new ArrayList<>();
		w1 = new WeekCalendar(w1_l);
		w2 = new WeekCalendar(w2_l);
		w3 = new WeekCalendar(w3_l);
		w4 = new WeekCalendar(w4_l);
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
	}

	@BeforeEach
	void setUp() throws Exception {
	}

	@AfterEach
	void tearDown() throws Exception {
	}

	@Test
	final void testDateInRange() {
		assertEquals(w1.dateInRange(LocalDate.now()), true);
		assertEquals(w2.dateInRange(LocalDate.now()), true);
		assertEquals(w3.dateInRange(LocalDate.now()), true);
		assertEquals(w4.dateInRange(LocalDate.now()), true);
	}
	
	final void test() {
		//Assertions.assertNotNull(w1);
		//assertEquals(w1.getStartDay(), DayOfWeek.MONDAY);
		
		//Assertions.assertNotNull(w2);
		//assertEquals(w2.getStartDay(), DayOfWeek.MONDAY);
		
		//Assertions.assertNotNull(w3);
		//assertEquals(w3.getStartDay(), DayOfWeek.MONDAY);
		
		//Assertions.assertNotNull(w4);
		//assertEquals(w4.getStartDay(), DayOfWeek.MONDAY);
	}

}
