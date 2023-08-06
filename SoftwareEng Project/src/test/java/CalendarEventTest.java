import static org.junit.Assert.assertArrayEquals;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;
import static org.junit.jupiter.api.Assertions.*;

import java.awt.Color;
import java.io.File;
import java.time.LocalDate;
import java.time.LocalTime;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class CalendarEventTest {

	static CalendarEvent ce;
	static User u;
	
	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		u = new User("A", new File ("andre.json"), Color.BLACK);
		ce = new CalendarEvent(u, LocalDate.of(2022, 1,1), LocalTime.of(0, 0), LocalTime.of(0, 0), "abc");
		assertTrue(true);
		assertFalse(false);
		assertEquals(10,10);
		Object [] b1 = {true,true};
		Object [] b2 = {true,true};
		
		assertArrayEquals(b1, b2);
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
	final void checkIsVisible() {
		assertTrue(ce.isVisible());
	}
	
	final void testReturnUser() {
		//assertEquals(ce.getUser(),ce.getUser());
	}
	
	//final void check
	void test() {
		//fail("Not yet implemented");
	}

}
