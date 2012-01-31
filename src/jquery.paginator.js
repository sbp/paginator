/*!
 * jQuery Paginator v1.1, http://sbp.so/paginator
 * Copyright 2011 Sean B. Palmer, Apache License 2.0
 */

$(function() {
	var body = $('body');
	var content = false;

	function cache() {
		var children = body.children().detach();
		content = $('<div>').append(children);
	}

	function uncache() {
		body.append(content.children());
		content = false;
	}

	function add_page() {
		var page = $('[data-id=' + location.hash + ']', content);
		if (!page.size()) return uncache();
		body.append(page.clone(true));
		$(window).scrollTop(0);
	}

	function delete_page() {
		body.empty();
	}

	$(window).hashchange(function() {
		var source = content ? 'page' : 'body';
		var dest = location.hash ? 'page' : 'body';

		switch ([source, dest].toString()) {
			case ['body', 'page'].toString():
				cache(); add_page();
				break;

			case ['page', 'page'].toString():
				delete_page(); add_page();
				break;

			case ['page', 'body'].toString():
				delete_page(); uncache();
				break;
		}
	});

	$('[id]').each(function() {
		var e = $(this); 
		e.attr('data-id', '#' + e.attr('id')).removeAttr('id');
	});

	$(window).hashchange();
});
