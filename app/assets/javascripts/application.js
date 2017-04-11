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
//= require jquery_ujs
//= require turbolinks
//= require semantic-ui
//= require_tree .

// AJAX: get weather forecast by user geolocation
function showLocation(position) {
   var lat = position.coords.latitude;
   var lon = position.coords.longitude;

   $.ajax({
     method: 'GET',
     url: '/potato',
     data: { lat: lat,
             lon: lon },
     dataType: 'json',
     success: onSuccess
   });
}

var data;
var moonPhases = {
  NewMoon: '',
  WaxingCrescent: '',
  FirstQuarter: '',
  WaxingGibbous: 'http://img.clipartall.com/crescent-moon-clipart-phase-20clipart-crescent-moon-clip-art-267_297.png',
  FullMoon: '',
  WaningGibbous: '',
  LastQuarter: '',
  WaningCrescent: ''
}

function onSuccess(json) {
  data = json;

  var htmlForecast = (`
      <p id='city-name'><i class="marker large icon"></i> ${data.city}, ${data.state}</p>
      <p id='moon-phase'>${data.moon_phase}</p>
      <p id='curr-temp'>${data.imperial} °F | ${data.metric} °C</p>
      <p id='cloud-cover'><i class="cloud large icon"></i> ${data.cloud_cover} %</p>
    `);

    $('#results').html(htmlForecast);
}

function errorHandler(err) {
   if(err.code == 1) {
      alert("Error: Access is denied!");
   } else if( err.code == 2) {
      alert("Error: Position is unavailable!");
   }
}

// Get geolocation
function getLocation(){
  if(navigator.geolocation){
    navigator.geolocation.getCurrentPosition(showLocation, errorHandler);
  } else{
    alert("Sorry, browser does not support geolocation!");
  }
}

$(document).on('turbolinks:load', function() {

  var forecastSearch = $('form#forecast-search');
  var locationInput = $('input#location');
  var results = $('#results');
  var loading = $('div.ui.inverted.dimmer');

  // AJAX: get weather forecast by search
  forecastSearch.on('submit', function handleSubmit(event) {
    event.preventDefault();

    var q = locationInput.val();

    if (q === "") {
      alert("Please enter a location");
      return;
    }

    results.empty();
    loading.addClass('active');

    $.ajax({
      method: 'GET',
      url: '/eggplant',
      data: { q: q },
      dataType: 'json',
      success: searchSuccess
    });

    forecastSearch[0].reset();
  });

  function searchSuccess(json) {
    data = json;
    loading.removeClass('active');

    var htmlForecast = (`
        <p id='city-name'><i class="marker large icon"></i> ${data.city}, ${data.state}</p>
        <p id='moon-phase'>${data.moon_phase}</p>
        <p id='curr-temp'>${data.imperial} °F | ${data.metric} °C</p>
        <p id='cloud-cover'><i class="cloud large icon"></i> ${data.cloud_cover} %</p>
      `);

      $('#results').html(htmlForecast);
  }

  // Preview before uploading image
  $('#pictureInput').on('change', function(event) {
    var files = event.target.files;
    var image = files[0]
    // here's the file size
    console.log(image.size);
    var reader = new FileReader();
    reader.onload = function(file) {
      var img = new Image();
      console.log(file);
      img.src = file.target.result;
      $('#target').html(img);
    }
    reader.readAsDataURL(image);
    console.log(files);
  });
});
