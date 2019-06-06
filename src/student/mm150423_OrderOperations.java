package student;

import java.sql.Time;
import java.util.Calendar;
import java.util.List;
import java.math.BigDecimal;

import operations.OrderOperations;
import student.managers.ArticleManager;
import student.managers.OrderManager;

public class mm150423_OrderOperations implements OrderOperations {

	private OrderManager _orderManager = new OrderManager();
	private ArticleManager _articleManager = new ArticleManager();

	@Override
	public int addArticle(int orderId, int articleId, int count) {
		return _orderManager.addArticle(orderId, articleId, count);
	}

	@Override
	public int completeOrder(int orderId) {
		if (!_orderManager.exists(orderId)) {
			return -1;
		}

		return _orderManager.completeOrder(orderId);
	}

	@Override
	public int getBuyer(int orderId) {
		return _orderManager.getBuyer(orderId);
	}

	@Override
	public BigDecimal getDiscountSum(int orderId) {
		return _orderManager.getDiscountSum(orderId);
	}

	@Override
	public BigDecimal getFinalPrice(int orderId) {
		return _orderManager.getFinalPrice(orderId);
	}

	@Override
	public List<Integer> getItems(int orderId) {
		if (!_orderManager.exists(orderId)) {
			return null;
		}

		return _orderManager.getItems(orderId);
	}

	@Override
	public int getLocation(int orderId) {
		return _orderManager.getLocation(orderId);
	}


	@Override
	public String getState(int orderId) {
		return _orderManager.getState(orderId);

	}

	@Override
	public Calendar getSentTime(int orderId) {
		if (!_orderManager.exists(orderId)) {
			return null;
		}

		if (_orderManager.getState(orderId).equals(Constants.OrderStatus.CREATED)) {
			return null;
		}

		return _orderManager.getSentTime(orderId);
	}

	@Override
	public Calendar getRecievedTime(int orderId) {
		if (!_orderManager.exists(orderId)) {
			return null;
		}

		if (_orderManager.getState(orderId).equals(Constants.OrderStatus.ARRIVED)) {
			return null;
		}

		return _orderManager.getRecievedTime(orderId);
	}

	@Override
	public int removeArticle(int orderId, int articleId) {
		if (!_orderManager.exists(orderId) || !_articleManager.exists(articleId) || !_orderManager.itemExists(orderId, articleId)) {
			return -1;
		}

		_orderManager.removeItem(orderId, articleId);
		return 0;
	}

}
