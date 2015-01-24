$(document).ready(function() {

  jQuery(function($){
      $('#open').on('click', function(e){
          e.preventDefault();
          $('#my_open')[0].click();
      });
  });

  jQuery(function($){
      $(document).keydown(function(e) {
          if((e.ctrlKey || e.metaKey) && e.which == 79) {
              e.preventDefault();
              $('#my_open')[0].click();
          };
      });
  });

  jQuery(function($){
      $('#save').on('click', function(e){
          e.preventDefault();
          $('#my_save').click();
      });
  });

  jQuery(function($){
      $(document).keydown(function(e) {
          if((e.ctrlKey || e.metaKey) && e.which == 83) {
              e.preventDefault();
              $('#save').click();
          };
      });
  });

  jQuery(function($){
      $('#render').on('click', function(e){
          e.preventDefault();
          $('#my_render').click();
      });
  });

  jQuery(function($){
      $(document).keydown(function(e) {
          if((e.ctrlKey || e.metaKey) && e.which == 82) {
              e.preventDefault();
              $('#render').click();
          };
      });
  });

    jQuery(function($){
      $('#ghost').on('click', function(e){
          e.preventDefault();
          $('#my_ghost').click();
      });
  });

   jQuery(function($){
      $(document).keydown(function(e) {
          if((e.ctrlKey || e.metaKey) && e.which == 71) {
              e.preventDefault();
              $('#ghost').click();
          };
      });
  });

  jQuery(function($){
      $('#ghostu').on('click', function(e){
          e.preventDefault();
          $('#my_ghostu').click();
      });
  });

   jQuery(function($){
      $(document).keydown(function(e) {
          if((e.ctrlKey || e.metaKey) && e.which == 72) {
              e.preventDefault();
              $('#ghostu').click();
          };
      });
  });

   jQuery(function($){
      $('#ghostd').on('click', function(e){
          e.preventDefault();
          $('#my_ghostd').click();
      });
  });

jQuery(function($){
      $('#ghostg').on('click', function(e){
          e.preventDefault();
          $('#my_ghostg').click();
      });
  });






});





