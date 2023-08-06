import org.junit.platform.suite.api.SelectClasses;
import org.junit.platform.suite.api.Suite;

@Suite
@SelectClasses({ BarChartTest.class, CalendarEmptyClickEventTest.class, CalendarEngineTest.class,
		CalendarEventClickEventTest.class, CalendarEventTest.class, CalendarTest.class, EventTest.class,
		FillCalendarTest.class, FrameDashboardTest.class, FrameLoginTest.class, IcsToJsonTest.class,
		ImportPanelTest.class, JFrameToPDFTest.class, MainTest.class, MongoDBTest.class, PanelHomeTest.class,
		ViewPanelTest.class, WeekCalendarTest.class })
public class AllTests {

}
