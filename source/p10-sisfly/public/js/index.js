if (document.getElementById('starting-input')){
  startingInput = document.getElementById('starting-input')
  var searchBox = new google.maps.places.SearchBox((startingInput),{types: ['geocode']});
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

 function geolocate() {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(function(position) {
        var geolocation = new google.maps.LatLng(
            position.coords.latitude, position.coords.longitude);
        var circle = new google.maps.Circle({
          center: geolocation,
          radius: position.coords.accuracy
        });
        autocomplete.setBounds(circle.getBounds());
      });
    }
  }
