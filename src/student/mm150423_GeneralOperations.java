package student;

import java.sql.*;
import java.util.Calendar;
import java.util.LinkedList;

import operations.GeneralOperations;

public class mm150423_GeneralOperations implements GeneralOperations {
	
	private Calendar currentTime = null;

	@Override
	public Calendar getCurrentTime() {
		return currentTime;
	}

	@Override
	public void setInitialTime(Calendar time) {
		currentTime = time;
	}

	@Override
	public Calendar time(int daysToAdd) {
		if (currentTime == null) {
			return null;
		}

		if (daysToAdd <= 0) {
			return currentTime;
		}

		currentTime.add(Calendar.DATE, daysToAdd);
		return currentTime;
	}


	@Override
	public void eraseAll() {

		try (Connection conn = DriverManager.getConnection(Constants.CONNECTION_STRING)) {
			CallableStatement cs = conn.prepareCall("execute EraseAll");

			cs.execute();
		}
		catch (SQLException e) {

		}
	}
}
