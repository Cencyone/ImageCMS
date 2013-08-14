var isTouch = 'ontouchstart' in document.documentElement,
        activeClass = 'active',
        clonedC = 'cloned';
wnd = $(window),
        body = $('body'),
        mainBody = $('.main-body');
/*
 *imagecms frontend plugins
 ** @author Domovoj
 * @copyright ImageCMS (c) 2013, Avgustus <domovoj1@gmail.com>
 **/
function pluralStr(i, str) {
    function plural(a) {
        if (a % 10 == 1 && a % 100 != 11)
            return 0
        else if (a % 10 >= 2 && a % 10 <= 4 && (a % 100 < 10 || a % 100 >= 20))
            return 1
        else
            return 2;
    }

    switch (plural(i)) {
        case 0:
            return str[0];
        case 1:
            return str[1];
        default:
            return str[2];
    }
}
function serializeForm(el) {
    var $this = $(el);
    return $this.attr('data-data', $this.closest('form').serialize());
}
jQuery.expr[':'].regex = function(elem, index, match) {
    var matchParams = match[3].split(','),
            validLabels = /^(data|css):/,
            attr = {
        method: matchParams[0].match(validLabels) ?
                matchParams[0].split(':')[0] : 'attr',
        property: matchParams.shift().replace(validLabels, '')
    },
    regexFlags = 'ig',
            regex = new RegExp(matchParams.join('').replace(/^\s+|\s+$/g, ''), regexFlags);
    return regex.test(jQuery(elem)[attr.method](attr.property));
}

String.prototype.trimMiddle = function()
{
    var r = /\s\s+/g;
    return $.trim(this).replace(r, ' ');
}
String.prototype.pasteSAcomm = function() {
    var r = /\s,/g;
    return this.replace(r, ',');
}

$.exists = function(selector) {
    return ($(selector).length > 0);
}
$.existsN = function(nabir) {
    return (nabir.length > 0);
}
$.testNumber = function(e) {
    if (!e)
        var e = window.event;
    var key = e.keyCode;
    if (key == null || key == 0 || key == 8 || key == 13 || key == 9 || key == 46 || key == 37 || key == 39)
        return true;
    keyChar = String.fromCharCode(key);
    if (!/\d/.test(keyChar)) {
        return false;
    }
    else
        return true;
}
$.onlyNumber = function(el) {
    $(el).live('keypress', function(e) {
        if (!$.testNumber(e)) {
            $(this).tooltip();
            return false;
        }
    });
}
$.fn.pricetext = function(e, rank) {
    var $this = $(this);
    rank != undefined ? rank = rank : rank = true;
    $(document).trigger({type: 'textanimatechange', el: $this, ovalue: parseFloat($this.text().replace(/\s+/g, '')), nvalue: e, rank: rank})
    return $this;
}

$(document).bind('textanimatechange', function(e) {
    var $this = e.el,
            nv = e.nvalue,
            ov = e.ovalue,
            rank = e.rank,
            dif = nv - ov,
            temp = ov;

    if (dif > 0) {
        var ndif = dif,
                step = Math.floor(dif / 100);
    }
    else
    {
        ndif = Math.abs(dif),
                step = -Math.floor(ndif / 100);
    }
    var cond = '',
            numb = setInterval(function() {
        temp += step;
        cond = temp < nv;
        if (dif < 0)
            cond = temp > nv;
        if (cond && step != 0)
            $this.text(rank ? temp.toString().replace(/(\d)(?=(\d\d\d)+([^\d]|$))/g, '$1 ') : temp)
        else {
            $this.text(rank ? nv.toString().replace(/(\d)(?=(\d\d\d)+([^\d]|$))/g, '$1 ') : nv)
            clearInterval(numb)
            temp = nv;
        }
    }, 1)

})
function setcookie(name, value, expires, path, domain, secure)
{
    var today = new Date();
    today.setTime(today.getTime());
    if (expires)
    {
        expires = expires * 1000 * 60 * 60 * 24;
    }
    var expiresDate = new Date(today.getTime() + (expires));
    document.cookie = name + "=" + encodeURIComponent(value) +
            ((expires) ? ";expires=" + expiresDate.toGMTString() : "") + ((path) ? ";path=" + path : "") +
            ((domain) ? ";domain=" + domain : "") +
            ((secure) ? ";secure" : "");
}

var ie = jQuery.browser.msie,
        ieV = jQuery.browser.version,
        ltie7 = ie && (ieV <= 7),
        ltie8 = ie && (ieV <= 8);
