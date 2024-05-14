package com.dal;

import java.util.List;

import com.models.Product;

public interface ProductsDAO {

	public List<Product> getProducts();

	public List<Product> getProductsByPage(int page, int pageSize, int offset);
}
