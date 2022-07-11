package controller;

import dao.StaffDAO;
import model.Staff;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

@WebServlet(name = "StaffServlet", value = "/staff")
public class StaffServlet extends HttpServlet {
    private StaffDAO staffDAO;

    @Override
    public void init() throws ServletException {
        staffDAO = new StaffDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "";
        }

        try {
            switch (action) {
                case "create":
                    showNewForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    showDeleteForm(request, response);
                    break;
                default:
                    listStaff(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        try {
            switch (action) {
                case "create":
                    insertStaff(request, response);
                    break;
                case "edit":
                    updateStaff(request, response);
                    break;
                case "delete":
                    deleteStaff(request, response);
                    break;
                case "search":
                    searchStaffByName(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    private void listStaff(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException{
        List<Staff> listStaff = staffDAO.selectAllStaffs();
        request.setAttribute("listStaff",listStaff);
        RequestDispatcher dispatcher = request.getRequestDispatcher("staff/list.jsp");
        dispatcher.forward(request,response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<String> departments = staffDAO.selectAllDepartment();
        RequestDispatcher dispatcher = request.getRequestDispatcher("staff/create.jsp");
        request.setAttribute("departments",departments);
        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Staff existingStaff = staffDAO.selectStaff(id);
        List<String> departments = staffDAO.selectAllDepartment();
        RequestDispatcher dispatcher = request.getRequestDispatcher("staff/edit.jsp");
        request.setAttribute("staff", existingStaff);
        request.setAttribute("departments",departments);
        dispatcher.forward(request, response);
    }

    private void showDeleteForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Staff existingStaff = staffDAO.selectStaff(id);
        RequestDispatcher dispatcher = request.getRequestDispatcher("staff/delete.jsp");
        request.setAttribute("staff", existingStaff);
        dispatcher.forward(request, response);
    }

    private void insertStaff(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        LocalDate dateOfBirth = LocalDate.parse(request.getParameter("dateOfBirth"));
        String address = request.getParameter("address");
        String phoneNumber = request.getParameter("phoneNumber");
        String email = request.getParameter("email");
        String nameDepartment = request.getParameter("nameDepartment");
        Staff newStaff = new Staff(id,name, dateOfBirth,address,phoneNumber,email, nameDepartment);
        staffDAO.insertStaff(newStaff);
        listStaff(request,response);
    }

    private void updateStaff(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        LocalDate dateOfBirth = LocalDate.parse(request.getParameter("dateOfBirth"));
        String address = request.getParameter("address");
        String phoneNumber = request.getParameter("phoneNumber");
        String email = request.getParameter("email");
        String nameDepartment = request.getParameter("nameDepartment");
        Staff newStaff = new Staff(id,name, dateOfBirth,address,phoneNumber,email, nameDepartment);
        staffDAO.updateStaff(newStaff);
        listStaff(request,response);
    }

    private void deleteStaff(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int id = Integer.parseInt(request.getParameter("id"));
        staffDAO.deleteStaff(id);
        listStaff(request,response);
    }

    private void searchStaffByName(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String name = request.getParameter("name");
        List<Staff> staffs = staffDAO.selectStaffByName(name);
        RequestDispatcher dispatcher = request.getRequestDispatcher("staff/search.jsp");
        request.setAttribute("staffs", staffs);
        dispatcher.forward(request, response);
    }
}
