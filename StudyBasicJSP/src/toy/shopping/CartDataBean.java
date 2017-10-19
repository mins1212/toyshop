package toy.shopping;

public class CartDataBean {
	private int cart_id; // 장바구니의 아이디
	private String buyer; // 구매자
	private int toy_id;
	private String toy_title;
	private int toy_price;
	private byte buy_count;
	private String toy_image;

	public int getCart_id() {
		return cart_id;
	}

	public void setCart_id(int cart_id) {
		this.cart_id = cart_id;
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

	public String getToy_title() {
		return toy_title;
	}

	public void setToy_title(String toy_title) {
		this.toy_title = toy_title;
	}

	public int getToy_price() {
		return toy_price;
	}

	public void setToy_price(int toy_price) {
		this.toy_price = toy_price;
	}

	public byte getBuy_count() {
		return buy_count;
	}

	public void setBuy_count(byte buy_count) {
		this.buy_count = buy_count;
	}

	public String getToy_image() {
		return toy_image;
	}

	public void setToy_image(String toy_image) {
		this.toy_image = toy_image;
	}

}
