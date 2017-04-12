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
  New: 'https://image.ibb.co/h09sMQ/newmoon.jpg',
  WaxingCrescent: 'https://image.ibb.co/kG1iT5/waxingcrescent.jpg',
  FirstQuarter: 'https://image.ibb.co/m9xe1Q/firstquarter.jpg',
  WaxingGibbous: 'https://image.ibb.co/ktQhMQ/waxinggibbous.jpg',
  Full: 'https://image.ibb.co/caJ8vk/fullmoon.jpg',
  WaningGibbous: 'https://image.ibb.co/b0Eyvk/wanninggibbous.jpg',
  LastQuarter: 'https://image.ibb.co/ctc1Fk/lastquarter.jpg',
  WaningCrescent: 'https://image.ibb.co/fiEbgQ/waningcrescent.jpg'
}

function onSuccess(json) {
  data = json;

  var htmlForecast = (`
      <h2>${data.city}, ${data.state}</h2>
      <img src="${moonPhases[data.moon_phase]}" class="ui centered image">
      <h3>${data.imperial} °F / ${data.metric} °C</h3>
      <h3><i class="cloud large icon"></i> ${data.cloud_cover} %</h3>
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
      success: searchSuccess,
      error: searchError
    });

    forecastSearch[0].reset();
  });

  function searchSuccess(json) {
    data = json;
    loading.removeClass('active');

    var htmlForecast = (`
        <h2> ${data.city}, ${data.state}</h2>
        <img src="${moonPhases[data.moon_phase]}" class="ui centered image">
        <h3>${data.imperial} °F | ${data.metric} °C</h3>
        <h3><i class="cloud large icon"></i> ${data.cloud_cover} %</h3>
      `);

      $('#results').html(htmlForecast);
  }

  function searchError(error) {
    loading.removeClass('active');

    var htmlError = (`
        <div id='modal-forecast'>
          <h2> Oops! Forecast unavailable for this location <i class="meh icon"></i></h2>
        </div>
      `);

      $('#results').html(htmlError);
      $('.forecast.content').html(htmlError);
  }

  // Preview before uploading image
  $('#pictureInput').on('change', function(event) {
    var files = event.target.files;
    var image = files[0]
    var reader = new FileReader();
    reader.onload = function(file) {
      var img = new Image();
      img.src = file.target.result;
      $('#target').html(img);
    }
    reader.readAsDataURL(image);
  });

  // Collapsable reply
  $('a.reply').on('click', function() {
    $('.toggle-reply').toggle('slow');
  });

  // Entry show location modal + forecast
  $('a#map-modal').on('click', function(event) {
    event.preventDefault();
    $('.ui.basic.modal').modal('show');

    var q = $('a#map-modal').text();

    $.ajax({
      method: 'GET',
      url: '/eggplant',
      data: { q: q },
      dataType: 'json',
      success: modalSuccess,
      error: searchError
    });
  });

  function modalSuccess(json) {
    data = json;

    var htmlForecast = (`
        <div id='modal-forecast'>
          <h3>${data.moon_phase}</h3>
          <h3>${data.imperial} °F / ${data.metric} °C</h3>
          <h3><i class="cloud large icon"></i> ${data.cloud_cover} %</h3>
        </div>
      `);

      $('.forecast.content').html(htmlForecast);
  }

});
