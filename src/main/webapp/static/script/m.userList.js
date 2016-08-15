$(function(){
		var c = com.lc.crm.dk.c;
		$("#userlistPage .resetLoginPwd").on("click",function(){
			var selectedSize = $("#userlistPage tr.selected").length;
			if(selectedSize<1){
				alertMsg.error("请选择用户");
			}else{
				alertMsg.confirm("确定要重置密码吗？", {
					okCall: function(){
						var id = $("#userlistPage tr.selected").attr("data-id");
						$.ajax({
							url:c.ctx+"/user/resetLoginPwd.do?id="+id,
							type:"post",
							dataType:"json",
							success:function(rs){
								if (rs.status==0) {
									alertMsg.correct("重置成功！");
								} else {
									alertMsg.error(rs.msg);
								}
							},
							error:function(){
								alertMsg.error("系统繁忙，请稍后再试！")
							}
						});
					}
				});
			}
		});
		
		$("#userlistPage .reset").on("click",function(){
			$("#userlistPage input[name='account']").val("");
			$("#userlistPage input[name='name']").val("");
			$("#userlistPage input[name='phone']").val("");
			$("#userlistPage select[name='stus']").val("");
			$("#userlistPage a[name='stus']").text("所有状态"); 
		});
	});