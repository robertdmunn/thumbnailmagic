##thumbnailmagic
==============

A CFML-based tool for generating thumbnails from a variety of sources.

    * images
    * text files
    * videos
    * PDFs
    * OpenOffice documents
    * web pages

###Version: 0.1.0

See the examples page for examples of how to generate thumbnails for each source.

###Dependencies

ThumbnailMagic depends on the following external libraries that you must install yourself:

    * JDK 7
    * ffmpeg - used for rendering video thumbnails
    * NodeJS - used for rendering web page thumbnails.
    * OpenOffice - used for rendering thumbnails of MSOffice documents and multi-page or high quality thumbnails of OpenOffice documents
    * jodConverter - Java package used to connect to OpenOffice

ThumbnailMagic packages the following external dependencies with the distribution:

    * node-webshot - used for rendering web page thumbnails. Webshot is included in the distribution
    * Apache Tika ( OS X Only ) - used to determine mime type of thumbnail source. If you are running OS X, 
      copy the included /lib/tika-app-1.6.jar file into your CFML engine's classpath.

###Installation

1. Download the archive of the project, or clone the repo using Git:

    git clone https://github.com/robertdmunn/thumbnailmagic.git

2. Adding ThumbnailMagic to a CFML project:

   a. Copy the ./thumbnailmagic folder into your project

   or

   b. Map the ./thumbnailmagic folder to /thumbnailmagic in your CFML engine's administrator. 

Optional 

3. Verify NodeJS is installed for web page thumbnail support

   Type node at a command prompt. If node is installed and mapped on your PATH, you will get a node shell:
    
    &gt;

4. Verify ffmpeg is installed for video thumbnail support.

   Type ffmpeg at a command prompt. If ffmpeg is installed and mapped on your PATH, you will see something like the following: 

   $ ffmpeg version 2.3.2 Copyright (c) 2000-2014 the FFmpeg developers
 
5. Verify OpenOffice is installed for MSOffice/OpenOffice multi-page thumbnail support

   a. Copy the jars from /lib/jodconverters into your CFML engine's classpath. 
	 
   b. Current configuration runs OpenOffice service on localhost port 2002. Adjust settings in /thumbnailmagic/system/oolib.cfc.

###Usage

1. Instantiate the service:

   service = new thumbnailmagic.ThumbnailService( thumbnailPath = expandPath( "./tiles/" ) );
   
   or passing in htmlStlye argument to render HTML files as layout rather than source:
   
   service = new thumbnailmagic.ThumbnailService( thumbnailPath = expandPath( "./tiles/" ), options = { htmlStyle: "rendered" } );
   
   or overriding the default port and path for OpenOffice
   
   service = new thumbnailmagic.ThumbnailService( thumbnailPath = expandPath( "./tiles/" ), options = { ooPort: 8000, ooPath: "/usr/local/openoffice"  } );
    

2. Configuring for Coldbox

   If you are using Wirebox, just refer to ThumbnailServiceColdbox in your Wirebox configuration:
	 
	      map( "ThumbnailService" ).to( "thumbnailmagic.ThumbnailServiceColdbox" )
	         .asSingleton();	

   You only need these setting in your Coldbox configuration:
   
				thumbnailPath = "<local path to thumbnails>", 
				pathToOO = "<local path to soffice binary>", // OS X - /Applications/OpenOffice.app/Contents
				ooHost = "localhost", // at current, only localhost is supported as OO host
				ooPort = 2002
  
Generating thumbnails:

   // pass either a filepath and filename or a uri
   // options is an optional argument in the form of a struct
   
       options = { 
       
       height : <number of pixels> (default: 200), // height of resulting thumbnail 
       width : <number of pixels>,  // width of resulting thumbnail, leave out to scale width in proportion to height 
       overwrite: "overwrite|rename|error" (default overwrite),  // whether to replace existing thumbnails
       filename : <filename> // name of resulting thumbnail, e.g. "thumb.png"
       
       PDF only:
       
       scale: <percentage of original PDF>, ( default: 30) // scale of intermediate thumbnail 
       pages: <command separated list> (default 1), // pages to render, e.g. 1,2 or 1,3-5,11-15,50 or 1-90 
       
       video only:
       
       rate : <number> (default 1), // number of seconds between snapshots 
       frames : <number> (default 1), // total number of thumbnails to create
       start : <time> (default 00:01:00), // starting point in the video, e.g. 00:01:00 (one minute into video)
       timeout : <seconds> (default 60), // how long the video thumbnail process should run before timing out
       
       }
  
   
	 service.createThumbnail( filename, filepath | uri, options );


for URIs:

    urithumbnail = service.createThumbnail( uri = "www.wikipedia.org" );

for images:

    imgthumbnail = service.createThumbnail( 
    	filepath = expandPath( "./" ), 
    	filename = "sailrock.jpg", 
    	options = {} );
   	     
for OpenOffice documents, spreadsheets, presentations, and graphics:

for thumbnail extraction from document (low quality):

    oothumbnail =  service.createThumbnail( 
    	filepath = expandPath( "./" ), 
    	filename = "openoffice.odt" );

for thumbnail generation (high quality):

    oothumbnail =  service.createThumbnail( 
    	filepath = expandPath( "./" ), 
    	filename = "openoffice.odt",
    	options = {extract : false } );

with multiple pages:

    oothumbnail =  service.createThumbnail( 
    	filepath = expandPath( "./" ), 
    	filename = "grimms_fairy_tales.doc", 
    	options = { pages : "1,50-52,213" }   );

for PDFs:

   	pdfthumbnail = service.createThumbnail( 
   		filepath = expandPath( "./" ), 
   		filename = "Open Source.pdf", 
   		options = { pages : "1,3,5-6" } );

for HTML files as source: 

	htmlthumbnail =  service.createThumbnail( 
    	filepath = expandPath( "./" ), 
    	filename = "index.html" );	 
 
for HTML files as rendered HTML: 

	htmlthumbnail =  service.createThumbnail( 
    	filepath = expandPath( "./" ), 
    	filename = "index.html",
    	htmlStyle = "rendered" );	 
    	   	
for plain text files:

    textthumbnail = service.createThumbnail( 
    	filepath = expandPath( "./" ), 
    	filename = "mitlicense.txt" );	   	

for videos:

    videothumbnail = service.createThumbnail( 
    	filepath = expandPath( "./" ), 
    	filename = "spurting_plasma.mp4", 
    	options = { rate : 1, frames : 1, start: "00:00:10" } );


### Demo

Copy the /examples folder to a webroot somewhere and access /examples/index.cfm to see ThumbnailMagic in action.

### License

		(The MIT License)

		Copyright (c) 2014 Robert Munn

		Permission is hereby granted, free of charge, to any person obtaining a copy of
		this software and associated documentation files (the 'Software'), to deal in
		the Software without restriction, including without limitation the rights to
		use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
		the Software, and to permit persons to whom the Software is furnished to do so,
		subject to the following conditions:
		
		The above copyright notice and this permission notice shall be included in all
		copies or substantial portions of the Software.
		
		THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
		IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
		FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
		COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
		IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
		CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
