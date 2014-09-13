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
    
    > 

4. Verify ffmpeg is installed for video thumbnail support.

   Type ffmpeg at a command prompt. If ffmpeg is installed and mapped on your PATH, you will see something like the following: 

   $ ffmpeg version 2.3.2 Copyright (c) 2000-2014 the FFmpeg developers
   
