package borad;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;


public class BoradDAO {

	private Connection conn;
	private Statement stmt;
	private ResultSet rs;
	
	public BoradDAO() {
		try {
			String dbURL = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
			String dbID = "system";
			String dbPassword = "1234";
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(dbURL,dbID,dbPassword);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public int getNext() {
		String query = "SELECT ID FROM BOARD ORDER BY ID DESC";
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(query);
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // 첫 번째 게시물인 경우
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
		
	public ArrayList<Borad> getList(int pageNumber){
		int value = getNext() - (pageNumber - 1) * 10;
		String query = "SELECT * FROM (SELECT * FROM BOARD WHERE ID <" + value + "ORDER BY ID DESC) WHERE ROWNUM <= 10";
		ArrayList<Borad> list = new ArrayList<Borad>();
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()) {
				Borad borad = new Borad();
				borad.setCONTENT(rs.getString(1));
				borad.setNAME(rs.getString(2));
				borad.setTITLE(rs.getString(3));
				borad.setID(rs.getInt(4));
				list.add(borad);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; 
	}
	
	public ArrayList<Borad> getSearchedList(int pageNumber, String searchWord){
		int value = getNext() - (pageNumber - 1) * 10;
		String query = "SELECT * FROM (SELECT * FROM BOARD WHERE ID <" + value + " AND TITLE LIKE '%" + searchWord + "%' ORDER BY ID DESC) WHERE ROWNUM <= 10";
		System.out.println(query);
		ArrayList<Borad> list = new ArrayList<Borad>();
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()) {
				Borad borad = new Borad();
				borad.setCONTENT(rs.getString(1));
				borad.setNAME(rs.getString(2));
				borad.setTITLE(rs.getString(3));
				borad.setID(rs.getInt(4));
				borad.setQuery(query);
				list.add(borad);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; 
	}
	
	public boolean nextPage(int pageNumber) {
		int value = getNext() - (pageNumber - 1) * 10;
		String query = "SELECT * FROM BOARD WHERE ID <" + value + "";
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(query);
			if(rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false; 
	}
	
	public int write(String TITLE,String NAME,String CONTENT) {
		String query = "INSERT INTO BOARD (CONTENT,TITLE,NAME,ID) VALUES('" 
		+ CONTENT + "','" + TITLE + "','" + NAME + "'," + getNext() + ")" ;
		try {
			stmt = conn.createStatement();
			return stmt.executeUpdate(query);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public Borad getBorad(int ID) {
		String query = "SELECT * FROM BOARD WHERE ID =" + ID + "";
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(query);
			if(rs.next()) {
				Borad borad = new Borad();
				borad.setCONTENT(rs.getString(1));
				borad.setNAME(rs.getString(2));
				borad.setTITLE(rs.getString(3));
				borad.setID(rs.getInt(4));
				return borad;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; 
	}
	
	public int update(int ID,String TITLE,String CONTENT) {
		String query = "UPDATE BOARD SET TITLE='" + TITLE + "',CONTENT='" + CONTENT + "'" + "WHERE ID =" + ID + "";
		try {
			stmt = conn.createStatement();
			return stmt.executeUpdate(query);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public int delete(int ID) {
		String query = "DELETE FROM BOARD WHERE ID=" + ID + "";
		try {
			stmt = conn.createStatement();
			return stmt.executeUpdate(query);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
}
