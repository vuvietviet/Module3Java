package dao;


import connect.Connect_MySQL;
import model.Staff;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class StaffDAO {
    private static final String INSERT_STAFF_SQL = "INSERT INTO staff (id,name,dateOfBirth,address,phoneNumber, email, nameDepartment) VALUES (?, ?, ?,?,?,?,?);";
    private static final String SELECT_STAFF_BY_ID = "select * from staff where id = ?;";
    private static final String SELECT_STAFF_BY_NAME = "select * from staff where name LIKE concat('%',?,'%');";
    private static final String SELECT_ALL_STAFFS = "select * from staff;";
    private static final String SELECT_ALL_DEPARTMENTS = "select * from department;";
    private static final String DELETE_STAFF_SQL = "delete from staff where id = ?;";
    private static final String UPDATE_STAFF_SQL = "update staff set name = ?,dateOfBirth = ?,address = ?,phoneNumber = ?,email= ?, nameDepartment =? where id = ?;";

    public StaffDAO() {
    }

    public void insertStaff(Staff staff) throws SQLException {
        try (Connection connection = Connect_MySQL.getConnection()) {
            assert connection != null;
            try (PreparedStatement preparedStatement = connection.prepareStatement(INSERT_STAFF_SQL)) {
                preparedStatement.setInt(1, staff.getId());
                preparedStatement.setString(2, staff.getName());
                preparedStatement.setString(3, String.valueOf(staff.getDateOfBirth()));
                preparedStatement.setString(4, staff.getAddress());
                preparedStatement.setString(5, staff.getPhoneNumber());
                preparedStatement.setString(6, staff.getEmail());
                preparedStatement.setString(7, staff.getNameDepartment());
                System.out.println(preparedStatement);
                preparedStatement.executeUpdate();
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    public Staff selectStaff(int id) {
        Staff staff = null;
        try (Connection connection = Connect_MySQL.getConnection()) {
            assert connection != null;
            try (PreparedStatement preparedStatement = connection.prepareStatement(SELECT_STAFF_BY_ID);) {
                preparedStatement.setInt(1, id);
                System.out.println(preparedStatement);
                ResultSet rs = preparedStatement.executeQuery();

                while (rs.next()) {
                    String name = rs.getString("name");
                    LocalDate dateOfBirth = LocalDate.parse(rs.getString("dateOfBirth"));
                    String address = rs.getString("address");
                    String phoneNumber = rs.getString("phoneNumber");
                    String email = rs.getString("email");
                    String nameDepartment = rs.getString("nameDepartment");
                    staff = new Staff(id, name, dateOfBirth,address,phoneNumber,email,nameDepartment);
                }
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return staff;
    }


    public List<Staff> selectAllStaffs() {
        List<Staff> staffs = new ArrayList<>();
        try (Connection connection = Connect_MySQL.getConnection()) {
            assert connection != null;
            try (PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_STAFFS);) {
                System.out.println(preparedStatement);
                ResultSet rs = preparedStatement.executeQuery();

                while (rs.next()) {
                    int id = rs.getInt("id");
                    String name = rs.getString("name");
                    LocalDate dateOfBirth = LocalDate.parse(rs.getString("dateOfBirth"));
                    String address = rs.getString("address");
                    String phoneNumber = rs.getString("phoneNumber");
                    String email = rs.getString("email");
                    String nameDepartment = rs.getString("nameDepartment");
                    staffs.add(new Staff(id, name, dateOfBirth,address,phoneNumber,email,nameDepartment));
                }
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return staffs;
    }

    public List<String> selectAllDepartment() {
        List<String> departments = new ArrayList<>();
        try (Connection connection = Connect_MySQL.getConnection()) {
            assert connection != null;
            try (PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_DEPARTMENTS);) {
                ResultSet rs = preparedStatement.executeQuery();

                while (rs.next()) {
                    departments.add(rs.getString("nameDepartment"));
                }
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return departments;
    }

    public List<Staff> selectStaffByName(String name) {
        List<Staff> staffs = new ArrayList<>();
        try (Connection connection = Connect_MySQL.getConnection()) {
            assert connection != null;
            try (PreparedStatement preparedStatement = connection.prepareStatement(SELECT_STAFF_BY_NAME);) {
                preparedStatement.setString(1, name);

                ResultSet rs = preparedStatement.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String name1 = rs.getString("name");
                    LocalDate dateOfBirth = LocalDate.parse(rs.getString("dateOfBirth"));
                    String address = rs.getString("address");
                    String phoneNumber = rs.getString("phoneNumber");
                    String email = rs.getString("email");
                    String nameDepartment = rs.getString("nameDepartment");
                    staffs.add(new Staff(id, name1, dateOfBirth,address,phoneNumber,email,nameDepartment));
                }
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return staffs;
    }

    public boolean deleteStaff(int id) throws SQLException {
        boolean rowDeleted = false;
        try (Connection connection = Connect_MySQL.getConnection()) {
            assert connection != null;
            try (PreparedStatement preparedStatement = connection.prepareStatement(DELETE_STAFF_SQL);) {
                preparedStatement.setInt(1, id);
                rowDeleted = preparedStatement.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return rowDeleted;
    }

    public boolean updateStaff(Staff staff) throws SQLException {
        boolean rowUpdated;
        try (Connection connection = Connect_MySQL.getConnection()) {
            assert connection != null;
            try (PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_STAFF_SQL);) {
                preparedStatement.setString(1, staff.getName());
                preparedStatement.setString(2, String.valueOf(staff.getDateOfBirth()));
                preparedStatement.setString(3, staff.getAddress());
                preparedStatement.setString(4, staff.getPhoneNumber());
                preparedStatement.setString(5, staff.getEmail());
                preparedStatement.setString(6, staff.getNameDepartment());
                preparedStatement.setInt(7, staff.getId());

                rowUpdated = preparedStatement.executeUpdate() > 0;
            }
        }
        return rowUpdated;
    }

    private void printSQLException(SQLException ex) {
        for (Throwable e : ex) {
            if (e instanceof SQLException) {
                e.printStackTrace(System.err);
                System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());
                Throwable t = ex.getCause();
                while (t != null) {
                    System.out.println("Cause: " + t);
                    t = t.getCause();
                }
            }
        }
    }
}
