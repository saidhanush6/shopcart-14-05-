package com.dal;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.db.ConnectionClass;
import com.models.Product;
import com.models.Productprice;

public class ProductListDAL implements ProductsDAO {
    public List<Product> getProducts() {
        List<Product> productList = new ArrayList<>();
        String sql = "SELECT * FROM dhanush_products";
        try {
            ConnectionClass ob = new ConnectionClass();
            Connection conn = ob.getconnectDb();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            // Iterate over the result set and create Product objects
            while (rs.next()) {
                Product product = new Product();
                product.setProd_id(rs.getInt("Prod_id"));
                product.setProd_title(rs.getString("Prod_title"));
                product.setProd_prct_id(rs.getInt("Prod_prct_id"));
                product.setProd_hsnc_id(rs.getInt("Prod_hsnc_id"));
                product.setProd_brand(rs.getString("Prod_brand"));
                product.setProd_image(rs.getString("Prod_image"));
                product.setProd_price(rs.getInt("Prod_price"));
                productList.add(product);
            }
            
           
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println(e);
        }
        return productList;
    }

    public List<Product> getProductsByPage(int page, int pageSize, int offset) {
        List<Product> productList = new ArrayList<>();
        String sql = "SELECT * FROM dhanush_products LIMIT " + pageSize + " OFFSET " + offset;
        try {
            ConnectionClass ob = new ConnectionClass();
            Connection conn = ob.getconnectDb();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            // Iterate over the result set and create Product objects
            while (rs.next()) {
                Product product = new Product();
                product.setProd_id(rs.getInt("Prod_id"));
                product.setProd_title(rs.getString("Prod_title"));
                product.setProd_prct_id(rs.getInt("Prod_prct_id"));
                product.setProd_hsnc_id(rs.getInt("Prod_hsnc_id"));
                product.setProd_brand(rs.getString("Prod_brand"));
                product.setProd_image(rs.getString("Prod_image"));
                product.setProd_price(rs.getInt("Prod_price"));
                productList.add(product);
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println(e);
        }
        return productList;
    }
    
    
}
