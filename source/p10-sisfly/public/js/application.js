// // places route based on starting and end params
// if (document.getElementById('map-canvas')){
//   var directionsDisplay;
//   var directionsService = new google.maps.DirectionsService();
//   var map;

//   function initialize() {
//     directionsDisplay = new google.maps.DirectionsRenderer();
//     var center = new google.maps.LatLng(37.7580 , -122.4400);
//     var mapOptions = {
//       zoom:13,
//       center: center
//     }
//     map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);
//     directionsDisplay.setMap(map);
//   }
// }
//   console.log('made it')
//   console.log(startingInput)
//   console.log(endingInput)
//   console.log(startingStreet)
//   console.log(endingStreet)
//   debugger

//   function calcRoute() {
//     //var startingStreet = document.getElementById("starting_street").value;
//     //var endingStreet = document.getElementById("ending_street").value;
//     var request = {
//       origin:startingStreet,
//       destination:endingStreet,
//       travelMode: google.maps.TravelMode.WALKING
//     };
//     directionsService.route(request, function(result, status) {
//       if (status == google.maps.DirectionsStatus.OK) {
//         directionsDisplay.setDirections(result);
//       }
//     });
//   }
// };

// places relavent crimes on my map

if (document.getElementById('map-canvas')){
  var routingAndCrimeData = JSON.parse((document.getElementById('data')).innerText)
  var all_crimes = routingAndCrimeData["all_crimes"]
  function initialize() {
    var center = new google.maps.LatLng(37.7580 , -122.4400);
    var mapOptions = {
      zoom: 13,
      center: center
    };
    map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

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

      var myLatlng = new google.maps.LatLng(Number(crime.y), Number(crime.x));
      var marker = new google.maps.Marker({
        position: myLatlng,
        map: map,
        title: crime.descript
      });
      google.maps.event.addListener(marker, 'click', function() {
        infowindow.open(map,marker);
      });
    })
  }
  google.maps.event.addDomListener(window, 'load', initialize);
}
