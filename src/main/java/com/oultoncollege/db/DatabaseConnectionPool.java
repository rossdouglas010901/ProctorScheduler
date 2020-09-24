package com.oultoncollege.db;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.apache.tomcat.jdbc.pool.PoolProperties;

/**
 *
 * @author bcop
 */
public class DatabaseConnectionPool {

    public static void main(String[] args) throws Exception {
        PoolProperties p = new PoolProperties();
          p.setUrl("jdbc:"+Settings.DB_TYPE+"://"+Settings.DB_HOST+":"+Settings.DB_PORT+"/"+Settings.DB_NAME);
          p.setDriverClassName(Settings.DB_DRIVER);
          p.setUsername(Settings.DB_USER);
          p.setPassword(Settings.DB_PWD);
          p.setJmxEnabled(true);
          p.setTestWhileIdle(false);
          p.setTestOnBorrow(true);
          p.setValidationQuery("SELECT 1");
          p.setTestOnReturn(false);
          p.setValidationInterval(30000);
          p.setTimeBetweenEvictionRunsMillis(30000);
          p.setMaxActive(100);
          p.setInitialSize(10);
          p.setMaxWait(10000);
          p.setRemoveAbandonedTimeout(60);
          p.setMinEvictableIdleTimeMillis(30000);
          p.setMinIdle(10);
          p.setLogAbandoned(true);
          p.setRemoveAbandoned(true);
          p.setJdbcInterceptors("org.apache.tomcat.jdbc.pool.interceptor.ConnectionState;"+
            "org.apache.tomcat.jdbc.pool.interceptor.StatementFinalizer");
        DataSource datasource = new DataSource();
        datasource.setPoolProperties(p);

        Connection con = null;
        try {
          con = datasource.getConnection();
          Statement st = con.createStatement();
          ResultSet rs = st.executeQuery("SELECT * FROM users");
          int cnt = 1;
          while (rs.next()) {
              System.out.println((cnt++)+". UserID:" +rs.getString("UserID")+
                " | User:"+rs.getString("Email")+" | Name:"+rs.getString("FirstName"));
          }
          rs.close();
          st.close();
        } finally {
          if (con != null) {
              try {
                  con.close();
              } catch (Exception ex) {
                  ex.printStackTrace();
              }
          }
        }
    }

}
