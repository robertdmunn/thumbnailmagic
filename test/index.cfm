<!doctype html>
<html>
	<head>
	<title>Thumbnail Magic</title>
	
	
		
	</head>
	<body>
	Test thumbnail functionality:<br/><br/>
	
	<p>PDF: http://en.wikibooks.org/wiki/Open_Source (rendered as pdf)
	</p>	
	<p>
	Image: sailrock.jpg
	</p>
	<p>
	Video: NASA solar flare video - http://www.nasa.gov/downloadable/videos/spurting_plasma.mp4
	</p>
	<cfscript>
		service = createObject( "thumbnailmagic.ThumbnailService" ).init( thumbnailPath = expandPath( "./tiles/" ) );
		imgthumbnail = service.createThumbnail( filepath = expandPath( "./" ), filename = "sailrock.jpg", options = {} );
		pdfthumbnail = service.createThumbnail( filepath = expandPath( "./" ), filename = "Open Source.pdf", options = { pages : "1,3,5-6" } );
		videothumbnail = service.createThumbnail( filepath = expandPath( "./" ), filename = "spurting_plasma.mp4", options = { rate : 1, frames : 1, start: "00:00:10" } );

	</cfscript>
	<cfoutput>
		<cfdump var="#pdfthumbnail#"/>
		<br/>
		<cfdump var="#imgthumbnail#"/>
		<br/>
		<cfdump var="#videothumbnail#"/>

	
	<p>PDF</p>
	<p>service.createThumbnail( filepath = expandPath( "./" ), filename = "Open Source.pdf", options = { pages : "1,3,5-6" } );</p>
	<cfloop from="1" to="#arraylen(pdfthumbnail)#" index="i">
		<div style="display:inline;"><img src="tiles/#pdfthumbnail[i]#" /></div>
	</cfloop>
	<p>
	Image
	</p>
	<p>
	service.createThumbnail( filepath = expandPath( "./" ), filename = "sailrock.jpg", options = {} );
	</p>
	<cfloop from="1" to="#arraylen(imgthumbnail)#" index="i">
		<div style="display:inline;"><img src="tiles/#imgthumbnail[i]#" /></div>
	</cfloop>

	<p>Video</p>
	<p>service.createThumbnail( filepath = expandPath( "./" ), filename = "spurting_plasma.mp4", options = { rate : 1, frames : 1, start: "00:00:10" } );</p>
	<cfloop from="1" to="#arraylen(videothumbnail)#" index="i">
		<div style="display:inline;"><img src="tiles/#videothumbnail[i]#" /></div>
	</cfloop>
	</cfoutput>
	</body>
</html>