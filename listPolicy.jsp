<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=gbk"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/meta_css.jsp"%>
<%@ include file="/common/meta_js.jsp"%>
<%@ page import="flex.common.common.CommonMethod" %>
<%String userCode=CommonMethod.getUserCode();%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>保单操作</title>
    <script type="text/javascript" src="${ctx}/common/js/jquery/jquery-1.7.2.min.js"></script>
		<script type="text/javascript" src="${ctx}/pages/basicinfo/js/basicinfo.js"></script>
		<script type="text/javascript" src="${ctx}/common/js/Common.js"></script>
		<script type="text/javascript" src="${ctx}/pages/personmanage/transfer/js/transferInfo.js"></script>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache,must-revalidate">
		<script type="text/javascript" src="${ctx}/common/js/validate.js"></script>
		<script type="text/javascript" src="${ctx}/common/js/pub.js"></script>
		<script type="text/javascript">
			 /* window.onload = function(){
					if($("#workTime").val()==""){
						var strDate="";
						var myDate = new Date();
						var year=myDate.getFullYear();
						var month=myDate.getMonth()+1;
						var date=myDate.getDate();
						if(month<10)month="0"+month;
						if(date<10)date="0"+date;
						strDate=year+"-"+month+"-"+date;
						$("#workTime").val(strDate);
					}; 
				} */	
				function queryPolicy(ctx){
					var fm=document.getElementById("policyForm")
					fm.action=ctx+"/insignificant/listPolicy.do";
					fm.submit();
				}
				function toAddPolicy(){
					var url = "${ctx}/pages/insignificant/addOrUpdatePolicy.jsp";
					window.showModalDialog(url,window,"dialogWidth:850px;dialogHeight:200px;status:no");
				}
				function updatePolicy(pId){
					var url = "${ctx}/insignificant/preUpdatePolicy.do?id="+pId;
					var flag=window.showModalDialog(url,window,"dialogWidth:850px;dialogHeight:200px;status:no");
				}
				function deletePolicy(pId){
					$.ajax({
						cache:true,
						type:"POST",
						url:"${ctx}/insignificant/deletePolicy.do",
						data:{"id":pId},
						async:false,
						error:function(request){
							alert("Connection error");
						},
						success: function(data){
							alert("删除成功！");
							location.reload();
						}
					});
					
				}
				/* function batchExport(){
					var fm=document.getElementById("workForm")
					fm.action="${ctx}/zzWork/downloadWork.do";
					fm.submit();
				} */
		</script>
  </head>
  <body>
<form id="policyForm" name="policyForm" method="post" >
		<div class="fzxx">
			<div class="biaoti">
				<div class="biaoti-left1"></div>
				<div class="biaoti-left2">保单列表</div>
			</div>
			<table align="center" class="data" id="data">
				<tr>
					<th style="width: 45%" align="center">姓名：</th>
					<td align="left" style="width: 15%">
						<div id="sq">
							<flex:myInput id="policy.clientName" name="policy.clientName"
								value="${policy.clientName}" required="true" style="width: 90%" />
						</div>
					</td>
					<%-- <th style="width: 15%">
							时间：
						</th>
						<td align="left" style="width: 15%">
							<div id="sq">
								<input type="text" id="workTime" size="20"
									name="zzwork.workTime"
									value="${zzwork.workTime}"
									onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate">
							</div>	
						</td> --%>
				</tr>
				<tr align="center">
					<td colspan="8">
						<div align="center">
							<flex:myButton id="query" onclick="queryPolicy('${ctx}');"
								value="查询" cssclass="inputan2" />
							<flex:myButton onclick="toAddPolicy();" value="新增"
								cssclass="inputan2" />
							<%-- &nbsp;&nbsp;
						<flex:myButton onclick="batchExport('${ctx}');" value="批量导出" cssclass="inputan4" /> --%>
						</div>
					</td>
				</tr>
			</table>
		</div>
    <div class="fzxx">
    	<div class="biaoti">
        <div class="biaoti-left1"></div>
        	<div class="biaoti-left2">保单列表 </div>
        	<div class="biaoti-right1"> 
				每页显示						
				<flex:myInput maxLength="2" id="pageSize" style ="width:25px;" validate="isNumber"
						name="pageSize" value="${pageSize==null?15:(pageSize)}"/>
				记录
			</div>
        </div>
		<div>
		<div style="OVERFLOW: auto;  WIDTH: 100%; COLOR: rgb(0,0,0); ">
		<s:if test="#request.PAGER.items.size() > 0">
			<table align="center" class="data">
				<tr>
					<th style="text-align: center;width:10%; white-space: nowrap;">
							保单号
					</th>
					<th style="text-align: center;width:10%; white-space: nowrap;">
							客户姓名
					</th>
					<th style="text-align: center;width:10%; white-space: nowrap;">
							性别
					</th>
					<th style="text-align: center;width:50%;">
						       年龄
					</th>
					<th style="text-align: center;width:10%; white-space: nowrap;">
						     出生日期
					</th>
					<th style="text-align: center;width:7%;">
						    操作
					</th>
				</tr>
			<s:iterator id="bas" value="#request.PAGER.items" status="stuts">
		        <tr>
		        	<td align="center">
					 ${bas.id}
                    </td>
					<td align="center">
					    ${bas.clientName}
                    </td>
					<td align="center">
						<c:if test="${bas.gender=='male'}">男</c:if>
					    <c:if test="${bas.gender=='famale'}">女</c:if>
                    </td>                    
                    <td align="center">
						${bas.age }
					</td>
					<td align="center">
                    	<fmt:formatDate value="${bas.birthday }" pattern="yyyy-MM-dd "/> 
                    </td>
                    <td colspan="2">
                    	  <a href="javascript:updatePolicy(${bas.id});" style="color: #378FD6;cursor: pointer;">
							<img alt="" src="/flex/common/images/edit.gif" title="修改">
						  </a>
                    	 <a href="javascript:deletePolicy(${bas.id});" style="color: #378FD6;cursor: pointer;">
							<img alt="" src="/flex/common/images/detete.gif" title="删除">
						  </a>
                    </td>
				</tr>
			</s:iterator>
		  </table>
	    </s:if>
	    </div>
             
		<s:else>
			<table align="center" class="data">
				<s:if test='{#request.PAGER.totalCount == 0}'>
			  		<tr align="center"><td><font style="color: red; font-weight: blod; font-size: 14;">系统无数据！</font></td></tr>
				</s:if>
				<s:else>
					<tr align="center"><td><font style="color: red; font-weight: blod; font-size: 14;">请查询...</font></td></tr>
				</s:else>
			</table>
		</s:else>
	</div>
	</div>
	 
    </form>
  </body>
   <s:if test="#request.PAGER.items.size() > 0">
		 <!--分页信息 --> 
		<table align="right">
			<tr height="20">
				<td>
					<s:property value="#request.PAGER.navigatorBar" escape="false" />
				</td>
			</tr>
			<tr height="20">
				<td>
				    &nbsp;
				</td>
			</tr>
		</table>
		</s:if>
</html>
