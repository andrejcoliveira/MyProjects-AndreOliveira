import static org.junit.Assert.*;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

public class BarChartTest {

	public static BarChart b1,b2,b3,b4;
	
	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		assertTrue(true);
		assertFalse(false);
		boolean [] arr1 = new boolean[]{true, true};
		boolean [] arr2 = new boolean[]{true, true};
		assertEquals(arr1,arr1);
		b1 = new BarChart("123");
		b2 = new BarChart("123");
		b3 = new BarChart("123");
		b4 = new BarChart("123");
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
