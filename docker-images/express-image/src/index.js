var Chance = require('chance');
var chance = new Chance();

var express = require('express');
var app = express();

// pour afficher de maniere jolie dans le navigateur web
app.set('json spaces', 40);

// renvoi une liste d'etudiants quand on fait une requete HTTP vers la racine
app.get('/', function (req, res) {
	
	res.json(generateLocations());
});


app.listen(3000, function () {
	console.log('Accepting HTTP requests on port 3000.');
});

function generateLocations() {

	var numberOfLocations = chance.integer({
		min: 0,
		max: 10
	});

	console.log(numberOfLocations);
	
	var locations = [];
	for (var i = 0; i < numberOfLocations; i++) {

		var address = chance.address();
		var city = chance.city();
		var country = chance.country({
			full:true
		});

		locations.push({
			address: address,
			city:city,
			country:country
		});
	};

	// pour afficher de maniere jolie dans les log du serveur
	console.log(JSON.stringify(locations,null,'\t'));

	return locations;
}