$(function() {
    $('form').validate({
        submitHandler: function(form, validator) {
            $('.status').html('Sending...');

            $.post('/send', $('form :input').serialize(), function(data) {
                $('.status').html('Message sent we\'ll get back to you as soon as possible.').delay(5000).slideUp();

                $('form').each(function() {
                    this.reset();
                 });
            });
        }
    });
});
