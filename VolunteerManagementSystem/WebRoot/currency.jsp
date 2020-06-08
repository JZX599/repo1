<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
		<meta charset="UTF-8">
		
		
	<link rel="shortcut icon" href="img/favicon.ico" />
	</head>
  
  <body>
   		
  </body>
  <script type="text/javascript">
	/*网站访问次数*/
	function saveLocalStorage() {
	}

	function loadLocalStorage() {
	}

	var local_num = localStorage.getItem('NVaule') ? localStorage.getItem('NVaule') : 0;
	document.getElementById("local_num").innerHTML = local_num;
	localStorage.setItem('NVaule', +local_num + 1);
</script>
</html>
