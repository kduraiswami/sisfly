!function(){

  var initializeMap = function(){
    var directionsService = new google.maps.DirectionsService();
    var directionsDisplay = new google.maps.DirectionsRenderer();
    var center = new google.maps.LatLng(37.7580 , -122.4400);
    var mapOptions = {zoom: 13, center: center};
    map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);

    directionsDisplay.setMap(map);
    calcRoute(directionsService, directionsDisplay);
  }

  var calcRoute = function(directionsService, directionsDisplay) {
    var routing = ENV.routingData;
    var startingStreet = routing["startingStreet"]
    var endingStreet = routing["endingStreet"]
    var request = {
      origin: startingStreet,
      destination: endingStreet,
      travelMode: google.maps.TravelMode.WALKING
    }

    directionsService.route(request, function(result, status) {
      if (status == google.maps.DirectionsStatus.OK) {
        directionsDisplay.setDirections(result);
        var pathCoordinates = result.routes[0].overview_path;
        discoverProximityCrimes(pathCoordinates)
      }
    });
  };

  var discoverProximityCrimes = function(pathCoordinates){
    var request = $.ajax({
      type: 'POST',
      url: '/calculation',
      data: {path_coordinates: JSON.stringify(pathCoordinates)}
    });

    request.done(function(response) {
      console.log("made it to ajax")
      // dog = response["crimeData"]
      // console.log(dog)
      // var plotRelevantCrimes = function(crimeData){
      //   crimeData.forEach(function(crime){
      //     if (crime != undefined){
      //       var contentString = '<div id="content">'+
      //       '<div id="siteNotice">'+
      //       '</div>'+
      //       '<h1 id="firstHeading" class="firstHeading">'+crime.descript+'</h1>'+
      //       '<div id="bodyContent">'+
      //       '<p> '+ crime.dayofweek+' </p>'+
      //       '<p> '+ crime.date +' </p>'+
      //       '<p> '+ crime.address +'  </p>'+
      //       '<p>  '+ crime.date +' </p>'+
      //       '</div>'+
      //       '</div>';

      //       var infowindow = new google.maps.InfoWindow({
      //         content: contentString
      //       });

      //       var crimeLatlng = new google.maps.LatLng(Number(crime.y), Number(crime.x));
      //       var marker = new google.maps.Marker({
      //         position: crimeLatlng,
      //         map: map,
      //         title: crime.descript
      //       });
      //       google.maps.event.addListener(marker, 'click', function() {
      //         infowindow.open(map,marker);
      //       });
      //     }
      //   })

      // }
      //   plotRelevantCrimes(dog);
      //   plotSisflyScore(response["sisflyScore"])
     });
    };



$(function(){
  if (document.getElementById('map-canvas')) initializeMap();
});

}();
