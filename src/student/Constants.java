package student;

public class Constants {
	public static final String CONNECTION_STRING = "jdbc:sqlserver://localhost:1433;database=Shop;user=sa;password=mladjan123;";

	public class OrderStatus {
		public static final String CREATED = "created";
		public static final String SENT = "sent";
		public static final String ARRIVED = "arrived";


	}
	
//	public static Connection getConnection() {
//		try {
//			Connection conn = DriverManager.getConnection(connectionString);
//			
//			return conn;
//		}
//		catch (SQLTimeoutException e) {
//			return null;
//		}
//		catch (SQLException e) {
//			return null;
//		}
//		
//		
//	}
//	
//	public static void returnConnection(Connection c) {
//		
//	}
}
