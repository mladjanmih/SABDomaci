package student.managers;

import student.Constants;

import java.math.BigDecimal;
import java.sql.*;
import java.util.Calendar;
import java.util.LinkedList;
import java.util.List;

public class OrderManager {

    public boolean exists(int orderId) {
        try (Connection conn = DriverManager.getConnection(Constants.CONNECTION_STRING)) {
            PreparedStatement query = conn.prepareStatement("select count(*) from dbo.[Order] where Id = ?");
            query.setInt(1, orderId);
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

    public boolean itemExists(int orderId, int articleId) {
        try (Connection conn = DriverManager.getConnection(Constants.CONNECTION_STRING)) {
            PreparedStatement query = conn.prepareStatement("select count(*) from OrderItem where OrderId = ? and ArticleId = ?");
            query.setInt(1, orderId);
            query.setInt(2, articleId);
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

    public int removeItem(int orderId, int articleId) {
        try (Connection conn = DriverManager.getConnection(Constants.CONNECTION_STRING)) {
            PreparedStatement ps = conn.prepareStatement("delete from OrderItem where OrderId = ? and ArticleId = ?");
            ps.setInt(1,  orderId);
            ps.setInt(2, articleId);
            int rowCount = ps.executeUpdate();
            if (rowCount == 0) {
                return -1; //ERROR
            }

            return 1;
        }
        catch (SQLException e) {
            return -1;
        }
    }


    public int completeOrder(int orderId) {
        try (Connection conn = DriverManager.getConnection(Constants.CONNECTION_STRING)) {
            int itemId = 0;
            CallableStatement cs = conn.prepareCall("exec ? = dbo.CompleteOrder ?");
            cs.registerOutParameter(1, Types.INTEGER);
            cs.setInt(2, orderId);
            cs.execute();
            int retVal = cs.getInt(1);
            if (retVal != 0) {
                return -1;
            }
            else {
                return 1;
            }
        }
        catch (SQLException e) {
            return -1;
        }
    }

    public int getBuyer(int orderId) {
        try (Connection conn = DriverManager.getConnection(Constants.CONNECTION_STRING)) {

            PreparedStatement query = conn.prepareStatement("select BuyerId from dbo.[Order] where Id = ? order by Id desc");
            query.setInt(1, orderId);
            ResultSet rs = query.executeQuery();
            if (rs.next()) {
                int buyerId = rs.getInt(1);
                return buyerId > 0 ? buyerId : -1;
            }

            return -1;
        }
        catch (SQLException e) {
            return -1;
        }
    }


    public int addArticle(int orderId, int articleId, int count) {
        try (Connection conn = DriverManager.getConnection(Constants.CONNECTION_STRING)) {
            int itemId = 0;
            CallableStatement cs = conn.prepareCall("exec dbo.CanAddArticle ?, ?, ?, ?");
            cs.registerOutParameter(4, Types.INTEGER);
            cs.setInt(1, orderId);
            cs.setInt(2, articleId);
            cs.setInt(3, count);
            cs.execute();

            itemId = cs.getInt(4);
            return itemId;
        }
        catch (SQLException e) {
            return -1;
        }
    }

    public int createOrder(int buyerId) {
        try (Connection conn = DriverManager.getConnection(Constants.CONNECTION_STRING)) {
            PreparedStatement ps = conn.prepareStatement("insert into dbo.[Order](BuyerId, State, Price, ItemsGathered, DaysLeftToArrive) values(?, 'created', 0, 0, 0)");
            ps.setInt(1,  buyerId);
            int rowCount = ps.executeUpdate();
            if (rowCount == 0) {
                return -1; //ERROR
            }

            PreparedStatement query = conn.prepareStatement("select Id from dbo.[Order] where BuyerId = ? order by Id desc");
            query.setInt(1, buyerId);
            ResultSet rs = query.executeQuery();
            if (rs.next()) {
                int orderId= rs.getInt(1);
                return orderId> 0 ? orderId : -1;
            }

            return -1;
        }
        catch (SQLException e) {
            return -1;
        }
    }

    public LinkedList<Integer> getOrders(int buyerId) {
        LinkedList<Integer> orders = new LinkedList<>();

        try (Connection conn = DriverManager.getConnection(Constants.CONNECTION_STRING)) {

            PreparedStatement query = conn.prepareStatement("select Id from dbo.[Order] where BuyerId = ?");
            query.setInt(1, buyerId);
            ResultSet rs = query.executeQuery();
            while (rs.next()) {
                int orderId= rs.getInt(1);
                orders.add(orderId);


            }
            return orders.size() > 0 ? orders : null;
        }
        catch (SQLException e) {
            return null;
        }
    }

    public BigDecimal getDiscountSum(int orderId) {
        BigDecimal errorResult = new BigDecimal(-1);
        try (Connection conn = DriverManager.getConnection(Constants.CONNECTION_STRING)) {
            PreparedStatement query = conn.prepareStatement("select Status, Discount from dbo.[Order] where Id = ?");
            query.setInt(1, orderId);
            ResultSet rs = query.executeQuery();
            if (rs.next()) {
                String status = rs.getString(1);
                if (status.compareTo(Constants.OrderStatus.CREATED) == 0) {
                    return errorResult;
                }

                BigDecimal discount = rs.getBigDecimal(2);
                return discount;
            }

            return errorResult;
        }
        catch (SQLException e) {
            return errorResult;
        }
    }

    public BigDecimal getFinalPrice(int orderId) {
        BigDecimal errorResult = new BigDecimal(-1);
        try (Connection conn = DriverManager.getConnection(Constants.CONNECTION_STRING)) {
            PreparedStatement query = conn.prepareStatement("select Status, Price from dbo.[Order] where Id = ?");
            query.setInt(1, orderId);
            ResultSet rs = query.executeQuery();
            if (rs.next()) {
                String status = rs.getString(1);
                if (status.compareTo(Constants.OrderStatus.CREATED) == 0) {
                    return errorResult;
                }

                BigDecimal price = rs.getBigDecimal(2);
                return price;
            }

            return errorResult;
        }
        catch (SQLException e) {
            return errorResult;
        }
    }

    public String getState(int orderId) {
        try (Connection conn = DriverManager.getConnection(Constants.CONNECTION_STRING)) {
            PreparedStatement query = conn.prepareStatement("select Status from dbo.[Order] where Id = ?");
            query.setInt(1, orderId);
            ResultSet rs = query.executeQuery();
            if (rs.next()) {
                String status = rs.getString(1);
                return status;
            }

            return null;
        }
        catch (SQLException e) {
            return null;
        }
    }

    public List<Integer> getItems(int orderId) {
        try (Connection conn = DriverManager.getConnection(Constants.CONNECTION_STRING)) {
            LinkedList<Integer> list = new LinkedList<Integer>();
            PreparedStatement query = conn.prepareStatement("select Id from OrderItem where OrderId = ?");
            query.setInt(1, orderId);

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

    public int getLocation(int orderId) {
        try (Connection conn = DriverManager.getConnection(Constants.CONNECTION_STRING)) {
            PreparedStatement query = conn.prepareStatement("select CurrentCityId from dbo.[Order] where Id = ?");
            query.setInt(1, orderId);
            ResultSet rs = query.executeQuery();
            if (rs.next()) {
                int location = rs.getInt(1);
                return location;
            }

            return -1;
        }
        catch (SQLException e) {
            return -1;
        }
    }

    public Calendar getRecievedTime(int orderId) {
        try (Connection conn = DriverManager.getConnection(Constants.CONNECTION_STRING)) {
            PreparedStatement query = conn.prepareStatement("select ReceivedTime from dbo.[Order] where Id = ?");
            query.setInt(1, orderId);
            ResultSet rs = query.executeQuery();
            if (rs.next()) {
                 Timestamp timestamp = rs.getTimestamp(1);
                 if (timestamp == null) {
                     return null;
                 }
                 Calendar c = Calendar.getInstance();
                 c.setTimeInMillis(timestamp.getTime());

                return c;
            }

            return null;
        }
        catch (SQLException e) {
            return null;
        }
    }

    public Calendar getSentTime(int orderId) {
        try (Connection conn = DriverManager.getConnection(Constants.CONNECTION_STRING)) {
            PreparedStatement query = conn.prepareStatement("select SentTime from dbo.[Order] where Id = ?");
            query.setInt(1, orderId);
            ResultSet rs = query.executeQuery();
            if (rs.next()) {
                Timestamp timestamp = rs.getTimestamp(1);
                if (timestamp == null) {
                    return null;
                }
                Calendar c = Calendar.getInstance();
                c.setTimeInMillis(timestamp.getTime());

                return c;
            }

            return null;
        }
        catch (SQLException e) {
            return null;
        }
    }
}
