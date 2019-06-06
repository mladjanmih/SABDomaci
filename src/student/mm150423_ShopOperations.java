package student;

import java.util.List;

import operations.ShopOperations;
import student.managers.ArticleManager;
import student.managers.CityManager;
import student.managers.ShopManager;

public class mm150423_ShopOperations implements ShopOperations {
	private final ShopManager _shopManager = new ShopManager();
	private final CityManager _cityManager = new CityManager();
	private final ArticleManager _articleManager = new ArticleManager();
	
	@Override
	public int createShop(String name, String cityName) {
		int cityId =_cityManager.getCityId(cityName);
		if (cityId > 0) {
			int shopId = _shopManager.createShop(name, cityId);
			return shopId;
		}
		return -1;
	}

	@Override
	public List<Integer> getArticles(int shopId) {
		if (!_shopManager.exists(shopId)) {
			return null;
		}
		
		List<Integer> articles = _shopManager.getArticles(shopId);
		return articles;
	}

	@Override
	public int getDiscount(int shopId) {
		int discount = _shopManager.getDiscount(shopId);
		return discount;
	}

	@Override
	public int increaseArticleCount(int articleId, int increment) {


		if (!_articleManager.exists(articleId)) {
			return -1;
		}

		int result = _articleManager.increaseArticleCount(articleId, increment);
		return result;
	}

	@Override
	public int getArticleCount(int articleId) {
		return _articleManager.getArticleCount(articleId);
	}

	@Override
	public int setCity(int shopId, String cityName) {
		int cityId = _cityManager.getCityId(cityName);
		if (cityId > 0) {
			int result = _shopManager.setShopCity(shopId, cityId);
			return result;
		}
		
		return -1;
	}

	@Override
	public int getCity(int shopId) {
		return _shopManager.getCity(shopId);
	}

	@Override
	public int setDiscount(int shopId, int discountPercentage) {
		if (discountPercentage < 0) {
			return -1;
		}		
		
		int result = _shopManager.setShopDiscount(shopId, discountPercentage);
		return result;
	}

}
