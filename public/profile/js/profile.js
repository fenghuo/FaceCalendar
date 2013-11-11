(function($) {
	var placeholders = {
		gender : "Male/Female",
		birthday : "yyyy-mm-dd",
		relationship : "single/married/in a relationship",
		occupation : "what do you do?",
		skills : "what are your skills?",
		tagline : "a brief description of you",
		description : "a little about yourself"
	};

	var ref = {
		'bsc-info' : ['gender', 'birthday', 'relationship'],
		work : [ 'occupation', 'skills' ],
		story : [ 'tagline', 'description' ]
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
						updatePanel(diaBody, panel.find(".panel-body"));
						$( this ).dialog( "close" );
					}
				},
				{
					class: "btn btn-xs",
					width: 70,
					text: "Cancel",
					click: function() {
						$( this ).dialog( "close" );
					}
				}]
		});
		dia.dialog("open");
	});

	function fillPanel(data) {
		var actualData = $.extend({}, placeholders, data[0]);
		$.each(Object.keys(ref), function(index , value) {
			var list = ref[value];
			var table = $("table." + value);
			$.each(list, function(i, tr) {
				table.find("." + tr + " .value").html(actualData[tr]);
			});
		});
	}

	function afterLoad() {
		$.ajax(	{
				url : "/profile/ret_data",// "data.json.php",
				type : "GET",
				dataType : 'json'
		})
		.done(function(data) {
			fillPanel(data);
			$.each($(".profile"), function(index, value) {
				$(value).show();
			});
		});
	}

	$( document ).ready(afterLoad);
})(jQuery);
