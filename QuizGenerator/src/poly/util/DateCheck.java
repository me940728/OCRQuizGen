package poly.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateCheck {
	public String Date() {

		Date d = new Date();
		SimpleDateFormat date = new SimpleDateFormat("yyyyMMddHHmm");

		String dt = date.format(d);
		String BaseDate = dt.substring(0, 8);
		return BaseDate;
	}

	   public String Time() {
		      Date d = new Date();
		      SimpleDateFormat date = new SimpleDateFormat("yyyyMMddHHmm");
		      Calendar c=Calendar.getInstance();
		      c.setTime(d);
		      c.add(Calendar.MINUTE,-30);   
		      String dt="";
		      dt=date.format(c.getTime());
		      String BaseTime = dt.substring(8);
		      return BaseTime;
		   }
	public String OnlyTime() {
		Date d = new Date();
		SimpleDateFormat date = new SimpleDateFormat("yyyyMMddHHmm");
		
		String dt = date.format(d);
		String onlyTime = dt.substring(8,10);
		return onlyTime;
	}

}
