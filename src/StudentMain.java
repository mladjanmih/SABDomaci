import operations.*;
import org.junit.Test;
import student.*;
import tests.TestHandler;
import tests.TestRunner;

import java.math.BigDecimal;
import java.util.Calendar;
import java.util.List;

public class StudentMain {

    public static void main(String[] args) {

        ArticleOperations articleOperations = new mm150423_ArticleOperations(); // Change this for your implementation (points will be negative if interfaces are not implemented).
        BuyerOperations buyerOperations = new mm150423_BuyerOperations();
        CityOperations cityOperations = new mm150423_CityOperations();
        GeneralOperations generalOperations = new mm150423_GeneralOperations();
        OrderOperations orderOperations = new mm150423_OrderOperations();
        ShopOperations shopOperations = new mm150423_ShopOperations();
        TransactionOperations transactionOperations = new mm150423_TransactionOperations();

        int buyerId = 5;//buyerOperations.createBuyer("Mladjan Mihajlovic", 1);
        int orderId = 3;//buyerOperations.createOrder(buyerId);

        TestHandler.createInstance(
                articleOperations,
                buyerOperations,
                cityOperations,
                generalOperations,
                orderOperations,
                shopOperations,
                transactionOperations
        );

        TestRunner.runTests();
    }
}
