package service;

import model.Product;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProductServiceImpl implements ProductService{
    private static Map<Integer, Product> products;

    static {
        products = new HashMap<>();
        products.put(1, new Product(1, "BMW", 500000, "https://www.bmw.vn/content/dam/bmw/common/all-models/3-series/sedan/2021/navigation/bmw-3-series-modellfinder.png"));
        products.put(2, new Product(2, "Toyota", 100000, "https://ssa-api.toyotavn.com.vn/Resources/Images/25275CF3794F02BE7BBEAC0C29C1EF1C.png"));
        products.put(3, new Product(3, "Hyundai", 200000, "https://vcdn-vnexpress.vnecdn.net/2022/05/10/Hyundai-Ioniq-7-7365-1652150950.jpg"));
        products.put(4, new Product(4, "Mercedes", 300000, "https://autopro8.mediacdn.vn/2021/9/7/2021-mercedes-vision-avtr-concept-1-1630963152036798407586.jpg"));
    }

    @Override
    public List<Product> findAll() {
        return new ArrayList<>(products.values());
    }

    @Override
    public void save(Product product) {
        products.put(product.getId(), product);
    }

    @Override
    public Product findById(int id) {
        return products.get(id);
    }

    @Override
    public List<Product> findByName(String name) {
        List<Product> productList = findAll();
        List<Product> newProductList = new ArrayList<>();
        for (int i = 0; i < productList.size(); i++) {
            if (productList.get(i).getName().equals(name)) {
                newProductList.add(productList.get(i));
            }
        }
        return newProductList;
    }

    @Override
    public void update(int id, Product product) {
        products.put(id,product);
    }

    @Override
    public void remove(int id) {
        products.remove(id);
    }
}
