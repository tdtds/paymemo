/*
 paymemo.js

 Copyright (C) 2010 TADA Tadashi <t@tdtds.jp>
 You can modify and distribue this under GPL.
 */

function addFigure(str) {
	var num = new String(str).replace(/,/g, "");
	while(num != (num = num.replace(/^(-?\d+)(\d{3})/, "$1,$2")));
	return num;
}

function addNewItem(db) {
	var item = $('div#'+db+' .paymemo-item')[0].value;
	var amount = $('div#'+db+' .paymemo-amount')[0].value;
	$.ajax({
		type: 'POST',
		url: paymemoAPI,
		data: 'item='+item+'&amount='+amount+'&db='+db,
		dataType: 'json',
		success: function(json) {
			var caption = $('div#'+db+' caption');
			var item = json['list'][0];
			caption.html('Total: '+addFigure(json['total']));
			caption.after('<tr><th>'+item[0]+'</th><td>'+item[1]+'</td></tr>');
			$('div#'+db+' .paymemo-item')[0].value = '';
			$('div#'+db+' .paymemo-amount')[0].value = '';
			$('div#'+db+' .paymemo-item')[0].focus();
		}
	});
	return false;
}

/*
 initialize
 */
$(function(){
	$('.paymemo').each(function(){
		var e = this;
		var f = $(e).children('form');
		var db = $(e).attr('id');
		$(e).children('h2').text(db);
		f.attr('action',paymemoAPI);
		f.children('input[name=db]').attr('value',db);
		f.children('.paymemo-submit').attr('onclick','return addNewItem("'+db+'");');
		$('.paymemo-item')[0].focus();
		$.getJSON(paymemoAPI+'?db='+db,function(json){
			var table = $(e).children('table');
			table.append('<caption>Total: '+addFigure(json['total'])+'</caption>');
			jQuery.each(json['list'],function(){
				table.append('<tr><th>'+this[0]+'</th><td>'+addFigure(this[1])+'</td></tr>');
			});
		});
	});
});

