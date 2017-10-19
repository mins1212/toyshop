package toy.shopping;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class CartDBBean {
	/////////////////싱글톤 패턴//////////////////////////////
	private static CartDBBean instance = new CartDBBean();
	
	public static CartDBBean getInstance() {
		return instance;
	}
	
	private CartDBBean() {}
	
	//////////////////////커넥션 풀////////////////////////////
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/basicjsp");
		return ds.getConnection();
	}
	
	////////////////////DB cart에 입력받은 데이터 객체 저장///////////////////////////
	public void insertCart(CartDataBean cart) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";
		
		try {
			conn = getConnection();
			sql = "insert into cart(toy_id, buyer,toy_title,toy_price,buy_count,toy_image)"
					+ "values(?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, cart.getToy_id());
			pstmt.setString(2, cart.getBuyer());
			pstmt.setString(3, cart.getToy_title());
			pstmt.setInt(4, cart.getToy_price());
			pstmt.setByte(5, cart.getBuy_count());
			pstmt.setString(6, cart.getToy_image());
			
			pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
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
	}
	
	/////////////////넘겨받은 id(고객 id)의 해당하는 레코드의 수////////////////////
	public int getListCount(String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x= 0;
		String sql = "";
		
		try {
			conn = getConnection();
			
			sql="select count(*) from cart where buyer=?";
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
	
	
	///////////고객(id)의 cartlist를 출력//////////////////////////////
	public List<CartDataBean> getCart(String id) throws Exception {
		Connection conn = null;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		CartDataBean cart = null;
		String sql = "";
		List<CartDataBean> lists = null;
		
		try {
			conn = getConnection();
			
			sql = "select * from cart where buyer=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			lists = new ArrayList<CartDataBean>();
			
			while(rs.next()) {
				cart = new CartDataBean();
				
				cart.setCart_id(rs.getInt("cart_id"));
				cart.setToy_id(rs.getInt("toy_id"));
				cart.setToy_title(rs.getString("toy_title"));
				cart.setToy_price(rs.getInt("toy_price"));
				cart.setBuy_count(rs.getByte("buy_count"));
				cart.setToy_image(rs.getString("toy_image"));
				
				lists.add(cart);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
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
		
		return lists;
	}
	
	
	/////////////////장바구니의 수량을 수정시 실행///////////////////////////////
	public void updateCount(int cart_id, byte count) throws Exception {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";
		
		try {
			conn = getConnection();
			
			sql = "update cart set buy_count=? where cart_id = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setByte(1, count);
			pstmt.setInt(2, cart_id);
			
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
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
	}
	
	//////////////////cart_id에 해당하는 상품 목록 삭제//////////////////////
	public void deleteList(int cart_id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";
		
		try {
			conn = getConnection();
			
			sql="delete from cart where cart_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cart_id);
			
			pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
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
	}
	
	//////////////////전체 상품 장바구니 삭제///////////////////////
	public void deleteAll(String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";
		
		try {
			conn = getConnection();
			
			sql="delete from cart where buyer=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
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
	}
}
