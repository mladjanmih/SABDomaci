package student.managers;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

import student.Constants;

public class CityManager {
	public int createCity(String name) {
		try (Connection conn = DriverManager.getConnection(Constants.CONNECTION_STRING)) {
			PreparedStatement ps = conn.prepareStatement("insert into City(Name) values(?)");
			ps.setString(1,  name);
			int rowCount = ps.executeUpdate();
			if (rowCount == 0) {
				return -1; //ERROR
			}
			
			PreparedStatement query = conn.prepareStatement("select Id from City where Name = ?");
			query.setString(1, name);
			ResultSet rs = query.executeQuery();
			if (rs.next()) {
				int cityId = rs.getInt(1);
				return cityId > 0 ? cityId : -1;
			}
			
			return -1;						
		}
		catch (SQLException e) {
			return -1;
		}
	}
	
	public boolean lineExists(int cityId1, int cityId2) {
		try (Connection conn = DriverManager.getConnection(Constants.CONNECTION_STRING)) {
			PreparedStatement ps = conn.prepareStatement(
					"select count(*) "
					+ "from Line "
					+ "where (IdCity1 = ? and IdCity2 = ?) "
					+ "or (IdCity1 = ? and IdCity2 = ?)"
					);
			ps.setInt(1, cityId1);
			ps.setInt(2, cityId2);
			ps.setInt(3, cityId2);
			ps.setInt(4, cityId1);
			
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				int count = rs.getInt(1);
				return count == 1;
			}			
		}
		catch (SQLException e) {
			return false;
		}
		
		return false;
	}
	
	public int createLine(int cityId1, int cityId2, int distance) {
		try (Connection conn = DriverManager.getConnection(Constants.CONNECTION_STRING)) {
			PreparedStatement ps = conn.prepareStatement("insert into Line(IdCity1, IdCity2, Distance) values(?, ?, ?)");
			
			ps.setInt(1, cityId1);
			ps.setInt(2, cityId2);
			ps.setInt(3, distance);
			
			int rowCount = ps.executeUpdate();
			if (rowCount == 0) {
				return -1; //ERROR
			}
			
			PreparedStatement query = conn.prepareStatement("select Id from Line where IdCity1 = ? and IdCity2 = ?");
			ResultSet rs = query.executeQuery();
			if (rs.next()) {
				int lineId = rs.getInt(1);
				return lineId > 0 ? lineId : -1;
			}
			
			return -1;						
		}
		catch (SQLException e) {
			return -1;
		}
	}
	
	public int getCityId(String name) {
		try (Connection conn = DriverManager.getConnection(Constants.CONNECTION_STRING)) {		
			PreparedStatement query = conn.prepareStatement("select Id from City where Name = ?");
			query.setString(1, name);
			ResultSet rs = query.executeQuery();
			if (rs.next()) {
				int cityId = rs.getInt(1);
				return cityId > 0 ? cityId : -1;
			}
			
			return -1;						
		}
		catch (SQLException e) {
			return -1;
		}
	}
	
	public List<Integer> getConnectedCities(int cityId) {
		
		try (Connection conn = DriverManager.getConnection(Constants.CONNECTION_STRING)) {		
			LinkedList<Integer> list = new LinkedList<Integer>();
			PreparedStatement query = conn.prepareStatement("select IdCity2 as Id from Line where IdCity1 = ? "
					+ "union "
					+ "select IdCity1 as Id from Line where IdCity2 = ?");
			query.setInt(1, cityId);
			query.setInt(2, cityId);
			ResultSet rs = query.executeQuery();
			while (rs.next()) {
				int id = rs.getInt(1);
				list.add(id);
			}
			
			return list.size() > 0 ? list : null;						
		}
		catch (SQLException e) {
			return null;
		}

	}

	public List<Integer> getCities() {
		try (Connection conn = DriverManager.getConnection(Constants.CONNECTION_STRING)) {
			LinkedList<Integer> list = new LinkedList<Integer>();
			PreparedStatement st = conn.prepareStatement("select Id from City");
			ResultSet rs = st.executeQuery();
			while(rs.next()) {
				int id = rs.getInt(1);
				list.add(id);
			}

			return list.size() > 0 ? list : null;
		}
		catch (SQLException e) {
			return null;
		}
	}

	public boolean exists(String name) {
		try (Connection conn = DriverManager.getConnection(Constants.CONNECTION_STRING)) {		
			PreparedStatement query = conn.prepareStatement("select count(*) from City where Name = ?");
			query.setString(1, name);
			ResultSet rs = query.executeQuery();
			if (rs.next()) {
				int count = rs.getInt(1);
				return count == 1;
			}
			
			return false;						
		}
		catch (SQLException e) {
			return false;
		}
	}

	public boolean exists(int id) {
		try (Connection conn = DriverManager.getConnection(Constants.CONNECTION_STRING)) {
			PreparedStatement query = conn.prepareStatement("select count(*) from City where Id = ?");
			query.setInt(1, id);
			ResultSet rs = query.executeQuery();
			if (rs.next()) {
				int count = rs.getInt(1);
				return count == 1;
			}

			return false;
		}
		catch (SQLException e) {
			return false;
		}
	}
}
