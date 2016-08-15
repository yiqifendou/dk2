(function($) {
	$.fn.renderTemplate = function(templateId,dataObj) {
		jQuery(this).html(template(templateId, dataObj));
	};
})(jQuery);