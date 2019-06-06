package student.managers;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

import student.Constants;

public class ShopManager {


	public int getCity(int shopId) {
		try (Connection conn = DriverManager.getConnection(Constants.CONNECTION_STRING)) {
			PreparedStatement st = conn.prepareStatement("select CityId from shop where Id = ?");
			st.setInt(1, shopId);
			ResultSet rs = st.executeQuery();
			if (rs.next()) {
				int id = rs.getInt(1);
				if (id > 0) {
					return id;
				}
				else {
					return -1;
				}
			}
		}
		catch (SQLException e) {
			return -1;
		}

		return -1;
	}


	public boolean exists(int shopId) {
		
		try (Connection conn = DriverManager.getConnection(Constants.CONNECTION_STRING)) {
			PreparedStatement st = conn.prepareStatement("select count(*) from shop where Id = ?");
			st.setInt(1, shopId);
			ResultSet rs = st.executeQuery();
			while(rs.next()) {
				int id = rs.getInt(1);
				if (id > 0) {
					return true;
				}
				else {
					return false;
				}
			}	
		}
		catch (SQLException e) {
			return false;
		}
		
		return false;
	}
	
	public List<Integer> getShopsInCity(int cityId) {
		try (Connection conn = DriverManager.getConnection(Constants.CONNECTION_STRING)) {
			LinkedList<Integer> list = new LinkedList<Integer>();
			PreparedStatement st = conn.prepareStatement("select Id from Shop where CityId = ?");
			st.setInt(1, cityId);			
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
	
	public int createShop(String name, int cityId) {
		try (Connection conn = DriverManager.getConnection(Constants.CONNECTION_STRING)) {
			PreparedStatement st = conn.prepareStatement("insert into Shop(Name, Discount, CityId) values(?,?,?)");
			st.setString(1,  name);
			st.setDouble(2, 0);
			st.setInt(3, cityId);			
			int rows = st.executeUpdate();
			
			if (rows != 1) return -1;
			PreparedStatement query = conn.prepareStatement("select Id from Shop where Name = ? and CityId = ?");
			query.setString(1, name);
			query.setInt(2, cityId);
			ResultSet rs = query.executeQuery();
			if (rs.next()) {
				int shopId = rs.getInt(1);
				return shopId > 0 ? shopId : -1;
			}
		}
		catch (SQLException e) {
			return -1;
		}
		
		return -1;
	}
	
	public int getDiscount(int shopId) {
		try (Connection conn = DriverManager.getConnection(Constants.CONNECTION_STRING)) {
			PreparedStatement query = conn.prepareStatement("select Discount from Shop where Id = ?");
			query.setInt(1, shopId);
			ResultSet rs = query.executeQuery();
			if (rs.next()) {
				int discount = rs.getInt(1);
				return discount;
			}
		}
		catch (SQLException e) {
			return -1;
		}
		
		return -1;
	}
	
	public int setShopCity(int shopId, int cityId) {
		try (Connection conn = DriverManager.getConnection(Constants.CONNECTION_STRING)) {
			PreparedStatement st = conn.prepareStatement("update Shop set CityId = ? where Id = ?");
			st.setInt(1, cityId);
			st.setInt(2, shopId);
			int rows = st.executeUpdate();
			if (rows == 1) {
				return 1;
			}
			return -1;
		}
		catch (SQLException e) {
			return -1;
		}
	}
	
	public int setShopDiscount(int shopId, int discount) {
		try (Connection conn = DriverManager.getConnection(Constants.CONNECTION_STRING)) {
			PreparedStatement st = conn.prepareStatement("update Shop set Discount = ? where Id = ?");
			st.setInt(1, discount);
			st.setInt(2, shopId);
			int rows = st.executeUpdate();
			if (rows == 1) {
				return 1;
			}
			return -1;
		}
		catch (SQLException e) {
			return -1;
		}
	}
	
	public List<Integer> getArticles(int shopId) {
		try (Connection conn = DriverManager.getConnection(Constants.CONNECTION_STRING)) {		
			LinkedList<Integer> list = new LinkedList<Integer>();
			PreparedStatement query = conn.prepareStatement("select Id from Article where ShopId = ?");
			query.setInt(1, shopId);
			
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
}
