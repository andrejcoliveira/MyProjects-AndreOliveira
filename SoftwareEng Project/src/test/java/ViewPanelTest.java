import static org.junit.Assert.assertArrayEquals;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;
import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class ViewPanelTest {
	static ViewPanel vp;
	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		assertTrue(true);
		assertFalse(false);
		assertEquals(10,10);
		Object [] b1 = {true,true};
		Object [] b2 = {true,true};
		
		assertArrayEquals(b1, b2);
		vp = new ViewPanel();
		assertNotNull(vp);
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
