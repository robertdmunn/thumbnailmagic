<!doctype html>
<html>
	<head>
	<title>Thumbnail Magic</title>
	
	</head>
	<body>
	<cfoutput>Examples of thumbnail functionality:<br/><br/></cfoutput>
	
	<cfscript>
		service = new thumbnailmagic.ThumbnailService( thumbnailPath = expandPath( "./tiles/" ) );
	
	</cfscript>

 	<cfinclude template="image.cfm"/>
	<cfflush>
	<cfinclude template="oo.cfm"/>
	<cfflush>
	<cfinclude template="pdf.cfm"/>
	<cfflush>
	<cfinclude template="text.cfm"/>
	<cfflush>
	<cfinclude template="uri.cfm"/>
	<cfflush>
	<cfinclude template="video.cfm"/>
	<cfflush> 
	<cfinclude template="oomultiple.cfm"/>

	
	</body>
</html>