<!doctype html>
<html>
	<head>
	<title>Thumbnail Magic</title>
	
	
		
	</head>
	<body>
	Sample thumbnails:<br/>
	http://en.wikibooks.org/wiki/Open_Source
		
	<cfscript>
		service = createObject( "thumbnailmagic.ThumbnailService" ).init( thumbnailPath = expandPath( "./tiles/" ) );
		imgthumbnail = service.createThumbnail( filepath = expandPath( "./" ), filename = "sailrock.jpg", options = {} );
		pdfthumbnail = service.createThumbnail( filepath = expandPath( "./" ), filename = "Open Source.pdf", options = { pages : "1,3,5-6" } );
		videothumbnail = service.createThumbnail( filepath = expandPath( "./" ), filename = "spurting_plasma.mp4", options = { rate : 1, frames : 1, start: "00:00:10" } );

	</cfscript>
	<cfoutput>
		<cfdump var="#imgthumbnail#"/>
		<cfdump var="#pdfthumbnail#"/>
		<cfdump var="#videothumbnail#"/>

	</cfoutput>
	</body>
	

</html>