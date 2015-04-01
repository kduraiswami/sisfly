// places relavent crimes on my map

if (document.getElementById('map-canvas')){
  var routingAndCrimeData = JSON.parse((document.getElementById('data')).innerText);
  var all_crimes = routingAndCrimeData["all_crimes"];
  var startingStreet = routingAndCrimeData["startingStreet"]
  var endingStreet = routingAndCrimeData["endingStreet"]
  var directionsDisplay;
  var directionsService = new google.maps.DirectionsService();

  function initialize() {
    directionsDisplay = new google.maps.DirectionsRenderer();
    var center = new google.maps.LatLng(37.7580 , -122.4400);
    var mapOptions = {
      zoom: 13,
      center: center
    };
    map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);
    directionsDisplay.setMap(map);

    all_crimes.forEach(function(crime){
      var contentString = '<div id="content">'+
      '<div id="siteNotice">'+
      '</div>'+
      '<h1 id="firstHeading" class="firstHeading">'+crime.descript+'</h1>'+
      '<div id="bodyContent">'+
      '<p> '+ crime.dayofweek+' </p>'+
      '<p> '+ crime.date +' </p>'+
      '<p> '+crime.address+'  </p>'+
      '<p>  '+ crime.date +' </p>'+
      '</div>'+
      '</div>';

      var infowindow = new google.maps.InfoWindow({
        content: contentString
      });

      var crimeLatlng = new google.maps.LatLng(Number(crime.y), Number(crime.x));
      var marker = new google.maps.Marker({
        position: crimeLatlng,
        map: map,
        title: crime.descript
      });
      google.maps.event.addListener(marker, 'click', function() {
        infowindow.open(map,marker);
      });
    })
    calcRoute();
  }
  function calcRoute() {

    var request = {
      origin: startingStreet,
      destination: endingStreet,
      travelMode: google.maps.TravelMode.WALKING
    }

    directionsService.route(request, function(result, status) {
      if (status == google.maps.DirectionsStatus.OK) {
        path_coordinates = result.routes[0].overview_path
        directionsDisplay.setDirections(result);
      }
    });
  }
  google.maps.event.addDomListener(window, 'load', initialize);
};
