package student.managers;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import student.Constants;

public class ArticleManager {
	
	public int createArticle(int shopId, String articleName, int articlePrice) {
		try (Connection conn = DriverManager.getConnection(Constants.CONNECTION_STRING)) {
			PreparedStatement ps = conn.prepareStatement("insert into article(ShopId, Name, Price) values(?,?,?)");
			ps.setInt(1, shopId);
			ps.setString(2, articleName);
			ps.setInt(3, articlePrice);
			
			int rowCount = ps.executeUpdate();		
			if (rowCount != 1) {
				return -1;
			}
			
			PreparedStatement query = conn.prepareStatement("select Id from article where ShopId = ? and Name = ?");
			query.setInt(1, shopId);
			query.setString(2, articleName);
			
			ResultSet rs = query.executeQuery();
			if (rs.next()) {
				int id = rs.getInt(1);
				return id > 0 ? id : -1;
			}
			
		}
		catch (SQLException e) {
			return -1;
		}
		
		return -1;
	}
	
	public int getArticleCount(int articleId) {
		try (Connection conn = DriverManager.getConnection(Constants.CONNECTION_STRING)) {
			PreparedStatement query = conn.prepareStatement("select Count from Article where Id = ?");
			query.setInt(1, articleId);
			ResultSet rs = query.executeQuery();
			if (rs.next()) {
				int id = rs.getInt(1);
				return id >= 0 ? id : -1;
			}		
		}
		catch (SQLException e) {
			return -1;
		}
		
		return -1;
	}
	
	public boolean exists(int articleId) {
		try (Connection conn = DriverManager.getConnection(Constants.CONNECTION_STRING)) {
			PreparedStatement query = conn.prepareStatement("select count(*) from Article where Id = ?");
			query.setInt(1, articleId);

			ResultSet rs = query.executeQuery();
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
	
	public int increaseArticleCount(int articleId, int increment) {
		try (Connection conn = DriverManager.getConnection(Constants.CONNECTION_STRING)) {
			//Getting current article count
			int count = 0;
			PreparedStatement query = conn.prepareStatement("select Count from Article where Id = ?");
			query.setInt(1, articleId);
			try(ResultSet rs = query.executeQuery()) {
				if (rs.next()) {
					count = rs.getInt(1);
				}
				else {
					return -1;
				}
			}
			
			//Updating article count
			count += increment;
			PreparedStatement st = conn.prepareStatement("update Article set Count = ? where Id = ?");
			st.setInt(1, count);
			st.setInt(2, articleId);
			int rows = st.executeUpdate();
			if (rows == 1) {
				return count;
			}
			return -1;
		}
		catch (SQLException e) {
			return -1;
		}
	}
}
