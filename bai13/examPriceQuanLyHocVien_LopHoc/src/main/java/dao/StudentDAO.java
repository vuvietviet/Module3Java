package dao;

import connect.Connect_MySQL;
import model.Student;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class StudentDAO {
    private static final String INSERT_STUDENT_SQL = "INSERT INTO Student (id,name,dateOfBirth,address,phoneNumber, email, nameClass) VALUES (?, ?, ?,?,?,?,?);";
    private static final String SELECT_STUDENT_BY_ID = "select * from student where id = ?;";
    private static final String SELECT_STUDENT_BY_NAME = "select * from student where name LIKE concat('%',?,'%');";
    private static final String SELECT_ALL_STUDENTS = "select * from student;";
    private static final String SELECT_ALL_CLASSES = "select * from class;";
    private static final String DELETE_STUDENT_SQL = "delete from Student where id = ?;";
    private static final String UPDATE_STUDENT_SQL = "update Student set name = ?,dateOfBirth = ?,address = ?,phoneNumber = ?,email= ?, nameClass =? where id = ?;";

    public StudentDAO() {
    }

    public void insertStudent(Student student) throws SQLException {
        try (Connection connection = Connect_MySQL.getConnection()) {
            assert connection != null;
            try (PreparedStatement preparedStatement = connection.prepareStatement(INSERT_STUDENT_SQL)) {
                preparedStatement.setInt(1, student.getId());
                preparedStatement.setString(2, student.getName());
                preparedStatement.setString(3, String.valueOf(student.getDateOfBirth()));
                preparedStatement.setString(4, student.getAddress());
                preparedStatement.setString(5, student.getPhoneNumber());
                preparedStatement.setString(6, student.getEmail());
                preparedStatement.setString(7, student.getNameClass());
                System.out.println(preparedStatement);
                preparedStatement.executeUpdate();
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    public Student selectStudent(int id) {
        Student student = null;
        try (Connection connection = Connect_MySQL.getConnection()) {
            assert connection != null;
            try (PreparedStatement preparedStatement = connection.prepareStatement(SELECT_STUDENT_BY_ID);) {
                preparedStatement.setInt(1, id);
                System.out.println(preparedStatement);
                ResultSet rs = preparedStatement.executeQuery();

                while (rs.next()) {
                    String name = rs.getString("name");
                    LocalDate dateOfBirth = LocalDate.parse(rs.getString("dateOfBirth"));
                    String address = rs.getString("address");
                    String phoneNumber = rs.getString("phoneNumber");
                    String email = rs.getString("email");
                    String nameClass = rs.getString("nameClass");
                    student = new Student(id, name, dateOfBirth,address,phoneNumber,email,nameClass);
                }
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return student;
    }


    public List<Student> selectAllStudents() {
        List<Student> students = new ArrayList<>();
        try (Connection connection = Connect_MySQL.getConnection()) {
            assert connection != null;
            try (PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_STUDENTS);) {
                System.out.println(preparedStatement);
                ResultSet rs = preparedStatement.executeQuery();

                while (rs.next()) {
                    int id = rs.getInt("id");
                    String name = rs.getString("name");
                    LocalDate dateOfBirth = LocalDate.parse(rs.getString("dateOfBirth"));
                    String address = rs.getString("address");
                    String phoneNumber = rs.getString("phoneNumber");
                    String email = rs.getString("email");
                    String nameClass = rs.getString("nameClass");
                    students.add(new Student(id, name, dateOfBirth,address,phoneNumber,email,nameClass));
                }
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return students;
    }

    public List<String> selectAllClasses() {
        List<String> classes = new ArrayList<>();
        try (Connection connection = Connect_MySQL.getConnection()) {
            assert connection != null;
            try (PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_CLASSES);) {
                ResultSet rs = preparedStatement.executeQuery();

                while (rs.next()) {
                    classes.add(rs.getString("nameClass"));
                }
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return classes;
    }

    public List<Student> selectStudentByName(String name) {
        List<Student> students = new ArrayList<>();
        try (Connection connection = Connect_MySQL.getConnection()) {
            assert connection != null;
            try (PreparedStatement preparedStatement = connection.prepareStatement(SELECT_STUDENT_BY_NAME);) {
                preparedStatement.setString(1, name);

                ResultSet rs = preparedStatement.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String name1 = rs.getString("name");
                    LocalDate dateOfBirth = LocalDate.parse(rs.getString("dateOfBirth"));
                    String address = rs.getString("address");
                    String phoneNumber = rs.getString("phoneNumber");
                    String email = rs.getString("email");
                    String nameClass = rs.getString("nameClass");
                    students.add(new Student(id, name1, dateOfBirth,address,phoneNumber,email,nameClass));
                }
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return students;
    }

    public boolean deleteStudent(int id) throws SQLException {
        boolean rowDeleted = false;
        try (Connection connection = Connect_MySQL.getConnection()) {
            assert connection != null;
            try (PreparedStatement preparedStatement = connection.prepareStatement(DELETE_STUDENT_SQL);) {
                preparedStatement.setInt(1, id);
                rowDeleted = preparedStatement.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return rowDeleted;
    }

    public boolean updateStudent(Student student) throws SQLException {
        boolean rowUpdated;
        try (Connection connection = Connect_MySQL.getConnection()) {
            assert connection != null;
            try (PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_STUDENT_SQL);) {
                preparedStatement.setString(1, student.getName());
                preparedStatement.setString(2, String.valueOf(student.getDateOfBirth()));
                preparedStatement.setString(3, student.getAddress());
                preparedStatement.setString(4, student.getPhoneNumber());
                preparedStatement.setString(5, student.getEmail());
                preparedStatement.setString(6, student.getNameClass());
                preparedStatement.setInt(7, student.getId());

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
