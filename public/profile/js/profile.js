(function($) {
	var placeholders = {
		gender : "Male/Female",
		birthday : "yyyy-mm-dd",
		relationship : "single/married/in a relationship",
		occupation : "what do you do?",
		skills : "what are your skills?",
		tagline : "a brief description of you",
		introduction : "a little about yourself"
	};

	var ref = {
		'bsc-info' : ['gender', 'birthday', 'relationship'],
		work : [ 'occupation', 'skills' ],
		story : [ 'tagline', 'introduction' ]
	};

	function appendEntry(container, key) {
		var entry = key.closest('tr').attr('class');
		var holder = placeholders[entry];
		container.append($("<label>" + key.html() + "</label>"));
		container.append($("<input type='text' class='form-control " + entry + "' placeholder='" + holder + "' value='" + $( "." + entry + " .value").html() + "'></input>"));
		}

	function genDiaPanel(element) {
		var tb = element.closest(".panel-body").find("table");
		var panel = $("<div class='dialog-body'></div>");
		$.each(tb.find(".key"), function(index, key) {
			appendEntry(panel, $(key))
		});
 			return panel;
	

	}

	function updatePanel(diaBody, body) {
		var msg = {};
		$.each(diaBody.find("input"), function(index, key) {
			var value;
			var dia = $(key);
			var classname = dia.attr('class').split(" ")[1];
			if(dia.val() == "") {
				value = dia.attr("placeholder");
			} else {
				value = dia.val();
			}
			body.find("." + classname + " .value").html(value);
			msg[classname] = value;
		});
		return msg;
	}

	$(".edit").click(function(event){
		event.preventDefault();
		var dia = $("<div class='dialog' style='display:hide'></div>");
		var diaBody = genDiaPanel($(this));
		var panel = $(this).closest(".panel");
		dia.append(diaBody);
		dia.dialog({	dialogClass: "",
				width: 600,
				autoOpen: false,
				title: panel.find(".panel-heading").html(),
				closeButton: false,
				modal: true,
				buttons: [
				{
					class: "btn btn-xs",
					width: 70,
					text: "Ok",
					click: function() {
						msg = updatePanel(diaBody, panel.find(".panel-body"));
						$.ajax({
							url : "/profile/update_info",
							type : "POST",
							data : msg,
						});
						$( this ).dialog( "close" );
						$( this ).closest(".ui-dialog").remove();
					}
				},
				{
					class: "btn btn-xs",
					width: 70,
					text: "Cancel",
					click: function() {
						$( this ).dialog( "close" );
						$( this ).closest(".ui-dialog").remove();
					}
				}]
		});
		dia.dialog("open");
	});

	function fillPanel(data) {
		var actualData = $.extend({}, placeholders, data);
		$.each(Object.keys(ref), function(index , value) {
			var list = ref[value];
			var table = $("table." + value);
			$.each(list, function(i, tr) {
				table.find("." + tr + " .value").html(actualData[tr]);
			});
		});
	}

	function uploadDialog() {
/*		var dia = $("<div style='display:hide'></div>");
		dia.append($("<label>choose photo:</label>")).append($("<input type='file' class='form-control upload-img'/>"));

		dia.dialog({
			width: 600,
			autoOpen: false,
			title : "Upload Photo",
			closeButton : false,
			modal : true,
			buttons: [
				{
					class : "btn btn-xs",
					width : 70,
					text : "upload",
					click : function() {
						var reader = new FileReader();
						var uploadFile = $("input.upload-img")[0].files[0];
						reader.readAsText(uploadFile);
						reader.onload = function() {
							var f = new Object();
							f.name = uploadFile.name;
							f.cont = reader.result;
							$.ajax({
								url : "/profile/uploadPic",
								type : "POST",
								data : f
							});
						};
						console.log(uploadFile.type + "\t" + uploadFile.name + "\t" + uploadFile.size);
						$( this ).closest(".ui-dialog").remove();
					}
				},
				{
					class : "btn btn-xs",
					width : 70,
					text : "Cancel",
					click: function() {
						var some = $( this );
						$( this ).dialog("close");
						$( this ).closest(".ui-dialog").remove();
					}
				}
			]
		});
		dia.dialog("open");
 */
		var dia = $("div.upload-img");
		dia.dialog({
			width: 600,
			autoOpen: false,
			title : "Upload Photo",
			closeButton : false,
			modal : true,
			buttons: [
				{
					class : "btn btn-xs",
					width : 70,
					text : "upload",
					click : function() {
						$("form.upload-form").submit();
						$(".img-profile").attr("src", "http://placehold.it/200x200&text=Me").show();

//						console.log(uploadFile.type + "\t" + uploadFile.name + "\t" + uploadFile.size);
//						$( this ).closest(".ui-dialog").remove();
					}
				},
				{
					class : "btn btn-xs",
					width : 70,
					text : "Cancel",
					click: function() {
						var some = $( this );
						$( this ).dialog("close");
//						$( this ).closest(".ui-dialog").remove();
					}
				}
			]
		});
		dia.dialog("open");
	}

	function afterLoad() {
		$.ajax(	{
				url : "/profile/ret_data",
				type : "GET",
				dataType : 'json'
		})
		.done(function(data) {
			if ( data["picture"].indexOf("/") == -1) {
				$(".img-profile").attr("src", "http://placehold.it/200x200&text=Me").show();
			} else {
				$(".img-profile").attr("src", data["picture"]).show();
			}
			$("p.user-name").html(data["firstname"] + " " + data["lastname"]).css("display", "inline");
			fillPanel(data);
			$.each($(".profile"), function(index, value) {
				$(value).show();
			});
			$(".photo-wrapper").mouseenter(function() {
				$(".btn-pro-img").show();
			})
			.mouseleave(function() {
				$(".btn-pro-img").hide();
			})
			.click(function(event) {
				event.preventDefault();
				uploadDialog();
			});
		});
	}

	$( document ).ready(afterLoad);
})(jQuery);
