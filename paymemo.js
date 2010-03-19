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

$(function(){
	$('.paymemo').each(function(){
		var e = this;
		var db = $(e).attr('id');
		$(e).children('h2').text(db);
		$(e).children('form').attr('action','paymemo.cgi');
		$(e).children('form').children('input[name=db]').attr('value',db);
		$.getJSON('paymemo.cgi?db='+db,function(json){
			var table = $(e).children('table');
			table.append('<caption>Total: '+addFigure(json['total'])+'</caption>');
			jQuery.each(json['list'],function(){
				table.append('<tr><th>'+this[0]+'</th><td>'+addFigure(this[1])+'</td></tr>');
			});
		});
	});
});

