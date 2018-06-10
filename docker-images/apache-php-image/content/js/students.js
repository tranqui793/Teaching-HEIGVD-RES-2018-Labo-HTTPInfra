$(function(){

console.log("loading students");
function loadStudents(){
	$.getJSON("/api/students/", function( students){
		console.log(students);
		var message = "Nobody is here";
		if(students.length > 0){
			message =students[0].city + " "+students[0].country;
		}
		$(".intro-text").text(message);
});
};
loadStudents();
setInterval(loadStudents,2000);
});

