<!doctype html>
<html>
	<head>
	<title>Thumbnail Magic</title>
	
	
		
	</head>
	<body>
	Examples of thumbnail functionality:<br/><br/>
	
	<cfscript>
		service = createObject( "thumbnailmagic.ThumbnailService" ).init( thumbnailPath = expandPath( "./tiles/" ) );
	
	</cfscript>

	<cfinclude template="image.cfm"/>
	<cfinclude template="oo.cfm"/>
	<cfinclude template="pdf.cfm"/>
	<cfinclude template="text.cfm"/>
	<cfinclude template="uri.cfm"/>
	<cfinclude template="video.cfm"/>

	
	</body>
</html>