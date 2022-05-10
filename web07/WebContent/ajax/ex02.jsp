<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script type="text/javascript" src="../js/jquery-1.12.4.min.js"></script>
    <script type="text/javascript">
        $(function(){
            $('#target').load('source.html',function(responseText,textStatus,xhr){
                console.log(textStatus);
            });
        });
    </script>
</head>
<body>
    <h2>parm : <%=request.getParameter("name")%></h2>
    
</body>
</html>