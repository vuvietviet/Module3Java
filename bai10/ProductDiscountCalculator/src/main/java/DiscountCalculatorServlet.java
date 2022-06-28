import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "DiscountCalculatorServlet", value = "/discount")
public class DiscountCalculatorServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        float listPrice = Float.parseFloat(request.getParameter("listPrice"));
        float discount = Float.parseFloat(request.getParameter("discount"));
        String description = request.getParameter("description");

        double discountAmount = listPrice * discount * 0.01;
        double price = listPrice - discountAmount;


        PrintWriter writer = response.getWriter();
        writer.println("<html>");
        writer.println("<h1>Description: " + description + "</h1>");
        writer.println("<h1>List price: " + listPrice + "</h1>");
        writer.println("<h1>Discount percent: " + discount + "</h1>");
        writer.println("<h1>Discount amount: " + discountAmount + "</h1>");
        writer.println("<h1>Price: " + price + "</h1>");
        writer.println("</html>");
    }
}
