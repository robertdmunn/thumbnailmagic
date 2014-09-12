
<p>OO</p>
<cfscript>
	oothumbnail =  service.createThumbnail( filepath = expandPath( "./" ), filename = "openoffice.odt", options = {} );
</cfscript>

<p>service.createThumbnail( filepath = expandPath( "./" ), filename = "openoffice.odt", options = {} );</p>

<cfdump var="#oothumbnail#"/>
<cfloop from="1" to="#arraylen(oothumbnail)#" index="i">
<cfoutput>	<div style="display:inline;"><img src="tiles/#oothumbnail[i]#" /></div></cfoutput>
</cfloop>	