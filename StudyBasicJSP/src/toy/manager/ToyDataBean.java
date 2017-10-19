package toy.manager;

import java.sql.Timestamp;

public class ToyDataBean {
	private int num;
	private String toy_kind;
	private int toy_price;
	private String toy_title;
	private String toy_maker;
	private int toy_count;
	private String toy_content;
	private String toy_image;
	private Timestamp reg_date;
	private int read_count;
	private int discount_rate;
	
	public int getRead_count() {
		return read_count;
	}

	public void setRead_count(int read_count) {
		this.read_count = read_count;
	}

	public int getDiscount_rate() {
		return discount_rate;
	}

	public void setDiscount_rate(int discount_rate) {
		this.discount_rate = discount_rate;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getToy_kind() {
		return toy_kind;
	}

	public void setToy_kind(String toy_kind) {
		this.toy_kind = toy_kind;
	}

	public int getToy_price() {
		return toy_price;
	}

	public void setToy_price(int toy_price) {
		this.toy_price = toy_price;
	}

	public String getToy_title() {
		return toy_title;
	}

	public void setToy_title(String toy_title) {
		this.toy_title = toy_title;
	}

	public String getToy_maker() {
		return toy_maker;
	}

	public void setToy_maker(String toy_maker) {
		this.toy_maker = toy_maker;
	}

	public int getToy_count() {
		return toy_count;
	}

	public void setToy_count(int toy_count) {
		this.toy_count = toy_count;
	}

	public String getToy_content() {
		return toy_content;
	}

	public void setToy_content(String toy_content) {
		this.toy_content = toy_content;
	}

	public String getToy_image() {
		return toy_image;
	}

	public void setToy_image(String toy_image) {
		this.toy_image = toy_image;
	}
	
	public Timestamp getReg_date() {
		return reg_date;
	}

	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}

}
