package student;

import operations.ArticleOperations;
import student.managers.ArticleManager;
import student.managers.ShopManager;

public class mm150423_ArticleOperations implements ArticleOperations {

	@Override
	public int createArticle(int shopId, String articleName, int articlePrice) {
		ShopManager shopManager = new ShopManager();
		ArticleManager articleManager = new ArticleManager();

		if (shopManager.exists(shopId)) {
			int articleId = articleManager.createArticle(shopId, articleName, articlePrice);
			return articleId;
		} else {
			return -1;
		}
	}
}
