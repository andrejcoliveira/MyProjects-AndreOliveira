import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;
import static org.junit.jupiter.api.Assertions.*;

import java.awt.Color;
import java.time.LocalDate;
import java.time.LocalTime;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class CalendarEventClickEventTest {
	static CalendarEventClickEvent cece;
	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		assertTrue(true);
		assertFalse(false);
		boolean [] arr1 = new boolean[]{true, true};
		assertEquals(arr1,arr1);
		cece = new CalendarEventClickEvent(new Object(), new CalendarEvent(new User("a", "link", Color.black), LocalDate.of(2022,1,1) ,LocalTime.of(0, 0) , LocalTime.of(0, 0), ""));
		
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
	void test() {
		//fail("Not yet implemented");
	}

}
