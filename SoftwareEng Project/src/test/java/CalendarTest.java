import static org.junit.jupiter.api.Assertions.*;

import java.awt.Point;
import java.time.LocalTime;
import java.util.ArrayList;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;




class CalendarTest {
	
	static Calendar c1,c2,c3,c4;
	
	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		ArrayList<CalendarEvent> w1_l = new ArrayList<>();
		ArrayList<CalendarEvent> w2_l = new ArrayList<>();
		ArrayList<CalendarEvent> w3_l = new ArrayList<>();
		ArrayList<CalendarEvent> w4_l = new ArrayList<>();
		c1 = new WeekCalendar(w1_l);
		c2 = new WeekCalendar(w2_l);
		c3 = new WeekCalendar(w3_l);
		c4 = new WeekCalendar(w4_l);
		
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
	final void testRoundTime() {
		LocalTime l = LocalTime.of(0, 0);
		assertEquals(Calendar.roundTime(l, 1),l);
	}
	
	final void testCheckCalendarEmptyClick() {
		//assertEquals(Calendar.checkCalendarEmptyClick(new Point(0,0)), true);
	}
	void test() {
	}

}
