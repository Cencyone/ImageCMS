$(document).ready(function() {
    $('.protocolSettings').on('change', function() {
        if ($(this).val() === "SMTP") {
            $('.portControlGroup').css('display', 'block');
        } else {
            $('.portControlGroup').css('display', 'none');
        }
    });

    $('.niceCheck').on('click', function() {
        if ($(this).find('.wraper_activSettings').attr('checked')) {
            $('.wraperControlGroup').slideUp(500);
        } else {
            $('.wraperControlGroup').slideDown(500);
        }
    });

    $('#userMailVariables').on('click', function() {
        $('#userMailText_ifr').contents().find('#tinymce p').append(' ' + $(this).val() + ' ');
    });

    $('#adminMailVariables').on('click', function() {
        $('#adminMailText_ifr').contents().find('#tinymce p').append(' ' + $(this).val() + ' ');
    });

    $('.mailTestResultsHide').on('click', function() {
        $('.mailTestResults').css('display', 'none');
        $(this).css('display', 'none');

    });

    $('table.variablesTable .icon-edit').on('click', function() {
        var editor = $(this).closest('tr').find('div.variable');
        var editValue = $.trim(editor.text());
        editor.empty();
        editor.parent().find('.variableEdit').css('display', 'block').val(editValue);

        var editor = $(this).closest('tr').find('div.variableValue');
        var editValue = $.trim(editor.text());
        editor.empty();
        editor.parent().find('.variableValueEdit').css('display', 'block').val(editValue);

        $(this).parent('.editVariable').css('display', 'none');
        $(this).closest('tr').find('.refreshVariable').css('display', 'block');

    });

    $('.addVariable').on('click', function() {
        $('.addVariableContainer').css('display', '');
    });
});

function mailTest() {
    var from = $('#from').val();
    var from_email = $('#from_email').val();
    var theme = $('#theme').val();
    var protocol = $('#protocol').val();
    var port = $('#port').val();
    var mailpath = $('#mailpath').val();
    var send_to = $('#admin_email').val();

    $.ajax({
        type: 'POST',
        data: {
            from: from,
            from_email: from_email,
            theme: theme,
            protocol: protocol,
            port: port,
            mailpath: mailpath,
            send_to: send_to
        },
        url: '/email/mailTest',
        success: function(data) {
            $('.mailTestResults').html(data);
            $('.mailTestResults').css('display', 'block');
            $('.mailTestResultsHide').css('display', 'block');
            var curPos = $(document).scrollTop();
            var height = $("body").height();
            var scrollTime = (height - curPos) / 1.73;
            $("body,html").animate({"scrollTop": height}, scrollTime);
        }
    });
    return false;
}

var EmailTemplateVariables = {
    delete: function(template_id, variable, curElement) {
        $.ajax({
            type: 'POST',
            data: {
                template_id: template_id,
                variable: variable
            },
            url: '/email/admin/deleteVariable',
            success: function(data) {
                if(!data){
                    showMessage('Ошибка', 'Переменная не удалена', 'r');
                    return false;
                }
                curElement.closest('tr').remove();
                showMessage('Сообщение', 'Переменная ' + variable + ' успешно удалена');
            }
        });
    },
    update: function(curElement, template_id, oldVariable) {
        var closestTr = curElement.closest('tr');
        var variable = closestTr.find('.variableEdit');
        var variableValue = closestTr.find('.variableValueEdit');

        this.validateVariable(variable.val(), variableValue.val());

        $.ajax({
            type: 'POST',
            data: {
                variable: variable.val(),
                variableValue: variableValue.val(),
                oldVariable: oldVariable,
                template_id: template_id
            },
            url: '/email/admin/updateVariable',
            success: function(data) {
                if(!data){
                    showMessage('Ошибка', 'Переменная не обновлена', 'r');
                    return false;
                }
                closestTr.find('.variable').text(variable.val());
                closestTr.find('.variableValue').text(variableValue.val());
                variable.css('display', 'none');
                variableValue.css('display', 'none');
                closestTr.find('.editVariable').css('display', 'block');
                closestTr.find('.refreshVariable').css('display', 'none');
                showMessage('Сообщение', 'Переменная успешно обновлена');
            }
        });
    },
    add: function(curElement, template_id) {
        var variable = curElement.closest('tr').find('.variableEdit');
        var variableValue = curElement.closest('tr').find('.variableValueEdit');

        this.validateVariable(variable.val(), variableValue.val());

        $.ajax({
            type: 'POST',
            data: {
                variable: variable.val(),
                variableValue: variableValue.val(),
                template_id: template_id
            },
            url: '/email/admin/addVariable',
            success: function(data) {
                if(!data){
                    showMessage('Ошибка', 'Переменная не додана', 'r');
                    return false;
                }
                curElement.parent('div').find('.typeVariable').val('');
                $('.addVariableContainer').css('display', 'none');
                $(data).insertBefore('table.variablesTable .addVariableContainer');
                showMessage('Сообщение', 'Переменная ' + variable.val() + ' успешно додана');
            }
        });
    },
    updateVariablesList: function(curElement, template_id) {
        if (!curElement.hasClass('active')) {
            $.ajax({
                type: 'POST',
                data: {
                    template_id: template_id
                },
                url: '/email/admin/getTemplateVariables',
                success: function(data) {
                    $('#userMailVariables').html(data);
                    $('#adminMailVariables').html(data);
                }
            });
        }
    },
    validateVariable: function(variable, variableValue) {
        if (variable[0] != '%' || variable[variable.length - 1] != '%') {
            showMessage('Сообщение', 'Переменну должни окружать %', 'r');
            exit;
        }
        if (!variableValue) {
            showMessage('Сообщение', 'Переменная должна иметь значение', 'r');
            exit;
        }
    }
};
