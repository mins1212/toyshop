// 취업 기원해요!!!
package toy.shopping;

import java.sql.Timestamp;
import java.util.List;

public class BuyDataBean {
	
	private int buy_id;
	private String buyer;
	private int toy_id;
	private int toy_price;
	private int toy_count;
	private String toy_image;
	private Timestamp buy_date;
	private String buyer_account;
	private String deliveryName;
	private String deliveryTel;
	private String deliveryAddress;
	private String deliveryText;
	private String sanction;
	private List<CartDataBean> cartList;
	
	public int getBuy_id() {
		return buy_id;
	}
	public void setBuy_id(int buy_id) {
		this.buy_id = buy_id;
	}
	public String getBuyer() {
		return buyer;
	}
	public void setBuyer(String buyer) {
		this.buyer = buyer;
	}
	public int getToy_id() {
		return toy_id;
	}
	public void setToy_id(int toy_id) {
		this.toy_id = toy_id;
	}
	public int getToy_price() {
		return toy_price;
	}
	public void setToy_price(int toy_price) {
		this.toy_price = toy_price;
	}
	public int getToy_count() {
		return toy_count;
	}
	public void setToy_count(int toy_count) {
		this.toy_count = toy_count;
	}
	public String getToy_image() {
		return toy_image;
	}
	public void setToy_image(String toy_image) {
		this.toy_image = toy_image;
	}
	public Timestamp getBuy_date() {
		return buy_date;
	}
	public void setBuy_date(Timestamp buy_date) {
		this.buy_date = buy_date;
	}
	public String getBuyer_account() {
		return buyer_account;
	}
	public void setBuyer_account(String buyer_account) {
		this.buyer_account = buyer_account;
	}
	public String getDeliveryName() {
		return deliveryName;
	}
	public void setDeliveryName(String deliveryName) {
		this.deliveryName = deliveryName;
	}
	public String getDeliveryTel() {
		return deliveryTel;
	}
	public void setDeliveryTel(String deliveryTel) {
		this.deliveryTel = deliveryTel;
	}
	public String getDeliveryAddress() {
		return deliveryAddress;
	}
	public void setDeliveryAddress(String deliveryAddress) {
		this.deliveryAddress = deliveryAddress;
	}
	public String getDeliveryText() {
		return deliveryText;
	}
	public void setDeliveryText(String deliveryText) {
		this.deliveryText = deliveryText;
	}
	public String getSanction() {
		return sanction;
	}
	public void setSanction(String sanction) {
		this.sanction = sanction;
	}
	public List<CartDataBean> getCartList() {
		return cartList;
	}
	public void setCartList(List<CartDataBean> cartList) {
		this.cartList = cartList;
	}
	
	
	
}
