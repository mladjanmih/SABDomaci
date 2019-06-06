package student;

import java.util.List;

import operations.CityOperations;
import student.managers.CityManager;
import student.managers.ShopManager;

public class mm150423_CityOperations implements CityOperations {

	private CityManager _cityManager = new CityManager();

	@Override
	public int createCity(String cityName) {

		int cityId = _cityManager.createCity(cityName);
		return cityId;
	}

	@Override
	public List<Integer> getCities() {
		return _cityManager.getCities();
	}

	@Override
	public int connectCities(int cityId1, int cityId2, int distance) {
		if (_cityManager.lineExists(cityId1, cityId2)) {
			return -1; //Line exists
		}

		int lineId = _cityManager.createLine(cityId1, cityId2, distance);
		return lineId;
	}

	@Override
	public List<Integer> getConnectedCities(int cityId) {
		List<Integer> connectedCities = _cityManager.getConnectedCities(cityId);
		return connectedCities;
	}

	@Override
	public List<Integer> getShops(int cityId) {
		ShopManager shopManager = new ShopManager();
		List<Integer> shops = shopManager.getShopsInCity(cityId);
		return shops;
	}

}