(function($) {
    var methods = {
        init: function(options) {
            if ($.existsN($(this))) {
                var settings = $.extend({
                    wrapper: $(".frame-label:has(.niceCheck)"),
                    elCheckWrap: '.niceCheck',
                    evCond: false,
                    classRemove: null,
                    before: function() {
                    },
                    after: function() {
                    }
                }, options);
                var frameChecks = $(this),
                        wrapper = settings.wrapper,
                        elCheckWrap = settings.elCheckWrap,
                        evCond = settings.evCond,
                        classRemove = settings.classRemove,
                        frameChecks = frameChecks.selector.split(','),
                        after = settings.after;
                wrapper.find(elCheckWrap).children('input').mousedown(function(e) {
                    $(this).closest(wrapper).click();
                }).keyup(function(e) {
                    if (e.keyCode == 32)
                        $(this).closest(wrapper).click();
                })
                $.map(frameChecks, function(i, n) {
                    var frameChecks = $(i.replace(' ', ''));
                    frameChecks.each(function() {
                        var thisFrameChecks = $(this);
                        thisFrameChecks.find(elCheckWrap).each(function() {
                            var $this = $(this).removeClass(classRemove),
                                    $thisInput = $this.children();
                            if (!$thisInput.is('[disabled="disabled"]')) {
                                methods.changeCheckStart($this, $thisInput);
                            }
                            else {
                                methods.checkUnChecked($this, $thisInput)
                                methods.CheckallDisabled($this, $thisInput);
                            }
                        })
                    }).find(wrapper).unbind('click').bind('click', function(e) {
                        if ($(e.target).is(':input'))
                            return false;
                        var $this = $(this),
                                $thisD = $this.is('.disabled'),
                                nstcheck = $this.find(elCheckWrap);
                        if (nstcheck.length == 0)
                            nstcheck = $this
                        if (!$thisD) {
                            if (!evCond) {
                                methods.changeCheck(nstcheck);
                                after(frameChecks, $this, nstcheck);
                            }
                            else
                                settings.before(frameChecks, $this, nstcheck);
                        }
                    });
                });
            }
        },
        changeCheckStart: function(el, input) {
            var el = el,
                    input = input;
            if (input.attr("checked")) {
                methods.checkChecked(el, input);
            }
            else {
                methods.checkUnChecked(el, input);
            }
        },
        checkChecked: function(el, input) {
            var el = el;
            if (el == undefined)
                el = this;
            var input = input;
            if (input == undefined)
                input = $(this).find("input");
            el.addClass(activeClass).parent().addClass(activeClass);
            input.attr("checked", true);
            $(document).trigger({'type': 'nstCheck.CC', 'el': el, 'input': input});
        },
        checkUnChecked: function(el, input) {
            var el = el;
            if (el == undefined)
                el = this;
            var input = input;
            if (input == undefined)
                input = $(this).find("input");
            el.removeClass(activeClass).parent().removeClass(activeClass);
            input.attr("checked", false);
            $(document).trigger({'type': 'nstCheck.CUC', 'el': el, 'input': input});
        },
        changeCheck: function(el)
        {
            var el = el;
            if (el == undefined)
                el = this;
            var input = el.find("input");
            if (!input.attr("checked")) {
                methods.checkChecked(el, input);
            }
            else {
                methods.checkUnChecked(el, input);
            }
        },
        changeCheckallchecks: function(el)
        {
            var el = el;
            if (el == undefined)
                el = this;
            el.each(function() {
                var input = el.find("input");
                el.addClass(activeClass).parent().addClass(activeClass);
                input.attr("checked", true);
            })
        },
        changeCheckallreset: function(el)
        {
            var el = el;
            if (el == undefined)
                el = this;
            el.each(function() {
                var input = el.find("input");
                el.removeClass(activeClass).parent().removeClass(activeClass);
                input.attr("checked", false);
            });
        },
        CheckallDisabled: function(el)
        {
            var el = el;
            if (el == undefined)
                el = this;
            el.each(function() {
                var input = el.find("input");
                el.removeClass(activeClass).addClass('disabled').parent().addClass('disabled').removeClass(activeClass);
                input.attr('disabled', 'disabled').removeAttr('checked');
            });
        },
        CheckallEnabled: function(el)
        {
            var el = el;
            if (el == undefined)
                el = this;
            el.each(function() {
                var input = el.find("input");
                el.removeClass('disabled').parent().removeClass('disabled');
                input.removeAttr('disabled');
            });
        }
    };
    $.fn.nStCheck = function(method) {
        if (methods[method]) {
            return methods[ method ].apply(this, Array.prototype.slice.call(arguments, 1));
        } else if (typeof method === 'object' || !method) {
            return methods.init.apply(this, arguments);
        } else {
            $.error('Method ' + method + ' does not exist on jQuery.nStCheck');
        }
    };
    $.nStCheck = function(m) {
        return methods[m];
    };
})(jQuery);
(function($) {
    var methods = {
        init: function(options) {
            var optionsRadio = $.extend({
                wrapper: $(".frame-label:has(.niceRadio)"),
                elCheckWrap: '.niceRadio',
                classRemove: null,
                before: function() {
                },
                after: function() {
                }
            }, options),
                    settings = optionsRadio;
            var $this = $(this);
            if ($.existsN($this)) {
                $this.each(function() {
                    var $this = $(this),
                            after = settings.after,
                            before = settings.before,
                            classRemove = settings.classRemove,
                            wrapper = settings.wrapper,
                            elCheckWrap = settings.elCheckWrap,
                            input = $this.find(elCheckWrap).find('input');
                    $this.find(elCheckWrap).each(function() {
                        methods.changeRadioStart($(this), classRemove, after, true);
                    });
                    input.each(function() {
                        var input = $(this);
                        $(input.data('link')).focus(function(e) {
                            if (e.which == 0)
                                methods.radioCheck(input.parent(), input, after, false);
                        })
                    })
                    $this.find(wrapper).unbind('click.radio').bind('click.radio', function(e) {
                        if (!$(this).find('input').is(':disabled')) {
                            before($(this));
                            methods.changeRadio($(this).find(elCheckWrap), after, false);
                        }
                    });
                    input.bind('mousedown change', function(e) {
                        return false;
                    })
                })
            }
        },
        changeRadioStart: function(el, classRemove, after, start)
        {
            var input = el.find("input");
            if (input.is(":checked")) {
                methods.radioCheck(el, input, after, start);
            }
            el.removeClass(classRemove);
            return false;
        },
        changeRadio: function(el, after, start)
        {
            var input = el.find("input");
            methods.radioCheck(el, input, after, start);
        },
        radioCheck: function(el, input, after, start) {
            el.addClass(activeClass);
            el.parent().addClass(activeClass);
            input.attr("checked", true);
            $(input.data('link')).focus();
            input.closest('form').find('[name=' + input.attr('name') + ']').not(input).each(function() {
                methods.radioUnCheck($(this).parent(), $(this))
            });
            after(el, start);
            $(document).trigger({'type': 'nStRadio.RC', 'el': el, 'input': input});
        },
        radioUnCheck: function(el, input) {
            el.removeClass(activeClass);
            el.parent().removeClass(activeClass);
            input.attr("checked", false);
            $(document).trigger({'type': 'nStRadio.RUC', 'el': el, 'input': input});
        }
    };
    $.fn.nStRadio = function(method) {
        if (methods[method]) {
            return methods[ method ].apply(this, Array.prototype.slice.call(arguments, 1));
        } else if (typeof method === 'object' || !method) {
            return methods.init.apply(this, arguments);
        } else {
            $.error('Method ' + method + ' does not exist on jQuery.nStRadio');
        }
    };
    $.nStRadio = function(m) {
        return methods[m];
    };
})(jQuery);
(function($) {
    var methods = {
        init: function(options) {
            var settings = $.extend({
                item: 'ul > li',
                duration: 300,
                searchPath: "/shop/search/ac",
                inputString: $('#inputString'),
                minValue: 3
            }, options);
            function postSearch() {
                $(document).trigger({'type': 'autocomplete.before', 'el': inputString});
                $.post(searchPath, {
                    queryString: inputString.val()
                }, function(data) {
                    try {
                        var dataObj = JSON.parse(data),
                                html = _.template($('#searchResultsTemplate').html(), {
                            'items': dataObj
                        });
                    } catch (e) {
                        var html = e.toString();
                    }
                    $thisS.html(html);
                    $thisS.fadeIn(durationA, function() {
                        $(document).trigger({'type': 'autocomplete.after', 'el': $thisS, 'input': inputString});
                        $thisS.bind('click.autocomplete', function(e) {
                            e.stopImmediatePropagation();
                        })
                        body.bind('click.autocomplete', function(event) {
                            closeFrame();
                        }).bind('keydown.autocomplete', function(e) {
                            if (!e)
                                var e = window.event;
                            if (e.keyCode == 27) {
                                closeFrame();
                            }
                        });
                    });
                    if (inputString.val().length == 0)
                        closeFrame();
                    selectorPosition = -1;
                    var itemserch = $thisS.find(itemA);
                    itemserch.mouseover(function() {
                        var $this = $(this);
                        $this.addClass('selected');
                        selectorPosition = $this.index();
                        lookup(itemserch, selectorPosition);
                    }).mouseleave(function() {
                        $(this).removeClass('selected');
                    });
                    lookup(itemserch, selectorPosition);
                });
            }
            function lookup(itemserch, selectorPosition) {
                inputString.keyup(function(event) {
                    if (!event)
                        var event = window.event;
                    var code = event.keyCode;
                    if (code == 38 || code == 40)
                    {
                        if (code == 38)
                        {
                            selectorPosition -= 1;
                        }
                        if (code == 40)
                        {
                            selectorPosition += 1;
                        }

                        if (selectorPosition < 0)
                        {
                            selectorPosition = itemserch.length - 1;
                        }
                        if (selectorPosition > itemserch.length - 1)
                        {
                            selectorPosition = 0;
                        }
                        itemserch.removeClass('selected');
                        itemserch.eq(selectorPosition).addClass('selected');
                        return false;
                    }

                    // Enter pressed
                    if (code == 13)
                    {
                        var itemserchS = itemserch.filter('.selected');
                        if ($.existsN(itemserchS))
                            itemserchS.each(function(i, el) {
                                window.location = $(el).attr('href');
                                window.location = $(el).find('a').attr('href');
                            });
                        else {
                            $thisS.closest('form').submit();
                        }
                    }
                })
            }

            function closeFrame() {
                $(document).trigger({'type': 'autocomplete.close', 'el': $thisS});
                $thisS.stop().fadeOut(durationA);
                $thisS.unbind('click.autocomplete');
                body.unbind('click.autocomplete').unbind('keydown.autocomplete');
            }

            var $thisS = $(this),
                    itemA = settings.item,
                    durationA = settings.duration,
                    searchPath = settings.searchPath,
                    selectorPosition = -1,
                    inputString = settings.inputString,
                    minValue = settings.minValue;

            inputString.keyup(function(event) {
                var $this = $(this);
                var inputValL = $this.val().length;
                if (inputValL > minValue) {
                    $this.tooltip('remove');
                    if (!event)
                        var event = window.event;
                    var code = event.keyCode;
                    if (code != 27 && code != 40 && code != 38 && code != 13 && inputValL != 0 && $.trim($this.val()) != "")
                        postSearch();
                    else if (inputValL == 0)
                        closeFrame();
                }
                else
                    $(document).trigger({type: 'autocomplete.fewLength', el: $this, value: minValue});
            }).blur(function() {
                closeFrame();
            });
        }
    }
    $.fn.autocomplete = function(method) {
        if (methods[method]) {
            return methods[ method ].apply(this, Array.prototype.slice.call(arguments, 1));
        } else if (typeof method === 'object' || !method) {
            return methods.init.apply(this, arguments);
        } else {
            $.error('Method ' + method + ' does not exist on jQuery.autocomplete');
        }
    };
    $.autocomplete = function(m) {
        return methods[m];
    };
})(jQuery);
(function($) {
    var methods = {
        init: function(options) {
            var tooltip = $('.tooltip').not('.' + clonedC),
                    settings = $.extend({
                title: this.attr('data-title'),
                otherClass: false,
                effect: 'notalways',
                me: true
            }, options);
            var $this = $(this), textEl = $this.find(genObj.textEl),
                    me = settings.me;
            if (textEl.is(':visible') && $.existsN(textEl) && me)
                return false;
            tooltip.text(settings.title);
            if (settings.otherClass !== false)
                tooltip.addClass(settings.otherClass);

            var tempeff = false;
            if (settings.effect == 'notalways') {
                tooltip.hide();
                tempeff = 'stop';
            }
            if (tempeff) {
                tooltip.css({
                    'left': Math.ceil(this.offset().left - (tooltip.actual('outerWidth') - this.outerWidth()) / 2),
                    'top': this.offset().top - tooltip.actual('outerHeight')
                }).stop().fadeIn(300, function() {
                    $(document).trigger({'type': 'tooltip.show', 'el': $(this)});
                });
            }
            else {
                tooltip.css({
                    'left': Math.ceil(this.offset().left - (tooltip.actual('outerWidth') - this.outerWidth()) / 2),
                    'top': this.offset().top - tooltip.actual('outerHeight')
                }).fadeIn(300, function() {
                    $(document).trigger({'type': 'tooltip.show', 'el': $(this)});
                });
            }
            $this.unbind('mouseout.tooltip').bind('mouseout.tooltip', function() {
                $(this).tooltip('remove');
            })
            $this.filter(':input').unbind('blur.tooltip').bind('blur.tooltip', function() {
                $(this).tooltip('remove');
            })

        },
        remove: function() {
            $('.tooltip').stop().fadeOut(300, function() {
                $(document).trigger({'type': 'tooltip.hide', 'el': $(this)});
            });
        }
    };
    $.fn.tooltip = function(method) {
        if (methods[method]) {
            return methods[ method ].apply(this, Array.prototype.slice.call(arguments, 1));
        } else if (typeof method === 'object' || !method) {
            return methods.init.apply(this, arguments);
        } else {
            $.error('Method ' + method + ' does not exist on jQuery.tooltip');
        }
    };
    $.tooltip = function(m) {
        return methods[m];
    };
    $('[data-rel="tooltip"]').live('mouseover', function() {
        $(this).tooltip();
    }).live('mouseout', function() {
        $(this).tooltip('remove');
    })
})(jQuery); /*plugin menuImageCms for main menu shop*/
(function($) {
    var methods = {
        position: function(menuW, $thisL, dropW, drop, $thisW, countColumn, sub2) {
            if (menuW - $thisL < dropW) {
                drop.removeClass('left-drop')
                if (drop.children().children().length >= countColumn && !sub2)
                    drop.css('right', 0).addClass('right-drop');
                else {
                    var right = menuW - $thisW - $thisL;
                    if ($thisL + $thisW < dropW)
                        right = menuW - dropW;
                    drop.css('right', right).addClass('right-drop');
                }
            } else {
                drop.removeClass('right-drop')
                if (sub2 && dropW > menuW)
                    drop.css('left', $thisL).addClass('left-drop');
                else if (drop.children().children().length >= countColumn)
                    drop.css('left', 0).addClass('left-drop');
                else
                    drop.css('left', $thisL).addClass('left-drop');
            }
        },
        init: function(options) {
            var menu = $(this);
            if ($.existsN(menu)) {
                var sH = 0,
                        settings = $.extend({
                    item: this.find('li'),
                    effectOn: 'fadeIn',
                    effectOff: 'fadeOut',
                    duration: 0,
                    drop: 'li > ul',
                    countColumn: 'none',
                    columnPart: false,
                    columnPart2: false,
                    sub3Frame: 'ul ul',
                    columnClassPref: 'column_',
                    columnClassPref2: 'column2_',
                    durationOn: 0,
                    durationOff: 0,
                    dropWidth: null,
                    sub2Frame: null,
                    evLF: 'hover',
                    evLS: 'hover',
                    hM: 'hoverM',
                    menuCache: false,
                    activeFl: activeClass,
                    parentTl: 'li',
                    refresh: false
                }, options);
                var menuW = menu.width(),
                        menuItem = settings.item,
                        drop = settings.drop,
                        dropOJ = $(drop),
                        effOn = settings.effectOn,
                        effOff = settings.effectOff,
                        countColumn = settings.countColumn,
                        columnPart = settings.columnPart,
                        columnPart2 = settings.columnPart2,
                        sub3Frame = settings.sub3Frame,
                        columnClassPref = settings.columnClassPref,
                        columnClassPref2 = settings.columnClassPref2,
                        itemMenuL = menuItem.length,
                        dropW = settings.dropWidth,
                        sub2Frame = settings.sub2Frame,
                        duration = timeDurM = settings.duration,
                        durationOn = settings.durationOn,
                        durationOff = settings.durationOff,
                        evLF = settings.evLF,
                        evLS = settings.evLS,
                        hM = settings.frAClass,
                        refresh = settings.refresh,
                        menuCache = settings.menuCache,
                        activeFl = settings.activeFl,
                        parentTl = settings.parentTl;
                if (menuCache && !refresh) {
                    menu.find('a').each(function() {
                        var $this = $(this);
                        $this.closest(activeFl.split(' ')[0]).removeClass(activeClass);
                        $this.removeClass(activeClass);
                    });
                    menu.find('a[href="' + location.href + '"]').each(function() {
                        var $this = $(this);
                        $this.closest(activeFl.split(' ')[0]).addClass(activeClass);
                        $this.closest(parentTl.split(' ')[0]).addClass(activeClass).prev().addClass(activeClass);
                        $this.addClass(activeClass);
                    })
                }
                if (isTouch) {
                    evLF = 'toggle';
                    evLS = 'toggle';
                }
                if (!refresh) {
                    if (columnPart && !sub2Frame)
                        dropOJ.each(function() {
                            var $this = $(this),
                                    columnsObj = $this.find(':regex(class,' + columnClassPref + '([0-9]+))'),
                                    numbColumn = [];
                            columnsObj.each(function(i) {
                                numbColumn[i] = $(this).attr('class').match(/([0-9]+)/)[0];
                            })
                            numbColumn = $.unique(numbColumn).sort();
                            if (numbColumn.length > 1) {
                                $.map(numbColumn, function(n, i) {
                                    var currC = columnsObj.filter('.' + columnClassPref + n),
                                            classCuurC = currC.first().attr('class');
                                    $this.children().append('<li class="' + classCuurC + '" data-column="' + n + '"><ul></ul></li>');
                                    $this.find('[data-column="' + n + '"]').children().append(currC.clone());
                                })
                                columnsObj.remove();
                            }
                        })
                    if (columnPart2) {
                        dropOJ.find(sub3Frame).each(function() {
                            var $this = $(this),
                                    columnsObj = $this.find(':regex(class,' + columnClassPref2 + '([0-9]+))'),
                                    numbColumn = [];
                            columnsObj.each(function(i) {
                                numbColumn[i] = $(this).attr('class').match(new RegExp(columnClassPref2 + '([0-9]+)'))[0];
                            })
                            numbColumn = $.unique(numbColumn).sort();
                            numbColumnL = numbColumn.length;
                            if (numbColumnL > 1) {
                                $.map(numbColumn, function(n, i) {
                                    var currC = columnsObj.filter('.' + n),
                                            classCuurC = currC.first().attr('class');
                                    $this.children().append('<li class="' + classCuurC + '" data-column="' + n + '"><ul></ul></li>');
                                    $this.find('[data-column="' + n + '"]').children().append(currC.clone());
                                    if (sub2Frame)
                                        $this.addClass('x' + numbColumnL);
                                    else
                                        $this.closest('[data-column]').addClass('x' + numbColumnL);
                                })
                                columnsObj.remove();
                            }
                        })
                        if (!sub2Frame)
                            dropOJ.each(function() {
                                var $this = $(this),
                                        count = 0;
                                $this.find(':regex(class,x([0-9]+))').each(function() {
                                    var $this = $(this),
                                            cxc = $this.attr('class').match(/(x[0-9]+)/);
                                    count += parseInt(cxc[0].match(/([0-9]+)/)[0]);
                                })
                                count += $this.children().children(':not(:regex(class,x([0-9]+)))').length;
                                $this.addClass('x' + count)
                            })
                        $(document).trigger({type: 'columnRenderComplete', el: dropOJ})
                    }
                }
                var k = [];
                menuItem.each(function(index) {
                    var $this = $(this),
                            $thisW = $this.width(),
                            $thisL = $this.position().left,
                            $thisH = $this.height(),
                            $thisDrop = $this.find(drop);
                    k[index] = false;
                    if ($thisH > sH)
                        sH = $thisH;
                    if ($.existsN($thisDrop)) {
                        if (!dropW)
                            dropW2 = $thisDrop.actual('width');
                        else
                            dropW2 = dropW;
                        methods.position(menuW, $thisL, dropW2, $thisDrop, $thisW, countColumn, sub2Frame);
                    }
                    $this.data('kk', 0);
                }).css('height', sH);
                menuItem.find('.helper:first').css('height', sH)

                $('.not-js').removeClass('not-js');
                var hoverTO = '';
                function closeMenu(el, e) {
                    var $this = el,
                            $thisDrop = $this.find(drop);
                    if ($thisDrop.length != 0)
                        menu.removeClass(hM);
                    var menuItemH = menuItem.filter('.' + hM)
                    if (e.type == 'click' && evLF == 'toggle')
                        menuItemH.click()

                    var subH = $thisDrop.children().children('.' + hM);
                    if (e.type == 'click' && evLS == 'toggle')
                        subH.click();
                    $('.firstH, .lastH').removeClass('firstH lastH');
                    clearTimeout(hoverTO);
                }
                menuItem.unbind(evLF)[evLF](
                        function(e) {
                            var $this = $(this),
                                    $thisI = $this.index();
                            $this = $(this).addClass(hM),
                                    $thisDrop = $this.find(drop);
                            if (e.type == 'click' && evLF == 'toggle') {
                                $this.siblings().filter('.' + hM).click()
                            }
                            var subH = dropOJ.children().children('.' + hM);
                            if (e.type == 'click' && evLS == 'toggle')
                                subH.click();
                            if ($thisI == 0)
                                $this.addClass('firstH');
                            if ($thisI == itemMenuL - 1)
                                $this.addClass('lastH');
                            if ($(e.relatedTarget).is(menuItem) || $.existsN($(e.relatedTarget).parents(menuItem)) || $this.data('kk') == 0)
                                k[$thisI] = true;
                            if (k[$thisI]) {
                                hoverTO = setTimeout(function() {
                                    $thisDrop[effOn](durationOn, function() {
                                        $this.data('kk', $this.data('kk') + 1);
                                        $(document).trigger({type: 'menu.showDrop', el: $thisDrop})
                                        if ($thisDrop.length != 0)
                                            menu.addClass(hM);
                                        if (sub2Frame) {
                                            var listDrop = $thisDrop.children();
                                            if (!listDrop.is('[data-height]')) {
                                                var sumHL1 = listDrop.height(),
                                                        dropW = $thisDrop.width();
                                                listDrop.attr('data-height', sumHL1);
                                                isSub2W = $thisDrop.find(sub2Frame).addClass('is-side').actual('width');
                                            }

                                            listDrop.children().each(function() {
                                                var $this = $(this),
                                                        isSub2 = $this.find(sub2Frame);
                                                if ($.existsN(isSub2)) {
                                                    var sumHL2 = isSub2.actual('height');
                                                    if (sumHL2 > sumHL1)
                                                        var koef = Math.ceil(sumHL2 / sumHL1);
                                                    if (koef != undefined) {
                                                        subWL2 = isSub2W * koef;
                                                        if (subWL2 + dropW > menuW) {
                                                            subWL2 = menuW - dropW;
                                                        }
                                                        isSub2.css('width', dropW);
                                                    }
                                                }
                                            }).unbind(evLS)[evLS](function(e) {
                                                var $this = $(this),
                                                        subFrame = $this.find(sub2Frame);
                                                if ($.existsN($this.next())) {
                                                    if (e.type == 'click' && evLS == 'toggle') {
                                                        $this.addClass(hM).siblings().filter('.' + hM).click()
                                                    }
                                                    else
                                                        $this.has(sub2Frame).addClass(hM);
                                                    $thisDrop.css('width', '');
                                                    $thisDrop.children().add(subFrame).css('height', '');
                                                    var dropW = $this.parent().parent().width(),
                                                            sumW = dropW + subFrame.width(),
                                                            subHL2 = subFrame.height(),
                                                            dropDH = $thisDrop.children().data('height');
                                                    if (subHL2 < dropDH)
                                                        subHL2 = dropDH;
                                                    $thisDrop.css('width', sumW);
                                                    $thisDrop.children().add(subFrame).css('height', subHL2);
                                                    e.preventDefault();
                                                }
                                                else {
                                                    return true;
                                                }
                                            }
                                            , function(e) {
                                                var $this = $(this),
                                                        subFrame = $this.find(sub2Frame);
                                                if ($.existsN($this.next())) {
                                                    $thisDrop.css('width', '')
                                                    $thisDrop.children().add(subFrame).css('height', '')
                                                    $this.removeClass(hM)
                                                }
                                            });
                                        }
                                    });
                                }, timeDurM);
                            }
                        }, function(e) {
                    var $this = $(this),
                            $thisI = $this.index();
                    k[$thisI] = true;
                    if ($this.index() == 0)
                        $this.removeClass('firstH');
                    if ($this.index() == itemMenuL - 1)
                        $this.removeClass('lastH');
                    var $thisDrop = $this.find(drop);
                    if ($.existsN($thisDrop)) {
                        if (sub2Frame) {
                            $this.find(drop)[effOff](durationOff, function() {
                                $this.removeClass(hM);
                            });
                        }
                        else {
                            $this.find(drop).stop()[effOff](durationOff, function() {
                                $this.removeClass(hM);
                            });
                        }
                    }
                    else {
                        setTimeout(function() {
                            $this.removeClass(hM);
                        }, durationOff)
                    }
                })
                menu.unbind('hover')['hover'](
                        function(e) {
                            menuItem.each(function() {
                                $(this).data('kk', 0);
                            })
                            e.stopImmediatePropagation();
                            return timeDurM = 0;
                        },
                        function(e) {
                            menuItem.each(function() {
                                $(this).data('kk', -1);
                            })
                            e.stopImmediatePropagation();
                            if (evLF == 'toggle' || evLS == 'toggle') {
                                $(this).find('.' + hM).click();
                            }
                            setTimeout(function() {
                                dropOJ[effOff](durationOff);
                            }, duration)
                            closeMenu(menu, e);
                            return timeDurM = duration;
                        });
                body.unbind('click.menu').bind('click.menu', function(e) {
                    closeMenu(menu, e);
                }).unbind('keydown.menu').bind('keydown.menu', function(e) {
                    if (!e)
                        var e = window.event;
                    if (e.keyCode == 27) {
                        closeMenu(menu, e);
                    }
                });

                dropOJ.find('a').click(function(e) {
                    if (evLS == 'toggle') {
                        if ($.existsN($(this).next()) && sub2Frame) {
                            e.preventDefault();
                            return true;
                        }
                        e.stopPropagation();
                        return true;
                    }
                    else
                        e.stopPropagation();
                });
                menuItem.find('a').click(function(e) {
                    if (!$.existsN($(this).closest(menuItem).find(drop)))
                        e.stopPropagation();
                });
            }
            return menu;
        },
        refresh: function() {
            methods.init.call($(this), $.extend(optionsMenu, {refresh: true}));
            return $(this);
        }
    };
    $.fn.menuImageCms = function(method) {
        if (methods[method]) {
            return methods[ method ].apply(this, Array.prototype.slice.call(arguments, 1));
        } else if (typeof method === 'object' || !method) {
            return methods.init.apply(this, arguments);
        } else {
            $.error('Method ' + method + ' does not exist on jQuery.menuImageCms');
        }
    };
    $.menuImageCms = function(m) {
        return methods[m];
    };
})(jQuery);
/*plugin menuImageCms end*/
(function($) {
    var methods = {
        init: function(options) {
            var $this = $(this);
            if ($.existsN($this)) {
                var settings = $.extend({
                    effectOn: 'show',
                    effectOff: 'hide',
                    durationOn: 0,
                    durationOff: 0,
                    before: function() {
                    },
                    after: function() {
                    }
                }, options);
                var tabsDiv = [],
                        tabsId = [],
                        navTabsLi = [],
                        regRefs = [],
                        thisL = this.length,
                        k = true,
                        refs = [],
                        attrOrdata = [];
                $this.each(function(index) {
                    var $thiss = $(this),
                            effectOn = settings.effectOn,
                            effectOff = settings.effectOff,
                            durationOn = settings.durationOn,
                            durationOff = settings.durationOff;
                    navTabsLi[index] = $thiss.children();
                    refs[index] = navTabsLi[index].children();
                    attrOrdata[index] = refs[index].attr('href') != undefined ? 'attr' : 'data';
                    var tempO = $([]),
                            tempO2 = $([]),
                            tempRefs = [];
                    refs[index].each(function(ind) {
                        var tHref = $(this)[attrOrdata[index]]('href');
                        tempO = tempO.add($(tHref));
                        tempO2 = tempO2.add('[data-id=' + tHref + ']');
                        tempRefs.push(tHref);
                    })
                    tabsDiv[index] = tempO;
                    tabsId[index] = tempO2;
                    regRefs[index] = tempRefs;
                    refs[index].bind('click.tabs', function(e) {
                        wST = wnd.scrollTop();
                        var $this = $(this);
                        if ($this.is('a'))
                            e.preventDefault();
                        var condRadio = $thiss.data('type') == 'radio',
                                condB = !e.start;
                        if (!$this.parent().hasClass('disabled')) {
                            var $thisA = $this[attrOrdata[index]]('href'),
                                    $thisAO = $($thisA),
                                    $thisS = $this.data('source'),
                                    $thisData = $this.data('data'),
                                    $thisSel = $this.data('selector'),
                                    $thisDD = $this.data('drop') != undefined;
                            function tabsDivT() {
                                tabsDiv[index].add(tabsId[index])[effectOff](durationOff).removeClass(activeClass);
                                $thisAO.add('[data-id=' + $thisA + ']')[effectOn](durationOn).addClass(activeClass);
                            }
                            if (!$thisDD) {
                                if (!condRadio || e.button == 0) {
                                    navTabsLi[index].removeClass(activeClass);
                                    $this.parent().addClass(activeClass);
                                    if (!condRadio) {
                                        if (e.start && $thisS != undefined)
                                            tabsDivT()
                                        if ($thisS != undefined && !$thisAO.hasClass('visited')) {
                                            $thisAO.addClass('visited');
                                            $(document).trigger({'type': 'tabs.beforeload', "els": tabsDiv[index], "el": $thisAO});
                                            if ($thisData != undefined)
                                                $.ajax({
                                                    type: 'post',
                                                    url: $thisS,
                                                    data: $thisData,
                                                    success: function(data) {
                                                        $(document).trigger({'type': 'tabs.afterload', "els": tabsDiv[index], "el": $thisAO})
                                                        tabsDivT();
                                                        $thisAO.find($thisSel).html(data)
                                                    }
                                                })
                                            else
                                                $thisAO.load($thisS, function() {
                                                    $(document).trigger({'type': 'tabs.afterload', "els": tabsDiv[index], "el": $thisAO})
                                                    tabsDivT()
                                                })
                                        }
                                        else {
                                            tabsDivT()
                                        }

                                        if (e.scroll)
                                            wnd.scrollTop($this.offset().top);
                                        $(document).trigger({'type': 'tabs.showtabs', 'el': $thisAO})
                                    }
                                    else {
                                        setcookie('listtable', $this.parent().index(), 0, '/');
                                    }
                                }
                            }
                            if (!condRadio) {
                                if (attrOrdata[index] != 'data') {
                                    if (condB) {
                                        var wLH = window.location.hash,
                                                reg = null,
                                                temp = wLH;
                                        try {
                                            reg = wLH.match(new RegExp(regRefs[index].join('|').toString()));
                                        } catch (err) {
                                            reg = null;
                                        }
                                        if (reg != null) {
                                            if (wLH.indexOf($thisA) == -1) {
                                                temp = temp.replace(reg, $thisA)
                                            }
                                            else {
                                                temp += $thisA;
                                            }
                                        }
                                        else {
                                            temp += $thisA;
                                        }
                                        window.location.hash = temp;
                                    }
                                    else if (!$thisDD && k) {
                                        window.location.hash = $.unique(tabs.hashs[0]).join('');
                                        k = false;
                                    }
                                    if ($thisDD && !condB)
                                        $this.trigger('click.drop')
                                }
                            }
                            else if (e.button == 0 && $thiss.data('elchange') != undefined) {
                                refs[index].each(function() {
                                    var $thisDH = $(this).data('href');
                                    if ($thisDH == $thisA)
                                        $($thiss.data('elchange')).addClass($thisA)
                                    else
                                        $($thiss.data('elchange')).removeClass($thisDH)
                                })
                            }
                        }
                        settings.after($thiss);
                        return false;
                    })

                    if (thisL - 1 == index)
                        methods.location(regRefs[index], refs);
                });
                wnd.bind('hashchange', function(e) {
                    function scrollTop(wST) {
                        if (e.scroll || e.scroll == undefined)
                            wnd.scrollTop(wST);
                        wST = wnd.scrollTop();
                    }

                    //chrome bug
                    if ($.browser.webkit)
                        scrollTop(wST - 100);
                    scrollTop(wST);
                    return false;
                })
            }
            return $this;
        },
        location: function(regrefs, refs) {
            var hashs1 = [],
                    hashs2 = [];
            if (location.hash == '')
            {
                var i = 0,
                        j = 0;
                _.map(refs, function(n, i) {
                    var $this = n.first(),
                            attrOrdataL = $this.attr('href') != undefined ? 'attr' : 'data';
                    if ($this.data('drop') == undefined && attrOrdataL != 'data') {
                        hashs1[i] = $this[attrOrdataL]('href');
                        i++;
                    }
                    else if (attrOrdataL == 'data') {
                        hashs2[j] = $this[attrOrdataL]('href');
                        j++;
                    }
                })
                var hashs = [hashs1, hashs2];
            }
            else {
                _.map(refs, function(n, i) {
                    var j = 0,
                            $this = n.first(),
                            attrOrdataL = $this.attr('href') != undefined ? 'attr' : 'data';
                    if (attrOrdataL == 'data') {
                        hashs2[j] = $this[attrOrdataL]('href');
                        j++;
                    }
                });
                var t = location.hash,
                        s = '#',
                        m = s.length, res = 0,
                        i = 0, pos = [];
                while (i < t.length - 1)
                {
                    var ch = t.substr(i, m)
                    if (ch == s) {
                        res += 1;
                        i = i + m
                        pos[res - 1] = t.indexOf(s, i - m)
                    } else
                        i++
                }
                var i = 0;
                while (i < pos.length) {
                    hashs1[i] = t.substring(pos[i], pos[i + 1]);
                    i++;
                }
                var hashs = [hashs1, hashs2];
            }
            tabs = new Object();
            tabs.hashs = hashs;
            methods.startCheck(regrefs, tabs.hashs);
        },
        startCheck: function(regrefs, hashs) {
            var i = 0,
                    hashs = hashs[0].concat(hashs[1]),
                    hashs2 = [].concat(hashs);
            $.map(hashs, function(n, j) {
                if ($.inArray(n, regrefs) >= 0)
                    i++;
                if ($.inArray(n, regrefs) >= 0 && i > 1) {
                    hashs2.splice(hashs2.indexOf(n), 1)
                }
            })
            $.map(hashs2, function(n, i) {
                var attrOrdataNew = "";
                $('[href=' + n + ']').length == 0 ? attrOrdataNew = 'data-href' : attrOrdataNew = 'href';
                $('[' + attrOrdataNew + '=' + n + ']').trigger({'type': 'click.tabs', 'start': true});
            });
        }
    };
    $.fn.tabs = function(method) {
        if (methods[method]) {
            return methods[ method ].apply(this, Array.prototype.slice.call(arguments, 1));
        } else if (typeof method === 'object' || !method) {
            return methods.init.apply(this, arguments);
        } else {
            $.error('Method ' + method + ' does not exist on jQuery.tabs');
        }
    }
    $.tabs = function(m) {
        return methods[m];
    };
})(jQuery);
(function($) {
    var methods = {
        init: function(options) {
            var $this = $(this),
                    settings = $.extend({
                refresh: false,
                after: function() {
                }
            }, options),
                    mouseWhell = settings.mouseWhell,
                    elEven = settings.elEven,
                    onlyDif = settings.onlyDif,
                    allParams = settings.allParams,
                    hoverParent = settings.hoverParent,
                    jScrollPane = settings.jScrollPane || false,
                    after = settings.after,
                    scrollPane = settings.scrollPane,
                    refresh = settings.refresh;
            $this.each(function(index) {
                var $this = $(this),
                        visThis = $this.is(':visible');
                if (visThis) {
                    var left = $this.find(settings.left),
                            right = $this.find(settings.right),
                            liLength = left.length;
                    if (!$this.is('[data-equalHorizCell]')) {
                        var h = 0,
                                liH = [],
                                frameScroll = $this.find(settings.frameScroll),
                                frameScrollC = frameScroll.children(),
                                frameScrollCL = frameScrollC.length,
                                scrollNSP = settings.scrollNSP && $.exists(frameScroll),
                                scrollNSPT = settings.scrollNSPT;
                        for (var j = 0; j < liLength; j++) {
                            nab = $([]);
                            right.each(function() {
                                nab = nab.add($(this).find(elEven).eq(j))
                            })
                            var tempNabir = left.eq(j).add(nab);
                            tempNabir.each(function(index) {
                                var thisCh = $(this);
                                liH[index] = thisCh.outerHeight();
                                liH[index] > h ? h = liH[index] : h = h;
                            });
                            tempNabir.add(tempNabir.find('.helper')).css('height', h).attr('data-equalHorizCell', '');
                            liH = [];
                            h = 0;
                        }
                        var w = 0;
                        frameScroll.children().each(function() {
                            w += $(this).outerWidth(true);
                        })
                        frameScroll.css('width', w);
                        var frameScrollP = frameScroll.parent(),
                                frameScrollPW = frameScrollP.width(),
                                scrollW = w - frameScrollPW;
                        if (scrollNSP && frameScrollCL != 0) {
                            scrollNSPT = $this.find(scrollNSPT);
                            topScrollNSP = scrollNSPT.position().top + scrollNSPT.height();
                            $this.children('.scrollNSP').remove();
                            $this.append('<div class="scrollNSP" style = "overflow:auto;"><div style="width:' + w + 'px;"></div></div>')
                        }
                        var firstScrl = frameScrollP.css('overflow', 'hidden'),
                                secScrl = $([]);
                        if (scrollNSP) {
                            secScrl = $this.children('.scrollNSP');
                            if (jScrollPane)
                                secScrl.addClass('jScrollPane')
                            secScrl.css({
                                'width': frameScrollPW,
                                'top': topScrollNSP
                            })
                        }
                        var api = '';
                        function initNSS() {
                            api = $(secScrl).jScrollPane(scrollPane);
                            api = api.data('jsp');
                            return api;
                        }
                        if (jScrollPane)
                            api = initNSS();
                        function scrollNst(deltaY) {
                            if (jScrollPane)
                                $thisSL = api.getContentPositionX();
                            else
                                $thisSL = $(this).scrollLeft();
                            if ($thisSL != scrollW && deltaY < 0) {
                                if (jScrollPane)
                                    api.scrollToX($thisSL + w / frameScrollCL)
                                else
                                    firstScrl.add(secScrl).scrollLeft($thisSL + w / frameScrollCL);
                                return false;
                            }
                            if ($thisSL > 0 && deltaY > 0) {
                                if (jScrollPane)
                                    api.scrollToX($thisSL - w / frameScrollCL)
                                else
                                    firstScrl.add(secScrl).scrollLeft($thisSL - w / frameScrollCL);
                                return false;
                            }
                        }
                        if ((mouseWhell && scrollW > 0) || isTouch) {
                            firstScrl.add(secScrl).unbind('mousewheel').bind('mousewheel', function(event, delta, deltaX, deltaY) {
                                scrollNst(deltaY);
                            });

                            if (isTouch) {
                                firstScrl.unbind('touchstart touchmove touchend');
                                firstScrl.bind('touchstart', function(e) {
                                    sP = e.originalEvent.touches[0];
                                    sP = sP.pageX;
                                });
                                firstScrl.bind('touchmove', function(e) {
                                    e.stopPropagation();
                                    e.preventDefault();
                                    eP = e.originalEvent.touches[0];
                                    eP = eP.pageX;
                                });
                                firstScrl.bind('touchend', function(e) {
                                    e.stopPropagation();
                                    if (Math.abs(eP - sP) > 200) {
                                        if (eP - sP > 0) {
                                            scrollNst(1);
                                        }
                                        else {
                                            scrollNst(-1);
                                        }
                                    }
                                });
                            }
                        }
                        if (jScrollPane)
                            api.scrollToX(0)
                        else
                            firstScrl.add(secScrl).scrollLeft('0');
                        if (scrollW > 0)
                            secScrl.unbind('scroll').bind('scroll', function() {
                                if (jScrollPane)
                                    $thisSL = api.getContentPositionX();
                                else
                                    $thisSL = $(this).scrollLeft();
                                firstScrl.add(secScrl).scrollLeft($thisSL);
                            });
                        $this.attr('data-equalHorizCell', '');
                    }
                    var right = right.find(hoverParent),
                            left = left.parent(hoverParent).children();
                    left.each(function(ind) {
                        if (ind % 2 == 0)
                            $(this).removeClass('evenC').addClass('oddC');
                        else
                            $(this).removeClass('oddC').addClass('evenC')
                    });
                    right.each(function() {
                        $(this).find(elEven).each(function(ind) {
                            var $this = $(this),
                                    $thisCL = $this.children(':last');
                            $thisCL.text($thisCL.text().trimMiddle().pasteSAcomm());
                            if (ind % 2 == 0)
                                $this.removeClass('evenC').addClass('oddC');
                            else
                                $this.removeClass('oddC').addClass('evenC')
                        });
                    });
                    if (!refresh) {
                        methods.hoverComprasion(left, right, elEven);
                        onlyDif.unbind('click.equal').bind('click.equal', function() {
                            methods.onlyDifM(left, right, liLength, elEven);
                        });
                        allParams.unbind('click.equal').bind('click.equal', function() {
                            methods.allParamsM(left, right, elEven);
                        });
                    }

                    onlyDif.parent('.' + activeClass).children().click();
                    allParams.parent('.' + activeClass).children().click();
                    after($this);
                }
            })
            return $this;
        },
        refresh: function(optionCompare) {
            var $this = $(this);
            $('[data-equalHorizCell]').removeAttr('data-equalHorizCell').filter(':not([data-refresh])').removeAttr('style');
            $this.equalHorizCell($.extend(optionCompare, {refresh: true}))
            return $this;
        },
        hoverComprasion: function(left, right, elEven) {
            left.add(right.find(elEven)).hover(function() {
                var $this = $(this),
                        index = $this.index(),
                        nab = $([]);
                right.each(function() {
                    nab = nab.add($(this).find(elEven).eq(index))
                })
                $([]).add(left.eq(index)).add(nab).addClass('hover')
            },
                    function() {
                        var $this = $(this),
                                index = $this.index(),
                                nab = $([]);
                        right.each(function() {
                            nab = nab.add($(this).find(elEven).eq(index))
                        })
                        $([]).add(left.eq(index)).add(nab).removeClass('hover')
                    });
        },
        onlyDifM: function(left, right, liLength, elEven) {
            var liH = [],
                    genObjC = $([]),
                    tempText = '',
                    k = 0;
            for (var j = 0; j < liLength; j++) {
                var nab = $([]);
                right.each(function() {
                    nab = nab.add($(this).find(elEven).eq(j))
                })
                var tempNabir = nab,
                        tempText = '';
                tempNabir.each(function(index) {
                    var thisCh = $(this);
                    liH[index] = thisCh.text();
                    if (tempText == liH[index])
                        k++;
                    tempText = liH[index];
                });
                if (k == tempNabir.length - 1 && k != 0)
                    genObjC = genObjC.add(left.eq(j)).add(tempNabir);
                liH = [];
                k = 0;
                tempText = '';
            }
            right.each(function() {
                $(this).find(elEven).not(genObjC).removeClass('evenC').removeClass('oddC').each(function(ind) {
                    if (ind % 2 == 0)
                        $(this).addClass('oddC');
                    else
                        $(this).addClass('evenC')
                });
            });
            left.not(genObjC).removeClass('evenC').removeClass('oddC').each(function(ind) {
                if (ind % 2 == 0)
                    $(this).addClass('oddC');
                else
                    $(this).addClass('evenC')
            });
            genObjC.hide();
        },
        allParamsM: function(left, right, elEven) {
            left.removeClass('evenC').removeClass('oddC').each(function(ind) {
                if (ind % 2 == 0)
                    $(this).addClass('oddC');
                else
                    $(this).addClass('evenC')
            }).show();
            right.each(function() {
                $(this).find(elEven).removeClass('evenC').removeClass('oddC').each(function(ind) {
                    if (ind % 2 == 0)
                        $(this).addClass('oddC');
                    else
                        $(this).addClass('evenC')
                }).show();
            })
        }
    };
    $.fn.equalHorizCell = function(method) {
        if (methods[method]) {
            return methods[ method ].apply(this, Array.prototype.slice.call(arguments, 1));
        } else if (typeof method === 'object' || !method) {
            return methods.init.apply(this, arguments);
        } else {
            $.error('Method ' + method + ' does not exist on jQuery.equalHorizCell');
        }
    };
    $.equalHorizCell = function(m) {
        return methods[m];
    };
})(jQuery);
(function($) {
    $.fn.actual = function() {
        if (arguments.length && typeof arguments[0] == 'string') {
            var dim = arguments[0];
            clone = $(this).clone().addClass(clonedC);
            if (arguments[1] == undefined)
                clone.css({
                    position: 'absolute',
                    top: '-9999px'
                }).show().appendTo(body).find('*:not([style*="display:none"])').show();
            var dimS = clone[dim]();
            clone.remove();
            return dimS;
        }
        return undefined;
    };
}(jQuery));
(function($) {
    var methods = {
        init: function(options) {
            var optionsDrop = $.extend({
                exit: '[data-closed = "closed-js"]',
                effon: 'show',
                effoff: 'hide',
                duration: 200,
                place: 'center',
                dataSource: $('[data-drop]'),
                placement: 'noinherit',
                notification: false,
                always: false,
                animate: false,
                before: function() {
                },
                after: function() {
                },
                close: function() {
                },
                closed: function() {
                }
            }, options);
            var settings = optionsDrop,
                    $thisD = this,
                    selector = $thisD.selector,
                    dataSource = settings.dataSource,
                    exit = $(settings.exit),
                    effon = settings.effon,
                    effoff = settings.effoff,
                    duration = settings.duration,
                    close = settings.close,
                    closed = settings.closed,
                    notification = settings.notification,
                    always = settings.always,
                    animate = settings.animate,
                    dropContent = settings.dropContent,
                    arrDrop = [];
            dataSource.bind('click.drop', function(e) {
                var $this = $(this);
                $(document).trigger({'type': 'drop.click', 'el': $this})
                e.stopPropagation();
                e.preventDefault();
                var elSet = $this.data();
                function showDrop(elSetSource, isajax, e) {
                    var place = elSet.place || settings.place,
                            placement = elSet.placement || settings.placement,
                            $thisEOff = elSet.effectOff || effoff,
                            $thisD = elSet.duration || duration,
                            $thisA = elSet.animate != undefined ? elSet.animate : animate;
                    $this.each(function() {
                        var $this = $(this),
                                $thisSource = elSet.drop;
                        $this.data({'placement': placement, 'place': place, 'animate': $thisA});
                        $($thisSource).data({'effect-off': $thisEOff, 'place': place, 'duration': $thisD, 'dropContent': dropContent}).attr('data-elrun', $thisSource).unbind('click.drop').bind('click.drop', function(e) {
                            if ($(selector + '.' + activeClass).length > 1 && place == 'center')
                                methods.triggerBtnClick($(selector + '.' + activeClass).not($(this)), selector, close, closed);
                            if (!($(e.target).is(settings.exit) || $(e.target).closest(settings.exit).length != 0))
                                e.stopImmediatePropagation();
                        });
                    });
                    var $thisEOn = elSet.effectOn || effon,
                            $thisD = elSet.duration || duration,
                            overlayColor = elSet.overlaycolor || settings.overlayColor,
                            overlayOpacity = elSet.overlayopacity != undefined ? elSet.overlayopacity.toString() : elSet.overlayopacity || settings.overlayOpacity;
                    var condOverlay = overlayColor != undefined && overlayOpacity != undefined && overlayOpacity != '0';
                    if (condOverlay) {
                        if (!$.exists('.overlayDrop')) {
                            body.append('<div class="overlayDrop" style="display:none;position:fixed;width:100%;height:100%;left:0;top:0;z-index: 1101;"></div>')
                        }
                        optionsDrop.dropOver = $('.overlayDrop');
                        optionsDrop.dropOver.css({
                            'background-color': overlayColor,
                            'opacity': overlayOpacity
                        });
                    }
                    if (elSetSource.is('.' + activeClass)) {
                        methods.triggerBtnClick(elSetSource, selector, close, closed);
                    }
                    else {
                        settings.before($this, elSetSource, isajax);
                        //                            starget trigger click in drop on show drop element (js_template.tpl showCart)
                        $thisDrop = $this.closest('[data-elrun]');
                        if ($.existsN($thisDrop))
                            methods.triggerBtnClick($thisDrop, selector, close, closed);
                        $thisDrop = $(e.starget).closest('[data-elrun]');
                        if ($.existsN($thisDrop))
                            methods.triggerBtnClick($thisDrop, selector, close, closed);
                        if (e.button == undefined && place != "center")
                            wnd.scrollTop($this.offset().top);
                        var wndW = wnd.width();
                        if (elSetSource.actual('width') > wndW)
                            elSetSource.css('width', wndW - 40);
                        else
                            elSetSource.removeAttr('style');
                        methods.positionDrop($this, placement, place);

                        methods.dropCenter(elSetSource);

                        if (condOverlay) {
                            optionsDrop.dropOver.show().unbind('click').bind('click', function(e) {
                                e.stopPropagation();
                                methods.triggerBtnClick(false, selector, close, closed);
                            })
                        }
                        elSetSource[$thisEOn]($thisD, function() {
                            var dropContent = elSetSource.find(elSetSource.data('dropContent')).first();

                            $(document).trigger({type: 'drop.contentHeight', el: dropContent, drop: elSetSource});

                            elSetSource.addClass(activeClass);
                            if (place == 'center' && !(elSet.notification || notification)) {
                                if ($(document).height() - wnd.height() > 0) {
                                    optionsDrop.wST = wnd.scrollTop();
                                    methods.scrollEmulate();
                                }
                            }
                            settings.after($this, elSetSource, isajax);
                        });
                        $(document).trigger({'type': 'drop.show', el: elSetSource})
                    }
                    body.add($('iframe').contents().find('body')).unbind('click.bodydrop').unbind('keydown.bodydrop').bind('click.bodydrop', function(e) {
                        if ((e.which || e.button == 0) && e.relatedTarget == null) {
                            methods.triggerBtnClick(false, selector, close, closed);
                        }
                    }).bind('keydown.bodydrop', function(e) {
                        if (!e)
                            var e = window.event;
                        key = e.keyCode;
                        if (key == 27) {
                            methods.triggerBtnClick(false, selector, close, closed);
                        }
                    });
                }

                $this.parent().addClass(activeClass);
                var elSetSource = $(elSet.drop),
                        newNotification = elSet.notification || notification;
                newAlways = elSet.always || always;
                if ($.existsN(elSetSource) && !newNotification && !newAlways) {
                    if (!$.existsN(elSetSource.parent('body')) && elSet.place != 'inherit')
                        body.append(elSetSource)
                    showDrop(elSetSource, false, e);
                }
                else if (elSet.source || newAlways) {
                    if ($.inArray(elSet.source, arrDrop) != 0 || newNotification || newAlways) {
                        arrDrop.push(elSet.source);
                        if (!newNotification)
                            elSetSource.remove();
                        $.ajax({
                            type: "post",
                            data: elSet.data,
                            url: elSet.source,
                            dataType: elSet.type ? elSet.type : 'html',
                            success: function(data) {
                                if (elSet.type != 'html' && elSet.type != undefined && newNotification) {
                                    $(document).trigger({type: 'drop.successJson', el: elSetSource, datas: data})
                                }
                                else {
                                    $(document).trigger({type: 'drop.successHtml', el: elSetSource, datas: data})
                                    body.append(data);
                                }
                                elSetSource = $(elSet.drop);
                                var el = elSetSource.find('[data-drop]');
                                methods.init.call(selector, $.extend(optionsDrop, {dataSource: el}));
                                showDrop(elSetSource, true, e);
                            }})
                    }
                }
                return false;
            })
            exit.live('click', function() {
                methods.triggerBtnClick($(this).closest('[data-elrun]'), selector, close, closed);
            })
        },
        triggerBtnClick: function(sel, selector, close, closed) {
            if (!sel || typeof sel == 'function')
                var drop = $('[data-elrun].' + activeClass);
            else
                var drop = sel;
            if ($.existsN(drop)) {
                $(document).trigger({'type': 'drop.beforeClose', 'el': drop})
                drop.removeClass(activeClass).each(function() {
                    var $this = $(this),
                            $thisEOff = $this.data('effect-off'),
                            $thisD = $this.data('duration');
                    var $thisB = $('.' + activeClass + ' > [data-drop = "' + $this.attr('data-elrun') + '"]');
                    close($thisB, $(this));
                    $thisB.parent().removeClass(activeClass);
                    var $thisHref = $thisB.attr('href');
                    if ($thisHref != undefined) {
                        var $thisHrefL = $thisHref.length,
                                wLH = location.hash,
                                wLHL = wLH.length;
                        try {
                            var indH = wLH.match($thisHref + '(?![a-z])').index;
                            location.hash = wLH.substring(0, indH) + wLH.substring(indH + $thisHrefL, wLHL)
                        } catch (err) {
                        }
                    }
                    optionsDrop.dropOver = $('.overlayDrop'),
                            condScroll = !$.existsN($(selector + '.' + activeClass)) && optionsDrop.dropOver.is(':visible');
                    if (condScroll) {
                        methods.scrollEmulateRemove();
                    }

                    $this[$thisEOff]($thisD, function() {
                        $(this).removeAttr('style');
                        if (closed != undefined)
                            closed($thisB, $(this));
                        if (typeof sel == 'function')
                            sel();
                        $(document).trigger({'type': 'drop.hide', el: $this})
                    });
                });
            }
            else {
                if (typeof sel == 'function')
                    sel();
            }
            wnd.unbind('resize.drop');
        },
        dropCenter: function(elSetSource) {
            if (elSetSource.data('place') == 'center') {
                var method = elSetSource.data('animate') ? 'animate' : 'css';
                elSetSource[method]({
                    'top': (body.height() - elSetSource.actual('outerHeight')) / 2 + wnd.scrollTop(),
                    'left': (body.width() - elSetSource.actual('outerWidth')) / 2 + wnd.scrollLeft()
                }, {
                    queue: false
                });
                return elSetSource;
            }
            else
                return false;
        },
        positionDrop: function(el, placement, place) {
            var $this = el;
            if ($this == undefined)
                $this = $(this);
            if (placement == undefined)
                placement = $this.data('placement');
            if (place == undefined)
                place = $this.data('place');
            var elSetSource = $($this.data().drop),
                    $thisP = place,
                    dataSourceH = 0,
                    dataSourceW = 0,
                    $thisW = $this.width(),
                    $thisH = $this.height();
            if ($thisP == 'noinherit') {
                var $thisPMT = placement.toLowerCase().split(' ');
                if ($thisPMT[0] == 'bottom' || $thisPMT[1] == 'bottom')
                    dataSourceH = -elSetSource.actual('height');
                if ($thisPMT[0] == 'top' || $thisPMT[1] == 'top')
                    dataSourceH = $thisH;
                if ($thisPMT[0] == 'left' || $thisPMT[1] == 'left')
                    dataSourceW = 0;
                if ($thisPMT[0] == 'right' || $thisPMT[1] == 'right')
                    dataSourceW = -elSetSource.actual('width') + $thisW;
                $thisT = $this.offset().top + dataSourceH;
                $thisL = $this.offset().left + dataSourceW;
                if ($thisL < 0)
                    $thisL = 0;
                elSetSource.css({
                    'top': $thisT,
                    'left': $thisL
                });
                if ($thisL == 0)
                    elSetSource.css('margin-left', 0);
            }
            wnd.bind('resize.drop', function() {
                methods.dropCenter(elSetSource)
            });
        },
        scrollEmulate: function() {
            var conDropOver = optionsDrop.dropOver != undefined;
            body.addClass('isScroll');
            body.prepend('<div class="scrollEmulation" style="position: absolute;right: 0;top: ' + wnd.scrollTop() + 'px;height: 100%;width: 17px;overflow-y: scroll;z-index:10000;"></div>');
            if (isTouch)
                if (conDropOver)
                    optionsDrop.dropOver.bind('touchmove.drop', function(e) {
                        return false;
                    });
        },
        scrollEmulateRemove: function() {
            var conDropOver = optionsDrop.dropOver != undefined;
            body.removeClass('isScroll');
            wnd.scrollTop(optionsDrop.wST);
            if (conDropOver)
                optionsDrop.dropOver.hide();
            $('.scrollEmulation').remove();
            if (isTouch)
                if (conDropOver)
                    optionsDrop.dropOver.unbind('touchmove.drop');
        }
    };
    $.fn.drop = function(method) {
        if (methods[method]) {
            return methods[ method ].apply(this, Array.prototype.slice.call(arguments, 1));
        } else if (typeof method === 'object' || !method) {
            return methods.init.apply(this, arguments);
        } else {
            $.error('Method ' + method + ' does not exist on jQuery.drop');
        }
    };
    $.drop = function(m) {
        return methods[m];
    };
})(jQuery);
(function($) {
    var methods = {init: function(options) {
            var settings = $.extend({
                prev: '',
                next: '',
                ajax: false,
                after: function() {
                },
                before: function() {
                }
            }, options);
            if (this.length > 0) {
                return this.each(function() {
                    var $this = $(this),
                            prev = settings.prev.split('.'),
                            next = settings.next.split('.'),
                            ajax = settings.ajax,
                            $thisPrev = $this,
                            $thisNext = $this,
                            regS = '', regM = '';
                    $.each(prev, function(i, v) {
                        regS = v.match(/\(.*\)/);
                        if (regS != null) {
                            regM = regS['input'].replace(regS[0], '');
                            regS = regS[0].substring(1, regS[0].length - 1)
                        }
                        if (regS == null)
                            regM = v;
                        $thisPrev = $thisPrev[regM](regS);
                    })
                    $.each(next, function(i, v) {
                        regS = v.match(/\(.*\)/);
                        if (regS != null) {
                            regM = regS['input'].replace(regS[0], '');
                            regS = regS[0].substring(1, regS[0].length - 1)
                        }
                        if (regS == null)
                            regM = v;
                        $thisNext = $thisNext[regM](regS);
                    })
                    $thisNext.unbind('click.pM').bind('click.pM', function(e) {
                        var el = $(this);
                        $thisPrev.removeAttr('disabled', 'disabled')
                        if (!el.is(':disabled')) {
                            var input = $this,
                                    inputVal = parseInt(input.val());
                            if (!isTouch)
                                input.focus();
                            if (!input.is(':disabled')) {
                                settings.before(e, el, input);
                                if (isNaN(inputVal))
                                    input.val(1);
                                else
                                    input.val(inputVal + 1);
                                if (ajax && !checkProdStock)
                                    $(document).trigger({'type': 'showActivity'})

                                if (ajax && inputVal + 1 <= input.data('max') && checkProdStock)
                                    $(document).trigger({'type': 'showActivity'})
                                if (ajax && inputVal + 1 == input.data('max'))
                                    $thisNext.attr('disabled', 'disabled')

                                if (checkProdStock)
                                    input.maxValue(e);
                                settings.after(e, el, input);
                            }
                        }
                    })
                    $thisPrev.unbind('click.pM').bind('click.pM', function(e) {
                        var el = $(this);
                        $thisNext.removeAttr('disabled', 'disabled')
                        if (!el.is(':disabled')) {
                            var input = $this,
                                    inputVal = parseInt(input.val());
                            if (!isTouch)
                                input.focus();
                            if (!input.is(':disabled')) {
                                settings.before(e, el, input);
                                if (isNaN(inputVal))
                                    input.val(1)
                                else if (inputVal > 1) {
                                    if (ajax) {
                                        $(document).trigger({'type': 'showActivity'})
                                    }
                                    input.val(inputVal - 1)
                                    if (ajax && inputVal - 1 == input.data('min'))
                                        $thisPrev.attr('disabled', 'disabled')
                                }

                                settings.after(e, el, input);
                            }
                        }
                    })
                })
            }
        }
    };
    $.fn.plusminus = function(method) {
        if (methods[method]) {
            return methods[ method ].apply(this, Array.prototype.slice.call(arguments, 1));
        } else if (typeof method === 'object' || !method) {
            return methods.init.apply(this, arguments);
        } else {
            $.error('Method ' + method + ' does not exist on jQuery.plusminus');
        }
    };
    $.plusminus = function(m) {
        return methods[m];
    };
})(jQuery);
(function($) {
    var methods = {
        init: function(e) {
            var $this = $(this),
                    $min = $(this).attr('data-min'),
                    $thisVal = parseInt($this.val());
            if (!e)
                var e = window.event;
            var key = e.keyCode;
            if ((key == 48 || key == 96) && ($thisVal.length == 0 || $thisVal == '0')) {
                $this.val($min);
            }
        }
    };
    $.fn.minValue = function(method) {
        if (methods[method]) {
            return methods[ method ].apply(this, Array.prototype.slice.call(arguments, 1));
        } else if (typeof method === 'object' || !method) {
            return methods.init.apply(this, arguments);
        } else {
            $.error('Method ' + method + ' does not exist on jQuery.minValue');
        }
    };
    $.minValue = function(m) {
        return methods[m];
    };
})(jQuery);
(function($) {
    var methods = {
        init: function(e, f) {
            var $this = $(this), $thisVal = $this.val(),
                    $max = parseInt($this.attr('data-max'));
            if (!e)
                var e = window.event;
            var key = e.keyCode;
            keyChar = parseInt(String.fromCharCode(key));
            if ((keyChar > $max || $thisVal > $max) && checkProdStock) {
                $this.val($max);
                if (typeof f == 'function')
                    f();
                return $max;
            }
            else
                return true;
        }
    };
    $.fn.maxValue = function(method) {
        if (methods[method]) {
            return methods[ method ].apply(this, Array.prototype.slice.call(arguments, 1));
        } else if (typeof method === 'object' || !method) {
            return methods.init.apply(this, arguments);
        } else {
            $.error('Method ' + method + ' does not exist on jQuery.maxValue');
        }
    };
    $.maxValue = function(m) {
        return methods[m];
    };
    $('[data-max]').live('keydown keyup', function(e) {
        $(this).maxValue(e);
    })
})(jQuery);
/*plugin myCarousel use jQarousel with correction behavior prev and next buttons*/
(function($) {
    var methods = {
        init: function(options) {
            if ($.existsN($(this))) {
                var $jsCarousel = $(this);
                var settings = $.extend({
                    item: 'li',
                    prev: '.prev',
                    next: '.next',
                    content: '.c-carousel',
                    groupButtons: '.b-carousel',
                    vCarousel: '.v-carousel',
                    hCarousel: '.h-carousel',
                    before: function() {
                    },
                    after: function() {
                    }
                }, options);
                var item = settings.item,
                        prev = settings.prev,
                        next = settings.next,
                        content = settings.content,
                        groupButtons = settings.groupButtons,
                        adding = settings.adding,
                        hCarousel = settings.hCarousel,
                        vCarousel = settings.vCarousel;
                $jsCarousel.each(function() {
                    var $this = $(this),
                            $item = $this.find(content).children().children(item + ':visible'),
                            $content = $this.find(content),
                            $itemL = $item.filter(':visible').length,
                            $itemW = $item.outerWidth(true),
                            $itemH = $item.outerHeight(true),
                            $thisPrev = $this.find(prev),
                            $thisNext = $this.find(next),
                            $marginR = $itemW - $item.outerWidth(),
                            $marginB = $itemH - $item.outerHeight(),
                            contW = $content.width(),
                            contH = $content.height(),
                            groupButton = $this.find(groupButtons);
                    settings.before($this);
                    var $countV = (contW / $itemW).toFixed(1);
                    var k = false, isVert = $.existsN($this.closest(vCarousel)),
                            isHorz = $.existsN($this.closest(hCarousel)),
                            condH = $itemW * $itemL - $marginR > contW && isHorz,
                            condV = ($itemH * $itemL - $marginB > contH) && isVert;
                    if (condH || condV)
                        k = true;
                    if (k) {
                        var mainO = {
                            buttonNextHTML: $thisNext,
                            buttonPrevHTML: $thisPrev,
                            visible: $countV,
                            scroll: 1
                        }
                        $this.jcarousel($.extend(
                                adding
                                , mainO)).addClass('iscarousel');
                        $thisNext.add($thisPrev).css('display', 'inline-block');
                        groupButton.append($thisNext.add($thisPrev));
                        groupButton.append($thisNext.add($thisPrev));
                        if (isTouch) {
                            $this.bind('touchstart', function(e) {
                                sP = e.originalEvent.touches[0];
                                sP = sP.pageX;
                            });
                            $this.bind('touchmove', function(e) {
                                e.stopPropagation();
                                e.preventDefault();
                                eP = e.originalEvent.touches[0];
                                eP = eP.pageX;
                            });
                            $this.bind('touchend', function(e) {
                                e.stopPropagation();
                                if (Math.abs(eP - sP) > 200) {
                                    if (eP - sP > 0)
                                        $thisPrev.click();
                                    else
                                        $thisNext.click();
                                }
                            });
                        }
                    }
                    else {
                        if (isHorz)
                            $item.parent().css('width', $itemW * $itemL);
                        if (isVert) {
                            $item.parent().css('height', $itemH * $itemL);
                            $content.css('height', 'auto');
                        }
                        $thisNext.add($thisPrev).hide();
                    }
                    if (body.lazyload() == body) {
                        $thisNext.add($thisPrev).bind('click', function(e) {
                            if (!$(this).is('[disabled="disabled"]'))
                                wnd.scroll();
                        })
                    }
                    settings.after($this);
                });
            }
            return $jsCarousel;
        }
    };
    $.fn.myCarousel = function(method) {
        if (methods[method]) {
            return methods[ method ].apply(this, Array.prototype.slice.call(arguments, 1));
        } else if (typeof method === 'object' || !method) {
            return methods.init.apply(this, arguments);
        } else {
            $.error('Method ' + method + ' does not exist on jQuery.myCarousel');
        }
    }
    $.myCarousel = function(m) {
        return methods[m];
    };
})(jQuery);
/*
 *imagecms shop plugins
 **/
