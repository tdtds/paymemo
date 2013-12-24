/*
 paymemo.js

 Copyright (C) 2013 TADA Tadashi <t@tdtds.jp>
 You can modify and distribue this under GPL.
 */

$(function(){
	/*
	 * setup against CSRF
	 */
	jQuery.ajaxSetup({
		beforeSend: function(xhr) {
			var token = jQuery('meta[name="_csrf"]').attr('content');
			xhr.setRequestHeader('X_CSRF_TOKEN', token);
		}
	});

	/*
	 * add commas each 3 digits
	 */
	function addFigure(str) {
		var num = new String(str).replace(/,/g, "");
		while(num != (num = num.replace(/^(-?\d+)(\d{3})/, "$1,$2")));
		return num;
	}

	$('body').tabs();

	$('div.paymemo').each(function(){
		var $div = $(this);
		var $form = $('form', $div);
		var wallet = $div.attr('id');

		$form.on('submit', function(){
			$('.paymemo-submit', $form).attr('disabled', true);
			$.ajax({
				type: 'POST',
				url: '/' + wallet,
				data: $form.serialize(),
				dataType: 'json'
			}).done(function(json){
				var caption = $('caption', $div);
				var payment = json['list'][0];

				caption.html('Total: ' + addFigure(json['total']));
				caption.after('<tr><th>' + payment['item'] + '</th><td>' + addFigure(payment['amount']) + '</td></tr>');
				$('.paymemo-submit', $form).attr('disabled', false);
				$('.paymemo-item', $form).val('');
				$('.paymemo-amount', $form).val('');
				$('.paymemo-item', $form).focus();
			});
			return false;
		});

		$('input')[0].focus();

		$.ajax({
			url: '/' + wallet + '.json',
			type: 'GET',
			dataType: 'json',
			cacehe: false
		}).done(function(json){
			var table = $('table', $div);
			table.empty();
			table.append('<caption>Total: ' + addFigure(json['total']) + '</caption>');
			jQuery.each(json['list'], function(){
				table.append('<tr><th>' + this['item'] + '</th><td>' + addFigure(this['amount']) + '</td></tr>');
			});
		}).fail(function(XMLHttpRequest, textStatus, errorThrown){
			alert('error: ' + textStatus);
		});
	});
});

