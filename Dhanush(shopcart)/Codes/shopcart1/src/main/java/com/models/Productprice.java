package com.models;

public class Productprice {

	int prod_id ;
    String prod_batchno ;
    int prod_price;
	int prod_stock;
    int prod_mrp;
    
    public Productprice() {
		
	}

	public Productprice(int prod_id, String prod_batchno, int prod_price, int prod_stock, int prod_mrp) {
		super();
		this.prod_id = prod_id;
		this.prod_batchno = prod_batchno;
		this.prod_price = prod_price;
		this.prod_stock = prod_stock;
		this.prod_mrp = prod_mrp;
	}

	public int getProd_id() {
		return prod_id;
	}

	public void setProd_id(int prod_id) {
		this.prod_id = prod_id;
	}

	public String getProd_batchno() {
		return prod_batchno;
	}

	public void setProd_batchno(String prod_batchno) {
		this.prod_batchno = prod_batchno;
	}

	public int getProd_price() {
		return prod_price;
	}

	public void setProd_price(int prod_price) {
		this.prod_price = prod_price;
	}

	public int getProd_stock() {
		return prod_stock;
	}

	public void setProd_stock(int prod_stock) {
		this.prod_stock = prod_stock;
	}

	public int getProd_mrp() {
		return prod_mrp;
	}

	public void setProd_mrp(int prod_mrp) {
		this.prod_mrp = prod_mrp;
	}
    
}
