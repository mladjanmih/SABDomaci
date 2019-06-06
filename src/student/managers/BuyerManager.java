package student.managers;

import student.Constants;

import java.math.BigDecimal;
import java.sql.*;

public class BuyerManager {

    public boolean exists(int buyerId) {
        try (Connection conn = DriverManager.getConnection(Constants.CONNECTION_STRING)) {
            PreparedStatement query = conn.prepareStatement("select count(*) from Buyer where Id = ?");
            query.setInt(1, buyerId);
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

    public int createBuyer(String name, int cityId) {
        try (Connection conn = DriverManager.getConnection(Constants.CONNECTION_STRING)) {
            PreparedStatement ps = conn.prepareStatement("insert into Buyer(Name, CityId, Balance) values(?, ?, 0)");
            ps.setString(1,  name);
            ps.setInt(2, cityId);
            int rowCount = ps.executeUpdate();
            if (rowCount == 0) {
                return -1; //ERROR
            }

            PreparedStatement query = conn.prepareStatement("select Id from Buyer where Name = ? and CityId = ? order by Id desc");
            query.setString(1, name);
            query.setInt(2, cityId);
            ResultSet rs = query.executeQuery();
            if (rs.next()) {
                int buyerId = rs.getInt(1);
                if (buyerId > 0) return buyerId;
            }

            return -1;
        }
        catch (SQLException e) {
            return -1;
        }
    }

    public int setCity(int buyerId, int cityId) {
        try (Connection conn = DriverManager.getConnection(Constants.CONNECTION_STRING)) {
            PreparedStatement st = conn.prepareStatement("update Buyer set CityId = ? where Id = ?");
            st.setInt(1, cityId);
            st.setInt(2, buyerId);
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

    public int getCity(int buyerId) {
        try (Connection conn = DriverManager.getConnection(Constants.CONNECTION_STRING)) {
            PreparedStatement st = conn.prepareStatement("select CityId from Buyer where Id = ?");
            st.setInt(1, buyerId);
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

    public BigDecimal increaseCreadit(int buyerId, BigDecimal creditIncrement) {
        try (Connection conn = DriverManager.getConnection(Constants.CONNECTION_STRING)) {
            PreparedStatement st = conn.prepareStatement("select Balance from Buyer where Id = ?");
            st.setInt(1, buyerId);
            ResultSet rs = st.executeQuery();
            BigDecimal credit = null;
            if (rs.next()) {
                credit = rs.getBigDecimal(1);
            }
            else {
                return null;
            }

            rs.close();
            credit = credit.add(creditIncrement);
            PreparedStatement up = conn.prepareStatement("update Buyer set Balance = ? where Id = ?");
            up.setBigDecimal(1, credit);
            up.setInt(2, buyerId);
            int affectedRowsCount = up.executeUpdate();
            if (affectedRowsCount == 1) {
                return credit;
            }
            else {
                return null;
            }

        }
        catch (SQLException e) {
            return null;
        }

    }

    public BigDecimal getCredit(int buyerId) {
        try (Connection conn = DriverManager.getConnection(Constants.CONNECTION_STRING)) {
            PreparedStatement st = conn.prepareStatement("select Balance from Buyer where Id = ?");
            st.setInt(1, buyerId);
            ResultSet rs = st.executeQuery();
            BigDecimal credit = null;
            if (rs.next()) {
                credit = rs.getBigDecimal(1);
                return credit;
            }
            else {
                return null;
            }
        }
        catch (SQLException e) {
            return null;
        }
    }
}
