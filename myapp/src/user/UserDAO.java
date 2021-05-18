package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class UserDAO {
	
	private Connection conn;
	private Statement stmt;
	private ResultSet rs;
	
	public UserDAO() {
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
	
	public int login(String userID, String userPW) {
		String query = "SELECT USERPW FROM MEMBER WHERE USERID = '" + userID + "'";
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(query);
			if(rs.next()) {
				if(rs.getString(1).contentEquals(userPW)) {
					return 1; // �α��� ����
				}
				else
					return 0; // ��й�ȣ ����ġ
			}
			return -1; // ���̵� ����ġ
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // �����ͺ��̽� ����
	}
	
	public int join(User user) {
		String query = "INSERT INTO MEMBER (USERID,USERPW,USERNAME) VALUES('" 
				+ user.getUserID() + "','" + user.getUserPW() + "','" + user.getUserName() + "')" ;
		try {
			stmt = conn.createStatement();
			return stmt.executeUpdate(query);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}
	
	public int change_Password(String userID,String userPW) {
		String query = "UPDATE MEMBER SET USERPW='" + userPW + "' WHERE USERID='" + userID + "'";
		try {
			stmt = conn.createStatement();
			return stmt.executeUpdate(query);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}
}



























