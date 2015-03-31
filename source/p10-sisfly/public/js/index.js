if (document.getElementById('starting-input')){
  startingInput = document.getElementById('starting-input')
  var searchBox = new google.maps.places.SearchBox(startingInput)
  google.maps.event.addListener(searchBox, 'places_changed', function(){
    var places = searchBox.getPlaces();
  });
};

if (document.getElementById('ending-input')){
  endingInput = document.getElementById('ending-input')
  var searchBox = new google.maps.places.SearchBox(endingInput)
  google.maps.event.addListener(searchBox, 'places_changed', function(){
    var places = searchBox.getPlaces();
  });
};
