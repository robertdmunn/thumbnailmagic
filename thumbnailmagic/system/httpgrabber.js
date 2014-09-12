/*
 * 
 * Grabs a webpage and generates a thumbnail using PhantomJS, which uses Webkit to render the page
 * 
 * usage: node httpgrabber.js h=www.host.com -p=/path/to/image/
 * 
 * 
 * */



var webshot = require('../node_modules/webshot');
var args = process.argv;
var required = ['h'];
var options = ['p'];
var argMap = {};
var optMap = {};
var arg = [];

var webshotOptions = {
	onLoadFinished : {
		fn : function(status) {
			var tags = document.getElementsByTagName(this.tagToReplace);
			for (var i = 0; i < tags.length; i++) {
				var tag = tags[i];
				tag.innerHTML = 'The loading status of this page is: ' + status;
			}
		},
		context : {
			tagToReplace : 'h2'
		}
	}
};

args.forEach(function(val) {
    arg = val.split("=");
    if (arg[1] !== undefined) {
        if (arg[0].substring(0, 1) === "-") {
            // remove dash optional identifier
            arg[0] = arg[0].substring(1, arg[0].length);
            if (options.indexOf(arg[0]) >= 0) {
                optMap[arg[0]] = arg[1];
            } else {
                process.stderr.write("Illegal option: " + arg[0] + " ignored.\n");
            }
        } else {
            if (required.indexOf(arg[0]) >= 0) {
                argMap[arg[0]] = arg[1];
            } else {
                process.stderr.write("Illegal argument: " + arg[0] + " ignored.\n");
            }
        }
    }

});

required.forEach(function(val) {
    if (argMap[val] === undefined) {
        process.stderr.write("Required argument " + val + " not supplied, exiting.\n");
        process.exit(0);
    }
});


/*	console.log("Required arguments: ");
console.log(argMap);
console.log("Optional arguments: ");
console.log(optMap);
	*/

//default output folder
if( optMap['p'] === undefined ){
	optMap['p'] =  __dirname + '/tmp/';
}


webshot(argMap['h'], optMap['p'] + argMap['h'] + '.png', webshotOptions, function(err) {
	if (err)
		return console.log(err);
	console.log('OK');
});



