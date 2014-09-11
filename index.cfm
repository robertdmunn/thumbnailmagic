<!doctype html>
<html>
	<head>
	<title>Thumbnail Magic</title>
	
	
		
	</head>
	<body>
	Sample pdf thumbnail:<br/>
	http://en.wikibooks.org/wiki/Open_Source
		
	<cfscript>
		service = createObject( "thumbnailmagic.ThumbnailService" ).init( thumbnailPath = expandPath( "./test/tiles/" ) );
		thumbnail = service.createThumbnail( filepath = expandPath( "./test/" ), filename = "Open Source.pdf", options = { pages : "1,3,5-6" } );
	</cfscript>
	<cfoutput>
		<cfdump var="#thumbnail#"/>
	</cfoutput>
	</body>
	

</html>