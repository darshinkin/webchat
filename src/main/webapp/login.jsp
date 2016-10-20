<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Web Chat</title>
    <link rel="stylesheet" type="text/css" href="chat.css">
</head>
<body>
<TABLE  width="40%" border="0" cellspacing="1" cellpadding="1" align="center">
    <%
        String d = request.getParameter("d");
        String n = request.getParameter("n");
        String ic = request.getParameter("ic");

        if (d != null && d.equals("t")) {
    %>
    <TR>
        <TD>
            <TABLE width="100%" border="0" cellspacing="1" cellpadding="1" align="center">
                <TR>
                    <TD colspan="2" align="center">
                        <SPAN class="error">Nickname exists</SPAN><BR>
                    </TD>
                </TR>
                <TR>
                    <TD colspan="2">
                        Nickname <B><%=n%>
                    </B> has already been taken please select some other nick.
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <%
    } else if (ic != null && ic.equals("t")) {
    %>
    <TR>
        <TD colspan="2">
            <TABLE width="100%" border="0" cellspacing="1" cellpadding="1" align="center">
                <TR>
                    <TD colspan="2" align="center">
                        <SPAN class="error">Incomplete information</SPAN>
                    </TD>
                </TR>
                <TR>
                    <TD colspan="2">
                        <b>Color</b> and <b>Nickname</b> must be entered and nickname must be at least <b>4</b> characters
                        long and must not contain any <b>space</b>.
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <%
        }
    %>
    <tr>
        <td colspan="2" style="align-content: flex-start">
            <h5>Добро пожаловать в чат</h5>
        </td>
    </tr>
    <TR>
        <TD colspan="2" class="panel">
            <FORM name="login" method="post" action="<%=request.getContextPath()%>/servlet/login">
                <TABLE width="100%" border="0">
                    <TR>
                        <TD width="30%" class="white">
                            Представтесь:
                        </TD>
                        <TD width="70%">
                            <INPUT type="text" name="nickname" size="15" required="true">
                        </TD>
                    </TR>
                    <TR>
                        <TD width="30%" class="white">
                            Выберите цвет текста:
                        </TD>
                        <TD width="70%">
                            <SELECT size="1" name="color" required="true">
                                <OPTION style="color: black" value="black">
                                    Черный
                                </OPTION>
                                <OPTION style="color: red" value="red">
                                    Красный
                                </OPTION>
                                <OPTION style="color: blue" value="blue">
                                    Синий
                                </OPTION>
                                <OPTION style="color: green" value="green">
                                    Зеленый
                                </OPTION>
                            </SELECT>
                        </TD>
                    </TR>
                    <TR>
                        <TD>
                            &nbsp;
                        </TD>
                        <TD>
                            <INPUT type="submit" name="Submit" value="Отправить">
                        </TD>
                    </TR>
                </TABLE>
            </FORM>
        </TD>
    </TR>
</TABLE>
</body>
</html>
