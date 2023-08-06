import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;
import static org.junit.jupiter.api.Assertions.*;

import java.awt.Color;
import java.io.File;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.text.ParseException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;

import javax.swing.JCheckBox;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import com.itextpdf.text.DocumentException;

class CalendarEngineTest {
	static CalendarEngine ce;
	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		assertTrue(true);
		assertFalse(false);
		boolean [] arr1 = new boolean[]{true, true};
		assertEquals(arr1,arr1);
		ce = new CalendarEngine();
		
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
	final void testStartCalendar() throws InvocationTargetException, ParseException, IOException, DocumentException, InterruptedException {
		ce.startCalendar();
	}
	
//	final void testScheduleEvent() throws ParseException, IOException {
//		ce.scheduleEvent();
//	}
//	final void testCheckAvaliability() throws ParseException, IOException {
//		User u = new User("André", new File("andre.json"), Color.BLACK);
//		CalendarEvent event = new CalendarEvent(u, LocalDate.of(2022, 12, 16), LocalTime.of(10, 10), LocalTime.of(10, 20), "abc");
//		assertTrue(CalendarEngine.checkAvaliability(u, event));
//	}
//	
//	final void checkToTime() {
//		CalendarEngine.toTime("9:30");
//		
//	}
//	
//	final void checUntilDots() {
//		CalendarEngine.untilDots("9:30");
//	}
//	
//	final void checkAfterDots() {
//		CalendarEngine.afterDots("9:30");
//		
//	}
	void test() {
		//fail("Not yet implemented");
	}

}
