package com.chat.servlet;

import com.chat.ChatRoom;
import com.chat.Chatter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * The class <class>{@link LogoutServlet}</class> defines the servlet for logouting of the user.
 */
public class LogoutServlet extends HttpServlet {
    private String contextPath;

    @Override
    public void init() throws ServletException {
        super.init();
        contextPath = getServletContext().getContextPath();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ChatRoom chatRoom = (ChatRoom) getServletContext().getAttribute(LoginServlet.ATTRIBUTE_CHATROOM);
        String nickname = request.getParameter(LoginServlet.ATTRIBUTE_NICKNAME);
        if (nickname != null) {
            if (chatRoom != null) {
                chatRoom.removeChatter(nickname);
                request.getSession().invalidate();
                response.getWriter().write("<font color=\"blue\">You successfully logged out</font><br>");
                response.getWriter().write("<a href=" + contextPath + "/login.jsp>Login again</a>");
            } else {
                response.sendRedirect(contextPath + "/login.jsp");
            }
        } else {
            response.sendRedirect(contextPath + "/login.jsp");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