if (!Array.indexOf) {
    Array.prototype.indexOf = function(obj, start) {
        for (var i = (start || 0); i < this.length; i++) {
            if (this[i] == obj) {
                return i;
            }
        }
        return -1;
    }
}
var Shop = {
    //var Cart = new Object();
    currentItem: {},
    Cart: {
        totalPrice: 0,
        totalAddPrice: 0,
        totalCount: 0,
        totalPriceOrigin: 0,
        discount: 0,
        kitDiscount: 0,
        popupCartSelector: 'script#cartPopupTemplate',
        shipping: 0,
        shipFreeFrom: 0,
        giftCertPrice: 0,
        add: function(cartItem, el) {
            //trigger before_add_to_cart
            $(document).trigger({
                type: 'before_add_to_cart',
                cartItem: _.clone(cartItem)
            });
            //
            var data = {
                'quantity': cartItem.count,
                'productId': cartItem.id,
                'variantId': cartItem.vId
            };
            var url = '/shop/cart_api/add';
            if (cartItem.kit) {
                data = {
                    'quantity': cartItem.count,
                    'kitId': cartItem.kitId
                };
                url += '/ShopKit';
            }

            Shop.currentItem = cartItem;
            $.post(url, data,
                    function(data) {
                        try {
                            responseObj = JSON.parse(data);
                            //save item to storage
                            Shop.Cart._add(Shop.currentItem, el);
                        } catch (e) {
                            return;
                        }
                    });
            return;
        },
        _add: function(cartItem, el) {
            var currentItem = this.load(cartItem.storageId());
            if (currentItem)
                currentItem.count += cartItem.count;
            else
                currentItem = cartItem;
            this.save(currentItem);
            ////trigger after_add_to_cart
            $(document).trigger({
                type: 'after_add_to_cart',
                cartItem: _.clone(cartItem),
                starget: el
            });
            $(document).trigger({
                type: 'cart_changed'
            });
            //
            return this;
        },
        rm: function(cartItem) {
            Shop.currentItem = this.load('cartItem_' + cartItem.id + '_' + cartItem.vId);
            if (Shop.currentItem.kit)
                var key = 'ShopKit_' + Shop.currentItem.kitId;
            else
                var key = 'SProducts_' + Shop.currentItem.id + '_' + Shop.currentItem.vId;
            //Shop.currentItem = cartItem;
            $.getJSON('/shop/cart_api/delete/' + key, function() {
                localStorage.removeItem('cartItem_' + Shop.currentItem.id + '_' + Shop.currentItem.vId);
                Shop.Cart.totalRecount();
                $(document).trigger({
                    type: 'cart_rm',
                    cartItem: Shop.currentItem
                });
                $(document).trigger({
                    type: 'cart_changed'
                });
            });
            return this;
        },
        chCount: function(cartItem, f) {
            Shop.Cart.currentItem = this.load(cartItem.storageId());
            if (Shop.Cart.currentItem) {

                Shop.Cart.currentItem.count = cartItem.count;
                Shop.currentCallbackFn = f;
                if (cartItem.kit)
                    var postName = 'kits[ShopKit_' + Shop.Cart.currentItem.kitId + ']';
                else
                    var postName = 'products[SProducts_' + cartItem.id + '_' + cartItem.vId + ']';
                var postData = {
                    recount: 1
                };
                postData[postName] = cartItem.count;
                $.post('/shop/cart_api/recount', postData, function(data) {
                    var dataObj = JSON.parse(data);
                    if (dataObj.hasOwnProperty('count'))
                        Shop.Cart.currentItem.count = dataObj.count;
                    Shop.Cart.save(Shop.Cart.currentItem);
                    (Shop.currentCallbackFn());
                    $(document).trigger({
                        type: 'count_changed',
                        cartItem: _.clone(cartItem)
                    });
                    $(document).trigger({
                        type: 'cart_changed'
                    });
                });
                return this.totalRecount();
            }
        },
        clear: function() {
            $.getJSON('/shop/cart_api/clear',
                    function() {
                        var items = Shop.Cart.getAllItems();
                        for (var i = 0; i < items.length; i++)
                            localStorage.removeItem(items[i].storageId());
                        delete items;
                        $(document).trigger({
                            type: 'cart_changed'
                        });
                        Shop.Cart.totalRecount();
                    }
            );
        },
        //work with storage
        load: function(key) {
            try {
                return new Shop.cartItem(JSON.parse(localStorage.getItem(key)));
            } catch (e) {
                return false;
            }
        },
        save: function(cartItem) {
            if (!cartItem.storageId().match(/undefined/)) {
                localStorage.setItem(cartItem.storageId(), JSON.stringify(cartItem));
                this.totalRecount();
                ////trigger cart_changed
                $(document).trigger({
                    type: 'cart_changed'
                });
                //
            }
            return this;
        },
        getAllItems: function() {
            var pattern = /cartItem_*/;
            var items = [];
            for (var i = 0; i < localStorage.length; i++) {

                var key = localStorage.key(i);
                try {
                    if (key.match(pattern))
                        items.push(this.load(key));
                } catch (err) {
                }
            }
            return items;
        }, length: function() {
            var pattern = /cartItem_*/;
            var length = 0;
            for (var i = 0; i < localStorage.length; i++)
                if (localStorage.key(i).match(pattern))
                    length++;
            return length;
        },
//        totalRecount: function() {
//            var items = this.getAllItems();
//            this.totalPrice = 0;
//            this.totalCount = 0;
//            for (var i = 0; i < items.length; i++) {
//                this.totalPrice += items[i].price * items[i].count;
//                this.totalCount += parseInt(items[i].count);
//            }
//
//            return this;
//        },

        totalRecount: function() {
            var items = this.getAllItems();
            this.totalPrice = 0;
            this.totalAddPrice = 0;
            this.totalCount = 0;
            this.totalPriceOrigin = 0;
            for (var i = 0; i < items.length; i++) {
                if (items[i].origprice != '')
                    this.totalPriceOrigin += items[i].origprice * items[i].count;
                else
                    this.totalPriceOrigin += items[i].price * items[i].count;
                this.totalPrice += items[i].price * items[i].count;
                this.totalAddPrice += items[i].addprice * items[i].count;
                this.totalCount += parseInt(items[i].count);
            }
            return this;
        },
        getTotalPrice: function() {
            if (this.totalPrice == 0)
                return this.totalRecount().totalPrice;
            else
                return this.totalPrice;
        },
        getTotalAddPrice: function() {
            if (this.totalAddPrice == 0)
                return this.totalRecount().totalAddPrice;
            else
                return this.totalAddPrice;
        },
        getTotalPriceOrigin: function() {
            if (this.totalPrice == 0)
                return this.totalRecount().totalPriceOrigin;
            else
                return this.totalPriceOrigin;
        },
//        getFinalAmount: function() {
//            if (this.shipFreeFrom > 0)
//                if (this.shipFreeFrom <= this.getTotalPrice())
//                    this.shipping = 0.0;
//            return (this.getTotalPrice() + this.shipping - parseFloat(this.giftCertPrice)) >= 0 ? (this.getTotalPrice() + this.shipping - parseFloat(this.giftCertPrice)) : 0;
//        },
        getFinalAmount: function() {
            if (this.shipFreeFrom > 0)
                if (this.shipFreeFrom <= this.getTotalPriceOrigin())
                    this.shipping = 0.0;
            return (this.totalRecount().totalPriceOrigin + this.shipping - parseFloat(this.giftCertPrice)) >= 0 ? (this.totalRecount().totalPriceOrigin + this.shipping - parseFloat(this.giftCertPrice)) : 0;
        },
        renderPopupCart: function(selector) {
            if (typeof selector == 'undefined' || selector == '')
                selector = this.popupCartSelector;
            return template = _.template($(selector).html(), Shop.Cart);
        },
        sync: function() {
            $.getJSON('/shop/cart_api/sync', function(data) {
                if (typeof(data) == 'object') {

                    var items = Shop.Cart.getAllItems();
                    for (var i = 0; i < items.length; i++)
                        if (!items[i].kit)
                            localStorage.removeItem('cartItem_' + items[i]['id'] + '_' + items[i]['vId']);
                    delete items;
                    _.each(_.keys(data.data.items), function(key) {
                        if (!data.data.items[key].kit)
                            localStorage.setItem(key, JSON.stringify(data.data.items[key]));
                        else
                        {
                            try {
                                var kit = Shop.Cart.load('cartItem_' + items[i]['id'] + '_' + items[i]['vId']);
                                kit.count = data.data.items[key].count;
                                Shop.Cart.save('cartItem_' + kit['id'] + '_' + kit['vId']);
                            } catch (err) {
                            }
                        }
                    });
                    $(document).trigger({
                        type: 'cart_changed'
                    });
                    $(document).trigger({
                        type: 'sync_сart'
                    });
                }
                if (data == false)
                    Shop.Cart.clear();
            });
        },
        updatePage: function() {
        }
    },
    cartItem: function(obj) {
        if (typeof obj == 'undefined' || obj == false)
            obj = {
                id: false,
                vId: false,
                name: false,
                count: false,
                kit: false,
                maxcount: 0,
                number: '',
                vname: false,
                url: false
            };
        return prototype = {id: obj.id ? obj.id : 0,
            vId: obj.vId ? obj.vId : 0,
            price: obj.price ? obj.price : 0,
            prices: obj.prices ? obj.prices : 0,
            addprice: obj.addprice ? obj.addprice : 0,
            addprices: obj.addprices ? obj.addprices : 0,
            origprice: obj.origprice ? obj.origprice : 0,
            origprices: obj.origprices ? obj.origprices : 0,
            name: obj.name ? obj.name : '',
            count: obj.count ? obj.count : 1,
            kit: obj.kit ? obj.kit : false,
            kitId: obj.kitId ? obj.kitId : 0,
            maxcount: obj.maxcount ? obj.maxcount : 0,
            number: obj.number ? obj.number : 0,
            vname: obj.vname ? obj.vname : '',
            url: obj.url ? obj.url : '',
            img: obj.img ? obj.img : '',
            prodstatus: obj.prodstatus ? obj.prodstatus : '',
            storageId: function() {
                return 'cartItem_' + this.id + '_' + this.vId;
            }
        };
    },
    composeCartItem: function($context) {
        var cartItem = new Shop.cartItem();
        cartItem.id = $context.data('prodid');
        cartItem.vId = $context.data('varid');
        cartItem.count = $context.attr('data-count');
        cartItem.price = $context.data('price');
        cartItem.prices = $context.data('prices');
        cartItem.addprice = $context.data('addprice');
        cartItem.addprices = $context.data('addprices');
        cartItem.origprice = $context.data('origprice')
        cartItem.origprices = $context.data('origprices')
        cartItem.name = $context.data('name');
        cartItem.kit = $context.data('kit');
        cartItem.kitId = $context.data('kitid');
        cartItem.maxcount = $context.data('maxcount');
        cartItem.number = $context.data('number');
        cartItem.vname = $context.data('vname');
        cartItem.url = $context.data('url');
        cartItem.img = $context.data('img');
        cartItem.prodstatus = $context.data('prodstatus');
        return cartItem;
    },
    WishList: {
        items: [],
        all: function() {
            return JSON.parse(localStorage.getItem('wishList')) ? _.compact(JSON.parse(localStorage.getItem('wishList'))) : [];
        },
        add: function(key, vid, price, curentEl) {
            Shop.WishList.items = this.all();
            localStorage.setItem('wishList_' + key + '_' + vid, JSON.stringify({
                id: key,
                vid: vid,
                price: price
            }));
            if (this.items.indexOf(key) == -1) {
                $.post('/shop/wish_list_api/add', {
                    productId_: key,
                    variantId_: vid
                }, function(data) {
                    try {
                        var dataObj = JSON.parse(data);
                        dataObj.id = key;
                        if (dataObj.success == true) {
                            Shop.WishList.items.push(key);
                            //localStorage.setItem('wishList', JSON.stringify(Shop.WishList.items));
                            var arr = JSON.parse(localStorage.getItem('wishList')) ? _.compact(JSON.parse(localStorage.getItem('wishList'))) : [];
                            arr.push(key + '_' + vid)
                            localStorage.setItem('wishList', JSON.stringify(arr));
                            if (Shop.WishList.items.length != dataObj.count) {
                                Shop.WishList.sync();
                                return;
                            }
                            $(document).trigger({
                                type: 'wish_list_add',
                                dataObj: dataObj
                            });
                        }
                        else {
                            if (dataObj.errors.match('not_logged_in')) {
                                $(loginButton).click();
                            }
                        }
                    } catch (e) {
                    }
                });
            }
        },
        rm: function(key, el, vid, price) {
            this.items = this.all();
            $.get('/shop/wish_list_api/delete/' + key + '_' + vid, function(data) {
                try {
                    dataObj = JSON.parse(data);
                    dataObj.id = key;
                    if (dataObj.success == true) {
                        Shop.WishList.items = _.without(Shop.WishList.items, key + '_' + vid);
                        localStorage.setItem('wishList', JSON.stringify(Shop.WishList.items));
                        $(document).trigger({
                            type: 'wish_list_rm',
                            dataObj: dataObj
                        });
                    }
                } catch (e) {
                }
            });
            deleteWishListItem($(el), key, vid, price);
        },
        sync: function() {
            $.getJSON('/shop/wish_list_api/sync', function(data) {
                if (typeof(data) == 'Array' || typeof(data) == 'object') {
                    localStorage.setItem('wishList', JSON.stringify(data));
                }
                if (data === false) {
                    localStorage.setItem('wishList', []);
                }

                $(document).trigger({
                    type: 'wish_list_sync'
                });
            });
        }
    },
    CompareList: {
        items: [],
        all: function() {
            return JSON.parse(localStorage.getItem('compareList')) ? _.compact(JSON.parse(localStorage.getItem('compareList'))) : [];
        },
        add: function(key) {
            this.items = this.all();
            if (this.items.indexOf(key) === -1) {
                $.get('/shop/compare_api/add/' + key, function(data) {
                    try {
                        dataObj = JSON.parse(data);
                        dataObj.id = key;
                        if (dataObj.success == true) {
                            Shop.CompareList.items.push(key);
                            localStorage.setItem('compareList', JSON.stringify(Shop.CompareList.items));
                            $(document).trigger({
                                type: 'compare_list_add',
                                dataObj: dataObj
                            });
                        }
                    } catch (e) {
                    }
                });
            }
        },
        rm: function(key, el) {
            this.items = JSON.parse(localStorage.getItem('compareList')) ? JSON.parse(localStorage.getItem('compareList')) : [];
            if (this.items.indexOf(key) !== -1) {

                this.items = _.without(this.items, key);
                this.items = this.all();
                $.get('/shop/compare_api/remove/' + key, function(data) {
                    try {
                        dataObj = JSON.parse(data);
                        dataObj.id = key;
                        if (dataObj.success == true) {
                            Shop.CompareList.items = _.without(Shop.CompareList.items, key);
                            localStorage.setItem('compareList', JSON.stringify(Shop.CompareList.items));
                            $(document).trigger({
                                type: 'compare_list_rm',
                                dataObj: dataObj
                            });
                        }
                    } catch (e) {
                    }
                });
            }



            $(document).trigger({
                type: 'delete_compare',
                el: $(el)
            });
        },
        sync: function() {
            $.getJSON('/shop/compare_api/sync', function(data) {
                if (typeof(data) == 'object' || typeof(data) == 'Array') {
                    localStorage.setItem('compareList', JSON.parse(data));
                    $(document).trigger({
                        type: 'compare_list_sync'
                    });
                }
                else
                if (data === false) {
                    localStorage.removeItem('compareList');
                    $(document).trigger({
                        type: 'compare_list_sync'
                    });
                }
            });
        }
    }
};
/**
 * AuthApi ajax client
 * Makes simple request to api controllers and get return data in json
 * 
 * @author Avgustus
 * @copyright ImageCMS (c) 2013, Avgustus <avgustus@yandex.ru>
 * 
 * Get JSON object with fields list:
 *      'status'    -   true/false - if the operation was successful,
 *      'msg'       -   info message about result,
 *      'refresh'   -   true/false - if true refreshes the page,
 *      'redirect'  -   url - redirects to needed url
 *    
 * List of api methods:
 *      Auth.php:
 *          '/auth/authapi/login',
 *          '/auth/authapi/logout',
 *          '/auth/authapi/register',
 *          '/auth/authapi/forgot_password',
 *          '/auth/authapi/reset_password',
 *          '/auth/authapi/change_password',
 *          '/auth/authapi/cancel_account',
 *          '/auth/authapi/banned',
 *          '/shop/ajax/getApiNotifyingRequest',
 *          '/shop/callbackApi'
 * 
 **/

