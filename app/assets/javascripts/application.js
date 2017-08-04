// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require social-share-button
//= require ckeditor/init
//= require_tree .

// when the page is ready for manipulation
$(document).on('turbolinks:load', function() {
    // when the load more link is clicked
    $('a.click.mas').click(function (e) {
        // prevent the default click action
        e.preventDefault();

        // hide load more link
        //$('a.click.mas').hide();

        // show loading gif
        //$('a.click.mas').show();

        // get the last id and save it in a variable 'last-id'
        var last_id = $('.post-preview').last().attr('data-id');

        // make an ajax call passing along our last user id
        $.ajax({

            // make a get request to the server
            type: "GET",
            // get the url from the href attribute of our link
            url: "/articulos",
            // send the last id to our rails app
            data: {
                id: last_id
            },
            // the response will be a script
            dataType: "script",

            // upon success 
            success: function () {
                var showing_posts = document.getElementsByClassName("post-preview").length;
                var post_count = document.getElementById("ajax_articulos").dataset.id;
                if (showing_posts == post_count) {
                    $('a.click.mas').hide();
                }else{
                    // hide the loading gif
                    $('a.click.mas').hide();
                    // show our load more link
                    $('a.click.mas').show();
                };
            }
        });

    });
});
