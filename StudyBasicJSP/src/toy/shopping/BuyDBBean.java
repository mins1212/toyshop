package toy.shopping;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import javax.swing.event.CaretListener;

public class BuyDBBean {

	/////////////////�̱��� ����//////////////////////////////
	private static BuyDBBean instance = new BuyDBBean();
	
	public static BuyDBBean getInstance() {
		return instance;
	}
	
	private BuyDBBean() {}
	
	//////////////////////Ŀ�ؼ� Ǯ////////////////////////////
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/basicjsp");
		return ds.getConnection();
	}
	
	
	////////////banktable�� �ִ� ��ü ���ڵ带 ���� �޼ҵ�///////////////////
	
	
	
	/////////////////////////////////���� ���̺��� buy�� ���Ÿ�� ���//////////////////////////////////
	//cartdatabean(��ٱ���) list�� ������� ���̵�, ������� ���¹�ȣ, ������� �̸�, ������� ��ȭ��ȣ, ������� �ּҸ� �Է¹���
	public void insertBuy(BuyDataBean dataBean) throws Exception {
		
		Connection conn = null; // Ŀ�ؼ� Ǯ ��ü ����
		PreparedStatement pstmt = null; // �������� ������ preparedStatement��ü�� ����
		ResultSet rs = null; // resultSet����
		Timestamp reg_date = null; // reg_date ����
		String sql = ""; // ������ �Է� ���� sql
		String maxDate = " ";
		String number = "";
		String todayDate = "";
		List<CartDataBean> lists = null;
		String compareDate = "";
		Long buyId;
		short nowCount;

		try {
			conn = getConnection(); // Ŀ�ؼ� Ǯ ��ü ����
			
			lists = dataBean.getCartList();
			
			reg_date = new Timestamp(System.currentTimeMillis()); // ���� �ð��� reg_date�� ����
			sql = "select max(buy_id) from buy"; // buy_id�� ���� ū ���� buy_id�� ã�´�.
			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();
			rs.next();
			
			conn.setAutoCommit(false);

			// �Է� ���� lists(��ٱ��Ͽ� ��� ��ǰ)ũ�� ��ŭ for���� �ݺ��ϸ� �� ��ǰ�� ó��
			for (int i = 0; i < lists.size(); i++) {

				// ������� �����͸� ���ͼ� cartdatabean�� ����
				CartDataBean cart = lists.get(i);

				// buytable�� ���� ���̵�, ������, ���ŵ� å ���̵�, ���ŵ� å��, �ǸŰ�, �Ǹż���, å �̹���, ��������, ��������, �����,
				// ����� ��ȭ��ȣ, ����� �ּ�, ��� ��Ȳ�� �Է�
				sql = "insert into buy(buyer, toy_id, toy_price, toy_count, toy_image,buy_date, buyer_account,deliveryName, deliveryTel, deliveryAddress, deliverytext,sanction,toy_title) values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
				pstmt = conn.prepareStatement(sql);

				pstmt.setInt(1, dataBean.getBuy_id());
				pstmt.setInt(2, cart.getToy_id());
				pstmt.setInt(3, cart.getToy_price());
				pstmt.setInt(4, cart.getBuy_count());
				pstmt.setString(5, cart.getToy_image());
				pstmt.setTimestamp(6, dataBean.getBuy_date());
				pstmt.setString(7, "account");
				pstmt.setString(8, dataBean.getDeliveryName());
				pstmt.setString(9, dataBean.getDeliveryTel());
				pstmt.setString(10, dataBean.getDeliveryAddress());
				pstmt.setString(11, dataBean.getDeliveryText());
				pstmt.setString(12, dataBean.getSanction());
				pstmt.setString(13, cart.getToy_title());
				pstmt.executeUpdate();

				// book�� ���̺� �����Ͽ� �Ǹŵ� å ���̵� �ش��ϴ� å�� ������ ������
				sql = "select toy_count from toy where num =?";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, cart.getToy_id());
				rs = pstmt.executeQuery();
				rs.next();

				// å�� �������� �Ǹŵ� ������ ���� nowCount ������ ����
				nowCount = (short) (rs.getShort(1) - cart.getBuy_count());

				// å ������ nowCount�� ����
				sql = "update toy set toy_count =? where num =?";
				pstmt = conn.prepareStatement(sql);

				pstmt.setShort(1, nowCount);
				pstmt.setInt(2, cart.getToy_id());
				pstmt.executeUpdate();
			}

			// �������� īƮ�� ����.
			pstmt = conn.prepareStatement("delete from cart where buyer=?");
			pstmt.setString(1, dataBean.getBuyer());

			pstmt.executeUpdate();

			conn.commit();
			conn.setAutoCommit(true);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	//////////////////����ڿ� ���� �Ǹŷ��� ���Ѵ�/////////////////////////
	/*public int getListCount(String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		int x= 0;
		
		try {
			conn = getConnection();
			
			sql="select count(*) from buy where buyer=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				x=rs.getInt(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
		return x;
	}
	
	/////////////////�� �Ǹŷ��� ���Ѵ�////////////////////////
	public int getListCount() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		int x= 0;
		
		try {
			conn = getConnection();
			sql="select count(*) from buy";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				x=rs.getInt(1);
			}
			
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
		return x;
	}

	////////////////���� ���� ���Ÿ���� List���·� ��ȯ//////////////////////////
	public List<BuyDataBean> getBuyList(String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		BuyDataBean buy = null;
		String sql = "";
		List<BuyDataBean> lists = null;

		try {
			conn = getConnection();
			
			//buyer(������)�� ���� ���Ÿ�� ��ü�� �˻�
			sql = "select * from Buy where buyer=?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			lists = new ArrayList<BuyDataBean>();

			while (rs.next()) {
				buy = new BuyDataBean();

				buy.setBuy_id(rs.getLong("buy_id"));
				buy.setBook_id(rs.getInt("book_id"));
				buy.setBook_title(rs.getString("book_title"));
				buy.setBuy_price(rs.getInt("buy_price"));
				buy.setBuy_count(rs.getByte("buy_count"));
				buy.setBook_image(rs.getString("book_image"));
				buy.setSanction(rs.getString("sanction"));

				lists.add(buy);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

		return lists;
	}
	
	//////////////////��ü �Ǹ� ����� list���·� ��ȯ//////////////////////////
	public List<BuyDataBean> getBuyList() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		BuyDataBean buy = null;
		String sql = "";
		List<BuyDataBean> lists = null;

		try {
			conn = getConnection();

			sql = "select * from Buy";
			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			lists = new ArrayList<BuyDataBean>();

			while (rs.next()) {
				buy = new BuyDataBean();

				buy.setBuy_id(rs.getLong("buy_id"));
				buy.setBuyer(rs.getString("buyer"));
				buy.setBook_id(rs.getInt("book_id"));
				buy.setBook_title(rs.getString("book_title"));
				buy.setBuy_price(rs.getInt("buy_price"));
				buy.setBuy_count(rs.getByte("buy_count"));
				buy.setBook_image(rs.getString("book_image"));
				buy.setBuy_date(rs.getTimestamp("buy_date"));
				buy.setAccount(rs.getString("account"));
				buy.setDeliveryName(rs.getString("deliveryName"));
				buy.setDeliveryTel(rs.getString("deliveryTel"));
				buy.setDeliveryAddress(rs.getString("deliveryAddress"));
				buy.setSanction(rs.getString("sanction"));

				lists.add(buy);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

		return lists;
	}*/
}