var ImageCMSApi = {
    defSet: function() {
        return imageCmsApiDefaults;
    },
    returnMsg: function(msg) {
        if (window.console) {
            console.log(msg);
        }
    },
    formAction: function(url, selector, obj, el) {
        //collect data from form
        var DS = this.defSet();
        $.extend(DS, obj)
        if (selector !== '')
            var dataSend = this.collectFormData(selector);
        else if (el)
            var dataSend = {'refresh': el.data('refresh'), 'redirect': el.data('redirect')};
        //send api request to api controller
        $.ajax({
            type: "post",
            data: dataSend,
            url: url,
            dataType: "json",
            beforeSend: function() {
                ImageCMSApi.returnMsg("=== Sending api request to " + url + "... ===");
            },
            success: function(obj) {
                if (obj !== null) {
                    var form = $(selector);
                    ImageCMSApi.returnMsg("[status]:" + obj.status);
                    ImageCMSApi.returnMsg("[message]: " + obj.msg);
                    if (obj.status == true) {
                        if (DS.hideForm)
                            form.hide();
                        if (DS.messagePlace == 'ahead')
                            $(message.success(obj.msg)).prependTo(form.parent());
                        if (DS.messagePlace == 'behind')
                            $(message.success(obj.msg)).appendTo(form.parent());
                        $(document).trigger({'type': 'imageapi.pastescsmsg', 'el': form.parent()})
                    }
                    if (obj.cap_image != 'undefined' && obj.cap_image != null) {
                        ImageCMSApi.addCaptcha(obj.cap_image, DS);
                    }
                    if (obj.validations != 'undefined' && obj.validations != null) {
                        ImageCMSApi.sendValidations(obj.validations, selector, DS);
                    }
                    if (obj.refresh == true && obj.redirect == false)
                        location.reload();
                    if (obj.refresh == false && obj.redirect != true && obj.redirect != false)
                        location.href = obj.redirect;
                    if (obj.refresh == false && obj.redirect == false) {
                        var k = true;
                        if (typeof DS.callback == 'function')
                            k = DS.callback(obj.msg, obj.status, form, DS);
                        if (k)
                            setTimeout((function() {
                                form.parent().find(genObj.msgF).fadeOut();
                                if (DS.hideForm)
                                    form.show();
                            }), DS.durationHideForm);
                    }
                    $(form).find(':input').unbind('input').bind('input', function() {
                        var $this = $(this),
                                form = $this.closest('form'),
                                $thisТ = $this.attr('name'),
                                elMsg = form.find('[for=' + $thisТ + ']');
                        if ($.exists(elMsg)) {
                            $this.removeClass(genObj.err + ' ' + genObj.scs);
                            elMsg.hide();
                        }
                    });
                }
                return this;
            }
        }).done(function() {
            ImageCMSApi.returnMsg("=== Api request success!!! ===");
        }).fail(function() {
            ImageCMSApi.returnMsg("=== Api request breake with error!!! ===");
        });
        return;
    },
    //find form by data-id attr and create serialized string for send
    collectFormData: function(selector) {
        var findSelector = $(selector);
        var queryString = findSelector.serialize();
        return queryString;
    },
    /**
     * for displaying validation messages 
     * in the form, which needs validation, for each validate input
     * 
     * */
    sendValidations: function(validations, selector, DS) {
        var thisSelector = $(selector);
        if (typeof validations === 'object') {
            for (var key in validations) {
                if (validations[key] != "") {
                    var input = thisSelector.find('[name=' + key + ']');
                    input.addClass(genObj.err);
                    input[DS.cMsgPlace](DS.cMsg(key, validations[key], genObj.err, thisSelector));
                    thisSelector.find(':input.' + genObj.err + ':first').focus();
                }
            }
        } else {
            return false;
        }
    },
    /**
     * add captcha block if needed
     * @param {type} captcha_image
     */
    addCaptcha: function(cI, DS) {
        DS.captchaBlock.html(DS.captcha(cI));
        return false;
    }
}