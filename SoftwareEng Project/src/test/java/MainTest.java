import static org.junit.Assert.*;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

public class MainTest {
	static Main m;
	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		assertTrue(true);
		assertFalse(false);
		assertEquals(10,10);
		Object [] b1 = {true,true};
		Object [] b2 = {true,true};
		
		assertArrayEquals(b1, b2);
		m = new Main();
	}

	@AfterClass
	public static void tearDownAfterClass() throws Exception {
	}

	@Before
	public void setUp() throws Exception {
	}

	@After
	public void tearDown() throws Exception {
	}

	@Test
	public void test() {
		//fail("Not yet implemented");
	}

}
