<!doctype html>
<html>
	<head>
	<title>Thumbnail Magic</title>
	
	
		
	</head>
	<body>
	
	Thumbnail Magic is a CFML-based tool for generating thumbnails from a variety of sources:
	
	<ul>
		<li>
		images
		</li>
		<li>
		text files
		</li>
		<li>
		videos
		</li>
		<li>
		PDFs
		</li>
		<li>
		OpenOffice documents
		</li>
		<li>
		web pages
		</li>
	</ul>
	
	<p>
	See the <a href="/examples/index.cfm">examples page</a> for examples of how to generate thumbnails for each source.
	</p>
	
	<h3>Dependencies</h3>
	<p>
	ThumbnailMagic depends on the following external libraries that you must install yourself:
	<ul>
		<li>ffmpeg - used for rendering video thumbnails</li>
		<li>JDK 7</li>
		<li>NodeJS - used for rendering web page thumbnails.</li>
	</ul>
	ThumbnailMagic packages the following external dependencies with the distribution:
	<ul>
		<li>node-webshot - used for rendering web page thumbnails. </li>
		<li>Apache Tika ( OS X Only ) - used to determine mime type of thumbnail source. If you are running OS X, copy the included /lib/tika-app-1.6.jar file into your CFML engine's classpath.</li>
	</ul>
	</p>
	
	
	</body>
	

</html>