package student;

import java.math.BigDecimal;
import java.util.List;

import operations.BuyerOperations;
import student.managers.BuyerManager;
import student.managers.CityManager;
import student.managers.OrderManager;

public class mm150423_BuyerOperations implements BuyerOperations {

	private CityManager _cityManager = new CityManager();
	private BuyerManager _buyerManager = new BuyerManager();
	private OrderManager _orderManager = new OrderManager();

	@Override
	public int createBuyer(String name, int cityId) {
		if (!_cityManager.exists(cityId)) {
			return -1;
		}

		int buyerId = _buyerManager.createBuyer(name, cityId);
		return buyerId;
	}

	@Override
	public int setCity(int buyerId, int cityId) {
		if (!_buyerManager.exists(buyerId) || !_cityManager.exists(cityId)) {
			return -1;
		}

		return _buyerManager.setCity(buyerId, cityId);
	}

	@Override
	public int getCity(int buyerId) {
		if (!_buyerManager.exists(buyerId)) {
			return -1;
		}

		return _buyerManager.getCity(buyerId);
	}

	@Override
	public BigDecimal increaseCredit(int buyerId, BigDecimal credit) {
		BigDecimal zero = new BigDecimal(0);
		if (!_buyerManager.exists(buyerId) || credit.compareTo(zero) <= 0) {
			return null;
		}

		return _buyerManager.increaseCreadit(buyerId, credit);
	}

	@Override
	public int createOrder(int buyerId) {
		if (!_buyerManager.exists(buyerId)) {
			return -1;
		}

		int orderId = _orderManager.createOrder(buyerId);
		return orderId;
	}

	@Override
	public List<Integer> getOrders(int buyerId) {
		if (!_buyerManager.exists(buyerId)) {
			return null;
		}
		return _orderManager.getOrders(buyerId);
	}

	@Override
	public BigDecimal getCredit(int buyerId) {
		if (!_buyerManager.exists(buyerId)) {
			return null;
		}
		return _buyerManager.getCredit(buyerId);
	}
}
