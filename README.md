##thumbnailmagic
==============

A CFML-based tool for generating thumbnails from a variety of sources.

    images
    text files
    videos
    PDFs
    OpenOffice documents
    web pages

See the examples page for examples of how to generate thumbnails for each source.

###Dependencies

ThumbnailMagic depends on the following external libraries that you must install yourself:

    ffmpeg - used for rendering video thumbnails
    JDK 7
    NodeJS - used for rendering web page thumbnails.

ThumbnailMagic packages the following external dependencies with the distribution:

    node-webshot - used for rendering web page thumbnails. Webshot is included in the distribution
    Apache Tika ( OS X Only ) - used to determine mime type of thumbnail source. If you are running OS X, copy the included /lib/tika-app-1.6.jar file into your CFML engine's classpath.

