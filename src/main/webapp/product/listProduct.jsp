<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="com.model2.mvc.service.product.ProductService"%>
<%@ page contentType="text/html; charset=euc-kr" %>

<%@ page import="java.util.*"  %>


<html>
<head>
<title>상품 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-3.6.3.min.js" type="text/javascript"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script type="text/javascript">

	function fncGetProductList(currentPage, searchOrderType, menu) {
		$("#currentPage").val(currentPage);
		$("menu").val(menu);
		$("searchOrderType").val(searchOrderType);
	   	document.detailForm.submit();		
	}
	
	
	$(function () {
		 
		$( "td.ct_btn01:contains('검색')" ).on("click" , function() {
			//Debug..
			//alert(  $( "td.ct_btn01:contains('검색')" ).html() );
			fncGetProductList(1, ${search.searchOrderType}, ${param.menu});
		});
		
		$( ".clickable:nth-child(3)" ).on("click" , function() {
			//Debug..
			//alert(  $( this ).text().trim() );
			self.location ="/product/getProduct?prodNo="+$(this).children('input:hidden').val()+"&menu=${param.menu}";
		});
		
		
		
		$( ".clickable:nth-child(3)" ).css("color" , "red");
		$("h7").css("color" , "red");
		
		$(".ct_list_pop:nth-child(${search.pageSize+1}n+7)" ).css("background-color" , "whitesmoke");
		
		
		
		
		$.ajax( 
					{
						url : "/json/product/getProduct/"+$( '.ct_list_pop td:nth-child(3)' ).eq(0).children('input:hidden').val() ,
						method : "GET" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(JSONData , status) {
							
							//Debug...
							//alert(status);
							//Debug...
							//alert("JSONData : \n"+JSONData);
							//alert("JSONData : \n"+JSON.stringify(JSONData));
							var detail=	JSONData.prodDetail;
							
							
							//Debug...									
							//alert(displayValue);
							$( '.ct_list_pop td:nth-child(3)' ).eq(0).attr('title',detail);
						}
					}
			);// end of ajax
			
			$( '.ct_list_pop td:nth-child(3)' ).tooltip();
		
	
			
			
		
			
	});
	
</script>

</head>

<body bgcolor="#ffffff" text="#000000">
<c:set var = "pageType" value="product" scope="request"/>

<div style="width:98%; margin-left:10px;">

<form name="detailForm" action="listProduct" method="post">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">
					<c:choose>
						<c:when test = "${param.menu eq 'manage'}">
							상품 관리
						</c:when>
		
						<c:when test = "${param.menu eq 'search'}">
							상품 목록조회
						</c:when>
					</c:choose>
					</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px" onChange = "javaScript:fncGetProductList('${resultPage.currentPage }','${param.menu }')">
					<c:if test = "${user.role eq 'admin'}">
						<option value="0" ${ search.searchCondition == 0 ?" selected":""}>상품번호</option>
					</c:if>
					<option value="1" ${ search.searchCondition == 1 ?" selected":""}>상품명</option>
					<option value="2" ${ search.searchCondition == 2 ?" selected":""}>상품가격	</option>
			</select>
			<c:choose>
				<c:when test="${search.searchCondition == 2}">
					&nbsp;
					최소가<input type="text" name="searchMinPrice" value="${search.searchMinPrice }" class="ct_input_g" style="width:100px; height:19px" />
					&nbsp;
					최대가<input type="text" name="searchMaxPrice" value="${search.searchMaxPrice }" class="ct_input_g" style="width:100px; height:19px" />
				</c:when>
				
				<c:otherwise>
					<input type="text" name="searchKeyword" value="${search.searchKeyword }" class="ct_input_g" style="width:200px; height:19px" />
				</c:otherwise>
			</c:choose>
		</td>
			
			
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<a href="javascript:fncGetProductList('1', '${param.menu }');">검색</a>
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	
	<tr>
		<td align="right">
			<input type="hidden" id="searchOrderType" name="searchOrderType" value="${param.menu}">
		</td>
		
		<jsp:include page="../common/searchOrderTypeNavigator.jsp"/>
				
	</tr>
	
	<tr>
		
		<td colspan="11" >전체  ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage} 페이지</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">가격</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">등록일</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">재고상태</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	
	<c:set var="i" value="0"/>
	<c:forEach var="product" items = "${list}">
		<c:set var="i" value="${i+1}"/>
		 
	<tr class="ct_list_pop">
		<td align="center">${i }</td>
		<td></td>
			
				<c:choose>
					<c:when test = "${(user.role eq 'user') && (product.stock > 0)}">
						<td class ='clickable' id = 'purchase' align="left"  title = "">
							<input type = 'hidden' value = '${product.prodNo}' />
							${product.prodName}
						</td>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test = "${user.role eq 'admin'}">
								<td class ='clickable' id = 'updateProduct' align="left"  title = "">
									<input type = 'hidden' value = '${product.prodNo}' />
									${product.prodName}
								</td>
							</c:when>
							<c:otherwise>
								<td align="left" >
									${product.prodName }
								</td>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
			
		
		<td></td>
		<td align="left">${product.price }</td>
		<td></td>
		<td align="left">${product.regDate }</td>
		<td></td>
		<td align="left">
		<c:choose>
			<c:when test="${param.menu eq 'search' }">
				<c:choose>
					<c:when test ="${! (user.role eq 'admin') }">
						<c:choose>
							<c:when test = "${product.stock > 0 }">
							 	판매중
					 		</c:when>
					 		<c:otherwise>
								재고 없음
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						${product.stock }
					</c:otherwise>
				</c:choose>
			</c:when>
			<c:when test="${param.menu eq 'manage' }">
					${product.stock }
			</c:when>
		</c:choose>
		</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>	

</c:forEach>
	
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
		
			<%--
			<% if( resultPage.getCurrentPage() > resultPage.getPageUnit() ){ %>
					<a href="javascript:fncGetProductList('<%=resultPage.getCurrentPage()-1%>', '<%=menu %>')">◀ 이전</a>
			<% } %>

			<%	for(int i=resultPage.getBeginUnitPage();i<= resultPage.getEndUnitPage() ;i++){	%>
					<a href="javascript:fncGetProductList('<%=i %>', '<%=menu %>')"><%=i %></a>
			<% 	}  %>
	
			<% if( resultPage.getEndUnitPage() < resultPage.getMaxPage() ){ %>
					<a href="javascript:fncGetProductList('<%=resultPage.getCurrentPage()+1%>', '<%=menu %>')">이후 ▶</a>
			<% } %>
			 --%>
			<input type="hidden" id="currentPage" name="currentPage" value=""/>
			<input type="hidden" id="menu" name="menu" value=""/>
			
			<jsp:include page="../common/pageNavigator.jsp"/>
			
    	</td>
	</tr>
</table>
<!--  페이지 Navigator 끝 -->

</form>

</div>
</body>
</html>
