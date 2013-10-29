$(function(){

  var $container = $('#container');

  $container.isotope({
    itemSelector : '.element'
  });
  
  $container.infinitescroll({
    navSelector  : '#page_nav',    // selector for the paged navigation 
    nextSelector : '#page_nav a',  // selector for the NEXT link (to page 2)
    itemSelector : '.element',     // selector for all items you'll retrieve
    loading: {
        finishedMsg: 'No more pages to load.',
        img: 'http://i.imgur.com/qkKy8.gif'
      }
    },
    // call Isotope as a callback
    function( newElements ) {
      $container.isotope( 'appended', $( newElements ) ); 
    }
  );
  

});