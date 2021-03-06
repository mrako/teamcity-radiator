$(function(){
  var img = $("<img />").attr('src', $("#burndown").attr("data-remote"))
    .load(function() {
        if (!this.complete || typeof this.naturalWidth == "undefined" || this.naturalWidth == 0) {
            alert('broken image!');
        } else {
            $("#burndown").append(img);
        }
    });


  var $container = $('#container'),
      // object that will keep track of options
      isotopeOptions = {},
      // defaults, used if not explicitly set in hash
      defaultOptions = {
        filter: '*',
        sortBy: 'original-order',
        sortAscending: true,
        layoutMode: 'masonry'
      };


  // update columnWidth on window resize
  $(window).smartresize(function(){
    $container.isotope({
      // set columnWidth to a percentage of container width
      masonry: {
        columnWidth: $container.width() / 5
      }
    });
  });

  var setupOptions = $.extend( {}, defaultOptions, {
    itemSelector : '.element',
    masonry : {
      columnWidth : 120
    },
    cellsByRow : {
      columnWidth : 240,
      rowHeight : 240
    },
    getSortData : {
      category : function( $elem ) {
        return $elem.attr('data-category');
      },
      number : function( $elem ) {
        return parseInt( $elem.find('.number').text(), 10 );
      },
      name : function ( $elem ) {
        return $elem.find('.name').text();
      }
    }
  });

  // set up Isotope
  $container.isotope( setupOptions );


  // change size of clicked element
  $container.delegate( '.element', 'click', function(){
    location.href = $(this).attr('data-remote');
  });

  var $optionSets = $('#options').find('.option-set'),
      isOptionLinkClicked = false;

  // switches selected class on buttons
  function changeSelectedLink( $elem ) {
    // remove selected class on previous item
    $elem.parents('.option-set').find('.selected').removeClass('selected');
    // set selected class on new item
    $elem.addClass('selected');
  }


  $optionSets.find('a').click(function(){
    var $this = $(this);
    // don't proceed if already selected
    if ( $this.hasClass('selected') ) {
      return;
    }
    changeSelectedLink( $this );
        // get href attr, remove leading #
    var href = $this.attr('href').replace( /^#/, '' ),
        // convert href into object
        // i.e. 'filter=.inner-transition' -> { filter: '.inner-transition' }
        option = $.deparam( href, true );
    // apply new option to previous
    $.extend( isotopeOptions, option );
    // set hash, triggers hashchange on window
    $.bbq.pushState( isotopeOptions );
    isOptionLinkClicked = true;
    return false;
  });

  var hashChanged = false;

  $(window).bind( 'hashchange', function( event ){
    // get options object from hash
    var hashOptions = window.location.hash ? $.deparam.fragment( window.location.hash, true ) : {},
        // do not animate first call
        aniEngine = hashChanged ? 'best-available' : 'none',
        // apply defaults where no option was specified
        options = $.extend( {}, defaultOptions, hashOptions, { animationEngine: aniEngine } );
    // apply options from hash
    $container.isotope( options );
    // save options
    isotopeOptions = hashOptions;

    // if option link was not clicked
    // then we'll need to update selected links
    if ( !isOptionLinkClicked ) {
      // iterate over options
      var hrefObj, hrefValue, $selectedLink;
      for ( var key in options ) {
        hrefObj = {};
        hrefObj[ key ] = options[ key ];
        // convert object into parameter string
        // i.e. { filter: '.inner-transition' } -> 'filter=.inner-transition'
        hrefValue = $.param( hrefObj );
        // get matching link
        $selectedLink = $optionSets.find('a[href="#' + hrefValue + '"]');
        changeSelectedLink( $selectedLink );
      }
    }

    isOptionLinkClicked = false;
    hashChanged = true;
  })
    // trigger hashchange to capture any hash data on init
    .trigger('hashchange');

});