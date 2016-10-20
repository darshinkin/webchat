package com.chat.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.chat.ChatRoom;
import com.chat.Chatter;
import com.chat.Color;
import com.chat.Message;

import java.io.IOException;

/**
 * Class the <class>{@link LoginServlet}</class> defines the servlet for user's login to the chat.
 */
public class LoginServlet extends HttpServlet {
    public static final String ATTRIBUTE_CHATROOM = "chatroom";
    public static final String ATTRIBUTE_NICKNAME = "nickname";
    public static final String PARAMETER_NICKNAME = "nickname";
    public static final String PARAMETER_COLOR = "color";
    public static final String INIT_PARAMETER_SESSION_TIMEOUT = "sessionTimeout";
    public static final String INIT_REFRESH_AFTER = "refreshAfter";
    public static final String INIT_MAX_NO_OF_MESSAGES = "maxNoOfMessages";
    public static final String PARAMETER_MESSAGESBOX = "messagebox";

    private String contextPath;
    private final int MAX_MESSAGES = 25;
    private Chatter system;

    @Override
    public void init() throws ServletException {
        super.init();
        contextPath = getServletContext().getContextPath();
        String s = getServletContext().getInitParameter(INIT_MAX_NO_OF_MESSAGES);
        ChatRoom room = new ChatRoom();
        room.setMaximumNoOfMessages(s != null ? Integer.parseInt(s) : MAX_MESSAGES);
        getServletContext().setAttribute(ATTRIBUTE_CHATROOM, room);
        system = new Chatter("system", Color.BLACK, new java.util.Date().getTime());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect(contextPath + "/login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        String nickname = request.getParameter(PARAMETER_NICKNAME);
        nickname = nickname.trim().toLowerCase();
        String color = request.getParameter(PARAMETER_COLOR);
        if (validationParameters(nickname, color)) {
            try {
                ChatRoom room = (ChatRoom) getServletContext().getAttribute(ATTRIBUTE_CHATROOM);
                boolean chatterexists = room.chatterExists(nickname);
                if (chatterexists) {
                    response.sendRedirect(contextPath + "/login.jsp?d=t&n=" + nickname);
                } else {
                    HttpSession session = request.getSession(true);
                    int timeout = 1800; // 30 minutes
                    String t = getServletContext().getInitParameter(INIT_PARAMETER_SESSION_TIMEOUT); // gets Minutes
                    if (t != null) {
                        timeout = Integer.parseInt(t);
                        timeout = timeout * 60;
                    }
                    session.setMaxInactiveInterval(timeout);
                    session.setAttribute(ATTRIBUTE_NICKNAME, nickname);

                    Chatter chatter = new Chatter(nickname, color, new java.util.Date().getTime());
                    room.addChatter(chatter);
                    room.addMessage(new Message(system, nickname + " has joined.", new java.util.Date().getTime()));
                    response.sendRedirect(contextPath + "/chat.jsp");

                }
            } catch (Exception exception) {
                System.out.println("Exception thrown in LoginServlet: " + exception.getMessage());
                exception.printStackTrace();
                response.sendRedirect(contextPath + "/error.jsp");
            }
        } else {
            response.sendRedirect(contextPath + "/login.jsp?ic=t");
        }
    }

    private boolean validationParameters(String nickname, String color) {
        return nickname != null && nickname.length() > 3 && nickname.indexOf(" ") == -1 && color != null;
    }
}
