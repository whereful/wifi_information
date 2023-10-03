package com.wifi.wifiproject.dao;

import com.wifi.wifiproject.dto.BookmarkGroup;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class BookmarkGroupDatabaseService {

    private String url = "jdbc:mariadb://localhost:3306/wifi_database";
    private String username = "wifiUser";
    private String password = "zerobase";
    private String tableName = "bookmarkgroup_table";

    private static BookmarkGroupDatabaseService bookmarkGroupDatabaseService = new BookmarkGroupDatabaseService();
    public List<BookmarkGroup> bookmarkGroupList = null;

    private BookmarkGroupDatabaseService() {
        try {
            Class.forName("org.mariadb.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        // 테이블이 무조건 존재하도록 설정
        createTable();

        // List<History>에 데이터 저장 시도
        // 기존에 db에 데이터가 존재하면 size가 0 초과, 존재하지 않으면 0
        bookmarkGroupList = getAllBookmarkgroupFromDb();

    }

    public static BookmarkGroupDatabaseService getInstance() {
        return bookmarkGroupDatabaseService;
    }

    private void createTable() {

        try (Connection connection = DriverManager.getConnection(url, username, password)) {

            if (connection != null) {
                System.out.println("Connected to the database!");

                // 테이블 생성 SQL
                String createTableSql = "CREATE TABLE IF NOT EXISTS " + tableName + "(" +
                        "ID INT AUTO_INCREMENT PRIMARY KEY," +
                        "BOOKMARKGROUP_NAME VARCHAR(255)," +
                        "BOOKMARKGROUP_ORDER VARCHAR(255)," +
                        "REGISTER_DATE VARCHAR(255)," +
                        "UPDATE_DATE VARCHAR(255)" +
                        ")";

                // SQL CREATE TABLE 문을 실행하여 테이블 생성
                Statement createTableStatement = connection.createStatement();
                createTableStatement.executeUpdate(createTableSql);

                createTableStatement.close();

            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    public void dbInsertBookmarkGroup(String name, String order, String register_date) {

        try (Connection connection = DriverManager.getConnection(url, username, password)) {

            if (connection != null) {

                // SQL INSERT 문을 실행하여 데이터 삽입
                String insertSql = "INSERT INTO " + tableName +
                        "(BOOKMARKGROUP_NAME, BOOKMARKGROUP_ORDER, " +
                        "REGISTER_DATE, UPDATE_DATE) " +
                        "VALUES (?, ?, ?, ?)";
                PreparedStatement preparedStatement = connection.prepareStatement(insertSql);

                // 데이터 추출 및 바인딩

                preparedStatement.setString(1, name);
                preparedStatement.setString(2, order);
                preparedStatement.setString(3, register_date);
                preparedStatement.setString(4, "");


                // 쿼리 실행
                preparedStatement.executeUpdate();

                // 밑의 두 문장 작성 시 오류 발생
                // preparedStatement.close();
                // connection.close();

            }

            System.out.println("Data inserted successfully.");
            // System.out.println(seoulWifiInfo.getTbPublicWifiInfo().getRow().get(0).getX_SWIFI_MGR_NO());

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    public void dbUpdateBookmarkGroup(String id, String name, String order) {

        try (Connection connection = DriverManager.getConnection(url, username, password)) {

            if (connection != null) {

                // SQL UPDATE 문을 실행하여 데이터 삽입
                String updateSql = "UPDATE " + tableName + " SET " +
                        "BOOKMARKGROUP_NAME = ?, BOOKMARKGROUP_ORDER = ?, UPDATE_DATE = ? " +
                        "WHERE ID = ?";
                PreparedStatement preparedStatement = connection.prepareStatement(updateSql);

                // 데이터 추출 및 바인딩

                preparedStatement.setString(1, name);
                preparedStatement.setString(2, order);
                preparedStatement.setString(3, LocalDateTime.now().withNano(0).toString());
                preparedStatement.setString(4, id);


                // 쿼리 실행
                preparedStatement.executeUpdate();

                // 밑의 두 문장 작성 시 오류 발생
                // preparedStatement.close();
                // connection.close();

            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    public List<BookmarkGroup> getAllBookmarkgroupFromDb() {
        List<BookmarkGroup> bookmarkGroupList = new ArrayList<>();

        try (Connection connection = DriverManager.getConnection(url, username, password)) {

            if (connection != null) {

                // SQL select 문을 실행하여 데이터 삽입
                String selectSql = "SELECT * FROM " + tableName;
                PreparedStatement preparedStatement = connection.prepareStatement(selectSql);

                ResultSet rs = preparedStatement.executeQuery();

                while (rs.next()) {
                    BookmarkGroup b = new BookmarkGroup();

                    b.setID(rs.getString("ID"));
                    b.setBOOKMARKGROUP_NAME(rs.getString("BOOKMARKGROUP_NAME"));
                    b.setBOOKMARKGROUP_ORDER(rs.getString("BOOKMARKGROUP_ORDER"));
                    b.setREGISTER_DATE(rs.getString("REGISTER_DATE"));
                    b.setUPDATE_DATE(rs.getString("UPDATE_DATE"));


                    bookmarkGroupList.add(b);
                }

            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return bookmarkGroupList;
    }

    public void updateTable() {
        bookmarkGroupList = getAllBookmarkgroupFromDb();
    }

    public void dbDeleteBookmarkgroup(String id) {

        try (Connection connection = DriverManager.getConnection(url, username, password)) {

            if (connection != null) {

                // SQL DELETE 문을 실행하여 데이터 삽입
                String deleteSql = "DELETE FROM " + tableName +
                        " WHERE ID = " + "?";

                PreparedStatement preparedStatement = connection.prepareStatement(deleteSql);
                preparedStatement.setString(1, id);


                // 쿼리 실행
                preparedStatement.executeUpdate();

                // 밑의 두 문장 작성 시 오류 발생
                // preparedStatement.close();
                // connection.close();

            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }


    }

}
