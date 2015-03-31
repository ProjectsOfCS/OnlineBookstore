/*
 *
 */
package onlinebookstore.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import onlinebookstore.entity.UserInfo;
import onlinebookstore.util.DBConnect;
import onlinebookstore.util.Encrypt;

public class UserDao extends BaseDao {

	public UserDao() {
		super();
	}

	public Boolean CheckUserName(String strUserName) {
		boolean checkRslt = false;
		String sql = "select count(1) from userinfo where Username = ?;";
		try {
			DBConnect dbConn = new DBConnect(pool);
			dbConn.prepareStatement(sql);
			dbConn.setString(1, strUserName);
			checkRslt = Integer.parseInt(dbConn.executeScalar().toString()) == 1;
			dbConn.close();
		} catch (SQLException e) {
			log.error("", e);
		} catch (Exception e) {
			log.error(e.toString());
		}

		return checkRslt;

	}

	public Boolean CheckEmail(String strEmail) {
		boolean checkRslt = false;
		String sql = "select count(1) from userinfo where Email = ?;";
		try {
			DBConnect dbConn = new DBConnect(pool);
			dbConn.prepareStatement(sql);
			dbConn.setString(1, strEmail);
			checkRslt = Integer.parseInt(dbConn.executeScalar().toString()) == 1;
			dbConn.close();
		} catch (SQLException e) {
			log.error("", e);
		} catch (Exception e) {
			log.error(e.toString());
		}

		return checkRslt;
	}

	public UserInfo Login(String strUserName, String strUserPwd) {
		UserInfo user = new UserInfo();
		if (CheckUserName(strUserName)) {
			String sql = "select * from userinfo where Username = ? and Password=?;";
			try {
				DBConnect dbConn = new DBConnect(pool);
				dbConn.prepareStatement(sql);
				dbConn.setString(1, strUserName);
				dbConn.setString(2, Encrypt.EncryptByMD5(strUserPwd));
				ResultSet rset = dbConn.executeQuery();
				if (rset.next()) {
					user = new UserInfo(rset.getInt("UserID"),
							rset.getString("Username"),
							rset.getString("Password"),
							rset.getString("Address"), rset.getString("Email"),
							rset.getInt("UserRole"), rset.getInt("Newsletter"));
				}

				dbConn.close();
			} catch (SQLException e) {
				log.error("", e);
			} catch (Exception e) {
				log.error(e.toString());
			}
		}

		return user;
	}

	public boolean Register(UserInfo puser) {
		boolean result = false;
		if (!CheckUserName(puser.getUserName())) {
			String sql = "INSERT INTO `userinfo`(`Username`,`Password`,`UserRole`,`Address`,Email, Newsletter)VALUES(?,?,1,?,?,?);";
			try {
				DBConnect dbConn = new DBConnect(pool);
				dbConn.prepareStatement(sql);
				dbConn.setString(1, puser.getUserName());
				dbConn.setString(2, Encrypt.EncryptByMD5(puser.getPassword()));
				dbConn.setString(3, puser.getAddress());
				dbConn.setString(4, puser.getEmail());
				dbConn.setInt(5, puser.getNewsletter());
				result = dbConn.executeUpdate() == 1;
				dbConn.close();
			} catch (SQLException e) {
				log.error("", e);
			} catch (Exception e) {
				log.error(e.toString());
			}
		}

		return result;
	}
}
