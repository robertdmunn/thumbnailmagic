
<cfoutput><p>OO</p></cfoutput>
<cfscript>
	oothumbnail =  service.createThumbnail( filepath = expandPath( "./" ), filename = "openoffice.odt", options = {} );
</cfscript>
<cfoutput>
<p>service.createThumbnail( filepath = expandPath( "./" ), filename = "openoffice.odt", options = {} );</p>
<p>Results:</p>
<cfdump var="#oothumbnail#"/>
<p>Generated thumbnail:</p>
<cfloop from="1" to="#arraylen(oothumbnail)#" index="i">
	<div style="display:inline;"><img src="tiles/#oothumbnail[i]#" /></div>
</cfloop>	
</cfoutput>