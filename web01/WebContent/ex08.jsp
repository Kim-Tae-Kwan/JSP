<html>
    <head>
        <meta charset="utf-8">
    </head>
    <body>
        <!-- html 주석-->
        <h1>jsp</h1>
        <%
        // 주석
        int su=1234;

        System.out.println(su+1);
        // 내장객체
        // out
        // session
        // pageContent

        for(int i=0; i < 5; i++){
        %>
        <h2><%out.println("su" + (su + i));%></h2>
        <h2><%="su" + (su * i)%></h2>
        <%
        }
        %>
    </body>
</html>