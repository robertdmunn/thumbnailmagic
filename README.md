##thumbnailmagic
==============

A CFML-based tool for generating thumbnails from a variety of sources.

    * images
    * text files
    * videos
    * PDFs
    * OpenOffice documents
    * web pages

See the examples page for examples of how to generate thumbnails for each source.

###Dependencies

ThumbnailMagic depends on the following external libraries that you must install yourself:

    * JDK 7
    * ffmpeg - used for rendering video thumbnails
    * NodeJS - used for rendering web page thumbnails.

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
   
###Usage

1. Instantiate the service:

   service = new thumbnailmagic.ThumbnailService( thumbnailPath = expandPath( "./tiles/" ) );
   
    
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

    oothumbnail =  service.createThumbnail( 
    	filepath = expandPath( "./" ), 
    	filename = "openoffice.odt" );

for PDFs:

   	pdfthumbnail = service.createThumbnail( 
   		filepath = expandPath( "./" ), 
   		filename = "Open Source.pdf", 
   		options = { pages : "1,3,5-6" } );
   	
for plain text files:

    textthumbnail = service.createThumbnail( 
    	filepath = expandPath( "./" ), 
    	filename = "mitlicense.txt" );	   	

for videos:

    videothumbnail = service.createThumbnail( 
    	filepath = expandPath( "./" ), 
    	filename = "spurting_plasma.mp4", 
    	options = { rate : 1, frames : 1, start: "00:00:10" } );

