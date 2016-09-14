<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/meta_css.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitiona<html>
<head>
		<title>新增保单</title>
		<link href="${ctx}/common/css/main/style.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${ctx}/common/js/jquery/jquery-1.7.2.min.js"></script>
		<script type="text/javascript" src="${ctx}/common/js/validate.js"></script>
		<script type="text/javascript" src="${ctx}/common/js/pub.js"></script>
		<script type="text/javascript" src="${ctx}/common/js/Common.js"></script>	
		<script type="text/javascript">
			function savePolicy(ctx){
				var id=$("#id").val();
				var url;
				if(id==null || id==""){
					url=ctx+"/insignificant/addPolicy.do";
				}else{
					url=ctx+"/insignificant/updatePolicy.do";
				}
				var f = formValidate("1");
				if(f){
					pauseButtonDisplay(10);
					$.ajax({
						cache:true,
						type:"POST",
						url:url,
						data:$('#policyForm').serialize(),
						async:false,
						error:function(request){
							alert("Connection error");
						},
						success: function(data){
							if(id==null || id==""){
								location.reload();
							}
							$("#mess").html("<font color='red'>"+data+"</font>");
						}
					});
				}
			}
			function closewin(){
				//window.opener.location.reload();
				window.close();
			}
			window.onload = function(){
				if($("#id").val()=="" && $("#age").val()==""){
					/* var strDate="";
					var myDate = new Date();
					var year=myDate.getFullYear();
					var month=myDate.getMonth()+1;
					var date=myDate.getDate();
					if(month<10)month="0"+month;
					if(date<10)date="0"+date;
					strDate=year+"-"+month+"-"+date; 
					$("#workTime").val(strDate); */
					
				};
			}	
			
			function checkAge(str) {
				//当输入非数字和超过两位数时，自动回删此字符
				var template = /^[1-9][0-9]?$/;
				if (!template.test(str)) {
					str = str.substring(0, str.length - 1);
					document.getElementById("policy.age").value = str;
				}
			}
			function changingName(str) {
				//alert(str);
				var a = str;
				var template = /[\u4E00-\u9FA5]$/;
				if (!template.test(a)) {
					a = a.substring(0, a.length - 1);
					//alert(a);
					document.getElementById("policy.clientName").value = a;
				}

			}
		</script>
</head>

	<body>
		<div class="fzxx">
			<form id="policyForm" name="policyForm" method="post">
				<div class="fzxx">
				<div class="biaoti">
					<div class="biaoti-left1"></div>
					<div class="biaoti-left2">保单</div>
				</div>
				<%-- <input type="hidden" id="id" name="policyList[0].id" value="${policy.id}"/> --%>
				<%-- <input type="hidden" id="createTime" name="policyList[0].createTime" value="${policy.createTime}"/> --%>
				<table align="center" class="data" id="data">
					<tr>
						<th style="width: 10%">保单号(5位)：</th>
						<td align="left" style="width: 12%">
							<div id="sq">
								<%--  <flex:mySelect id="policy" name="policyList[0].clientName" style="width:90%"
								value="${policy.clientName}" dataSource="generalCodeSelect" required="true"
								dicType="policy" headValue="--请选择--"></flex:mySelect> --%>
								<flex:myInput id="policy.id" name="policyList[0].id"
									value="${policy.id}" required="false" style="width: 90%"
									validate="isDecimal" readonly="true" />
							</div></td>
						<th style="width: 5%">姓名：</th>
						<td align="left" style="width: 12%">
							<div id="sq">
								<%--  <flex:mySelect id="policy" name="policyList[0].clientName" style="width:90%"
								value="${policy.clientName}" dataSource="generalCodeSelect" required="true"
								dicType="policy" headValue="--请选择--"></flex:mySelect> --%>
								<flex:myInput id="policy.clientName"
									name="policyList[0].clientName" value="${policy.clientName}"
									onkeyup="changingName(this.value)" required="true"
									style="width: 90%" />
							</div></td>
						<th style="width: 8%">出生日期：</th>
						<td align="left" style="width: 10%">
							<div id="sq">
								<input type="text" id="policy.birthday" size="15"
									name="policyList[0].birthday" value="${policy.birthday}"
									onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
									required="true" readonly="readonly">
							</div></td>
						<th style="width: 5%">年龄：</th>
						<td align="left" style="width: 10%">
							<div id="sq">
								<flex:myInput id="policy.age" name="policyList[0].age"
									value="${policy.age}" onkeyup="checkAge(this.value)"
									required="true" style="width: 90%" validate="isDecimal" />
							</div></td>
						<th style="width: 10%">性别</th>
						<td align="left">
							<div id="sqr">
								<select id="policy.gender" name="policyList[0].gender"
									style="width:90%">
									<option value="male"
										<c:if test="${policy.gender=='male'}">selected</c:if>>男</option>
									<option value="famale"
										<c:if test="${policy.gender=='famale'}">selected</c:if>>女</option>
								</select>
							</div></td>
					</tr>
					<tr align="center">
						<td colspan="10">
						<flex:myButton onclick="savePolicy('${ctx}')" value="保存" cssclass="inputan4" /> 
						<flex:myButton onclick="closewin();" value="关闭" cssclass="inputan4" />
						</td>
					</tr>
				</table>

			</div>
			</form>
			<div style="text-align: center" id="mess">
			</div>
		</div>		
	</body>
</html>