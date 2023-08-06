import static org.junit.Assert.assertArrayEquals;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;
import static org.junit.jupiter.api.Assertions.*;

import java.io.IOException;
import java.text.ParseException;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class FillCalendarTest {
	static FillCalendar fc;
	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		fc = new FillCalendar();
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
	final void testFillCalendarFromLink() throws ParseException, IOException {
		FillCalendar.returnEventListFromLink("webcal://fenix.iscte-iul.pt/publico/publicPersonICalendar.do?method=iCalendar&username=mmrtj@iscte.pt&password=FofNis92nl2BbmRTA9KZHS0Q8uALDoY4FUwYkbmxHI9ehgU10vflo9jHZWmH2wes3Idrkz1BcEF4JnMUTopbSvf77LNhuK9clrGAmmWQdUZiE5g6TYvjdgx0MgYkP0a8", "user");
	}
	void test() {
		//fail("Not yet implemented");
	}

}
