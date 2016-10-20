<%@page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="utf-8"%>
<%@ page isErrorPage="false" errorPage="error.jsp"
         import="java.text.DateFormat,com.chat.*" %>
<%@ page import="com.chat.servlet.LoginServlet" %>
<%@ page import="java.util.*" %>
<%
    ChatRoom chatRoom = (ChatRoom) application.getAttribute(LoginServlet.ATTRIBUTE_CHATROOM);
    String nickname = (String) session.getAttribute(LoginServlet.ATTRIBUTE_NICKNAME);
    List<Message> messages;
    Chatter chatter;
    if (nickname != null) {
        chatter = chatRoom.getChatter(nickname);
        messages = chatRoom.getMessages(chatter.getLoginTime());
%>
<HTML>
<HEAD>
    <link rel="stylesheet" type="text/css" href="chat.css">
    <style>
        h3 {
            color: <%=chatter.getColor().toString().toLowerCase()%>;
        }
    </style>
    <%
        int refreshAfter = 1000; // 10 seconds
        String t = application.getInitParameter(LoginServlet.INIT_REFRESH_AFTER); // gets seconds
        if (t != null) {
            try {
                refreshAfter = Integer.parseInt(t);
                refreshAfter = refreshAfter * 1000; // convert to mili seconds
            } catch (NumberFormatException nfe) {
            }
        }
    %>
    <script language="JavaScript" type="text/javascript">
        <!--
        function reload() {
            window.location.reload();
        }

        setInterval('reload()', <%=refreshAfter%>);
        //-->
    </script>
</HEAD>

<BODY onLoad="window.location.hash='#current'" bgcolor="#FFFFFF">
<table width="100%" , border="0">
    <tr>
        <td>
            <h3>
                Hello, <i><%=nickname%>
            </i>
            </h3>
        </td>
        <FORM name="logout" action="<%=request.getContextPath()%>/servlet/logout" method="post" target="_top">
            <TD width="10%" style="align-content: flex-start">
                <input type="hidden" name="nickname"
                       value="<%=session.getAttribute(LoginServlet.ATTRIBUTE_NICKNAME)%>">
                <INPUT type="Submit" value="Logout">
            </TD>
        </FORM>
    </tr>
</table>
<table width="100%" border="0">
    <tr>
        <td width="70%" valign="top">
            <table>
                <tr>
                    <td>
                        <%
                            if (messages.size() > 0) {
                                for (Message message : messages) {
                                    out.write("<font face=\"Arial\" size=\"2\" color=\"" + message.getChatter().getColor().toString().toLowerCase() + "\"><b>" +
                                            message.getChatter().getName() + " (" + DateFormat.getTimeInstance().format(message.getTimeStamp()) + ")&gt;</b></font> " +
                                            message.getMessage() + "<br>\n");
                                }
                                out.write("<a name=\"current\"></a>");
                            } else {
                                out.write("<font color=\"red\" face=\"Arial\" size=\"2\">There are currently no messages in this room</font>");
                            }
                            out.write("<a name=\"current\"></a>");
                        %>
                    </td>
                </tr>
            </table>
        </td>
        <td width="30%" valign="top">
            <table width="100%" border="1" cellpadding="2" cellspacing="0">
                <tr>
                    <td>
                        <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#2C259C">
                            <tr>
                                <td>
                                    <span class="white"><i>Сейчас в чате:</i> (<%=chatRoom.getNoOfChatters()%> человек)</span><br>
                                </td>
                            </tr>
                        </table>
                        <%
                                Set<Map.Entry<String, Chatter>> chatters = chatRoom.getChatters();
                                for (Map.Entry<String, Chatter> entry : chatters) {
                                    out.write("<font face=\"Arial\" size=\"2\" color=\"" + entry.getValue().getColor().toString().toLowerCase() + "\">" +
                                            entry.getValue().getName() + "</a> </font><br>");
                                }
                            } else {
                                response.sendRedirect("login.jsp");
                            }
                        %>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</BODY>
</HTML>