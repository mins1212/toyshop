package toy.manager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class ManagerDBBean {
	//½Ì±ÛÅæ ÆÐÅÏ//
	private static ManagerDBBean instance = new ManagerDBBean();
	
	public static ManagerDBBean getInstance() {
		return instance;
	}
	
	private ManagerDBBean() {}
	
	//Ä¿³Ø¼Ç Ç®
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/basicjsp");
		return ds.getConnection();
	}
	
	public int managerLoginCheck(ManagerDataBean article) throws Exception {
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		String sql = "";
		int x = 0;
		
		try {
			conn = getConnection();
			sql="select passwd from manager where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, article.getId());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(rs.getString(1).equals(article.getPasswd())) {
					x = 0;
				} else {
					x = 1;
				}
				
			} else {
				x = -1;
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if(pstmt !=null) {
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if(conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		
		return x;
	}
	
	public void insertToy(ToyDataBean article) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";
		
		try {
			conn = getConnection();
			sql = "insert into toy values(null,?,?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, article.getToy_kind());
			pstmt.setInt(2, article.getToy_price());
			pstmt.setString(3,article.getToy_title());
			pstmt.setString(4,article.getToy_maker());
			pstmt.setInt(5, article.getToy_count());
			pstmt.setString(6, article.getToy_content());
			pstmt.setString(7, article.getToy_image());
			pstmt.setTimestamp(8, article.getReg_date());
			pstmt.setInt(9, article.getRead_count());
			pstmt.setInt(10, article.getDiscount_rate());
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		finally {
			if(pstmt !=null) {
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if(conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	public List<ToyDataBean> getToyList() throws Exception {

		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";
		ResultSet rs = null;
		List<ToyDataBean> toyList = null;

		try {
			conn = getConnection();
			sql = "select * from toy";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			toyList = new ArrayList<ToyDataBean>();
			while (rs.next()) {
				ToyDataBean article = new ToyDataBean();
				article.setNum(rs.getInt("num"));
				article.setToy_kind(rs.getString("toy_kind"));
				article.setToy_price(rs.getInt("toy_price"));
				article.setToy_title(rs.getString("toy_title"));
				article.setToy_maker(rs.getString("toy_maker"));
				article.setToy_count(rs.getInt("toy_count"));
				article.setToy_content(rs.getString("toy_content"));
				article.setToy_image(rs.getString("toy_image"));
				article.setReg_date(rs.getTimestamp("reg_date"));
				article.setRead_count(rs.getInt("read_count"));
				article.setDiscount_rate(rs.getInt("discount_rate"));
				toyList.add(article);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return toyList;
	}
	
	public List<ToyDataBean> getToyList(String toy_kind) throws Exception {

		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";
		ResultSet rs = null;
		List<ToyDataBean> toyList = null;

		try {
			conn = getConnection();
			sql = "select * from toy where toy_kind = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, toy_kind);
			rs = pstmt.executeQuery();
			toyList = new ArrayList<ToyDataBean>();
			while (rs.next()) {
				ToyDataBean article = new ToyDataBean();
				article.setNum(rs.getInt("num"));
				article.setToy_kind(rs.getString("toy_kind"));
				article.setToy_price(rs.getInt("toy_price"));
				article.setToy_title(rs.getString("toy_title"));
				article.setToy_maker(rs.getString("toy_maker"));
				article.setToy_count(rs.getInt("toy_count"));
				article.setToy_content(rs.getString("toy_content"));
				article.setToy_image(rs.getString("toy_image"));
				article.setReg_date(rs.getTimestamp("reg_date"));
				article.setRead_count(rs.getInt("read_count"));
				article.setDiscount_rate(rs.getInt("discount_rate"));

				toyList.add(article);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return toyList;
	}
	
	public List<ToyDataBean> getToyList(String toy_kind,int count) throws Exception {

		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";
		ResultSet rs = null;
		List<ToyDataBean> toyList = null;

		try {
			conn = getConnection();
			sql = "select * from toy where toy_kind = ? order by read_count";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, toy_kind);
			rs = pstmt.executeQuery();
			toyList = new ArrayList<ToyDataBean>();
			for(int i = 0; i <count; i++) {
				if(rs.next()) {
					ToyDataBean article = new ToyDataBean();
					article.setNum(rs.getInt("num"));
					article.setToy_kind(rs.getString("toy_kind"));
					article.setToy_price(rs.getInt("toy_price"));
					article.setToy_title(rs.getString("toy_title"));
					article.setToy_maker(rs.getString("toy_maker"));
					article.setToy_count(rs.getInt("toy_count"));
					article.setToy_content(rs.getString("toy_content"));
					article.setToy_image(rs.getString("toy_image"));
					article.setReg_date(rs.getTimestamp("reg_date"));
					article.setRead_count(rs.getInt("read_count"));
					article.setDiscount_rate(rs.getInt("discount_rate"));
	
					toyList.add(article);
				} else {
					toyList.add(null);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return toyList;
	}
	
	public List<ToyKindDataBean> getToyKind() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		List<ToyKindDataBean> toyList = null;
		
		try {
			conn = getConnection();
			sql = "select * from toy_kind order by toy_kind asc";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			toyList = new ArrayList<ToyKindDataBean>();
			
			while(rs.next()) {
				ToyKindDataBean article = new ToyKindDataBean();
				article.setToy_kind(rs.getString("toy_kind"));
				article.setKind_title(rs.getString("kind_title"));
				
				toyList.add(article);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if(pstmt !=null) {
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if(conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		
		return toyList;
	}
	
	public String getKindTitle(String toy_kind) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		String kind_title = null;
		
		try {
			
			conn = getConnection();
			sql = "select * from toy_kind where toy_kind = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, toy_kind);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				kind_title = rs.getString("kind_title");
			} 
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {
				try {
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if(pstmt !=null) {
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if(conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		
		return kind_title;
	}
	
	
	public ToyDataBean getToyArticle(int num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		ToyDataBean article = null;
		
		try {
			conn = getConnection();
			sql = "select * from toy where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,num);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				article = new ToyDataBean();
				article.setNum(rs.getInt("num"));
				article.setToy_kind(rs.getString("toy_kind"));
				article.setToy_price(rs.getInt("toy_price"));
				article.setToy_title(rs.getString("toy_title"));
				article.setToy_maker(rs.getString("toy_maker"));
				article.setToy_count(rs.getInt("toy_count"));
				article.setToy_content(rs.getString("toy_content"));
				article.setToy_image(rs.getString("toy_image"));
				article.setReg_date(rs.getTimestamp("reg_date"));
				article.setRead_count(rs.getInt("read_count"));
				article.setDiscount_rate(rs.getInt("discount_rate"));
			}
		}  catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		
		return article;
	}
	
	public void updateToyArticle(ToyDataBean article) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";
		
		try {
			conn = getConnection();
			sql = "update toy set toy_kind = ?, toy_price =?, toy_title = ?,toy_maker = ?,toy_count=?,toy_content=?,toy_image=?, discount_rate=? where num = ?";
			pstmt = conn.prepareStatement(sql);	
			pstmt.setString(1, article.getToy_kind());
			pstmt.setInt(2, article.getToy_price());
			pstmt.setString(3,article.getToy_title());
			pstmt.setString(4,article.getToy_maker());
			pstmt.setInt(5, article.getToy_count());
			pstmt.setString(6, article.getToy_content());
			pstmt.setString(7, article.getToy_image());
			pstmt.setInt(8,article.getDiscount_rate());
			pstmt.setInt(9, article.getNum());
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		finally {
			if(pstmt !=null) {
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if(conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	public void deleteToyArticle(int num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";
		
		try {
			conn = getConnection();
			sql = "delete from toy where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,num);
			pstmt.executeUpdate();
		}  catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}
}
