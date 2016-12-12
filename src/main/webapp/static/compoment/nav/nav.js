var targetTriggerNode;
$(function () {

    var bg = $('.bgDiv');
    var downNav = $('.downNav');

    $(".downContextMenuBtn").each(function(){
        var that = this;
        $(that).on('click', function () {
            bg.css({
                display: "block",
                transition: "opacity .1s"
            });
            downNav.css({
                bottom: "0px",
                transition: "bottom .1s"
            });
            targetTriggerNode = $(that);
        });
    });


    $(".downNav span").each(function () {
        var dom = $(this);
        dom.on('click', function () {
            hideImmediately();
            var dtClickfun = dom.attr("data-clickfun");
            if(dtClickfun){
                eval(dtClickfun+"();");
            }
        });
    });


    bg.on('click', function () {
        hideImmediately();
    });

    function hideNav() {
        downNav.css({
            bottom: "-50%",
            webkitTransition:"bottom .3s",
            oTransition:"bottom .3s",
            mozTransition:"bottom .3s",
            transition: "bottom .3s"
        });
        bg.css({
            display: "none",
            transition: "display .5s"
        });
    }

    function hideImmediately() {
        downNav.css({
            bottom: "-50%",
            webkitTransition:"bottom .1s",
            oTransition:"bottom .1s",
            mozTransition:"bottom .1s",
            transition: "bottom .1s"
        });
        bg.css({
            display: "none",
            transition: "display .1s"
        });
    }
});