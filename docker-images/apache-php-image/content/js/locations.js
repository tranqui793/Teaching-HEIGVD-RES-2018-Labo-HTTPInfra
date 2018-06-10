$(function(){

console.log("loading locations");
function loadLocations(){
	$.getJSON("/api/locations/", function( locations){
		console.log(locations);
		var message = "Nobody is here";
		if(locations.length > 0){
			message =locations[0].city + " "+locations[0].country;
		}
		$(".intro-text").text(message);
});
};
loadLocations();
setInterval(loadLocations,2000);
});
