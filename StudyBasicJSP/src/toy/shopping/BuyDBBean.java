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

	/////////////////싱글톤 패턴//////////////////////////////
	private static BuyDBBean instance = new BuyDBBean();
	
	public static BuyDBBean getInstance() {
		return instance;
	}
	
	private BuyDBBean() {}
	
	//////////////////////커넥션 풀////////////////////////////
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/basicjsp");
		return ds.getConnection();
	}
	
	
	////////////banktable에 있는 전체 레코드를 얻어내는 메소드///////////////////
	
	
	
	/////////////////////////////////구매 테이블인 buy에 구매목록 등록//////////////////////////////////
	//cartdatabean(장바구니) list와 사용자의 아이디, 사용자의 계좌번호, 사용자의 이름, 사용자의 전화번호, 사용자의 주소를 입력받음
	public void insertBuy(BuyDataBean dataBean) throws Exception {
		
		Connection conn = null; // 커넥션 풀 객체 생성
		PreparedStatement pstmt = null; // 쿼리문을 질의할 preparedStatement객체를 생성
		ResultSet rs = null; // resultSet생성
		Timestamp reg_date = null; // reg_date 생성
		String sql = ""; // 쿼리문 입력 변수 sql
		String maxDate = " ";
		String number = "";
		String todayDate = "";
		List<CartDataBean> lists = null;
		String compareDate = "";
		Long buyId;
		short nowCount;

		try {
			conn = getConnection(); // 커넥션 풀 객체 생성
			
			lists = dataBean.getCartList();
			
			reg_date = new Timestamp(System.currentTimeMillis()); // 현재 시간을 reg_date에 저장
			sql = "select max(buy_id) from buy"; // buy_id중 가장 큰 값의 buy_id를 찾는다.
			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();
			rs.next();
			
			conn.setAutoCommit(false);

			// 입력 받은 lists(장바구니에 담긴 물품)크기 만큼 for문을 반복하며 한 물품씩 처리
			for (int i = 0; i < lists.size(); i++) {

				// 순서대로 데이터를 얻어와서 cartdatabean에 담음
				CartDataBean cart = lists.get(i);

				// buytable에 구매 아이디, 구매자, 구매된 책 아이디, 구매된 책명, 판매가, 판매수량, 책 이미지, 구매일자, 결제계좌, 배송지,
				// 배송지 전화번호, 배송지 주소, 배송 상황을 입력
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

				// book의 테이블에 연결하여 판매된 책 아이디에 해당하는 책의 수량을 가져옴
				sql = "select toy_count from toy where num =?";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, cart.getToy_id());
				rs = pstmt.executeQuery();
				rs.next();

				// 책의 수량에서 판매된 수량을 뺀후 nowCount 변수에 담음
				nowCount = (short) (rs.getShort(1) - cart.getBuy_count());

				// 책 수량을 nowCount로 수정
				sql = "update toy set toy_count =? where num =?";
				pstmt = conn.prepareStatement(sql);

				pstmt.setShort(1, nowCount);
				pstmt.setInt(2, cart.getToy_id());
				pstmt.executeUpdate();
			}

			// 구매자의 카트를 비운다.
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
	
	//////////////////사용자에 따른 판매량을 구한다/////////////////////////
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
	
	/////////////////총 판매량을 구한다////////////////////////
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

	////////////////고객에 따른 구매목록을 List형태로 반환//////////////////////////
	public List<BuyDataBean> getBuyList(String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		BuyDataBean buy = null;
		String sql = "";
		List<BuyDataBean> lists = null;

		try {
			conn = getConnection();
			
			//buyer(구매자)에 따른 구매목록 전체를 검색
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
	
	//////////////////전체 판매 목록을 list형태로 반환//////////////////////////
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
