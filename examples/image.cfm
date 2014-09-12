<cfoutput><p>
Image - Sail Rock
</p>
</cfoutput>
<cfscript>
	imgthumbnail = service.createThumbnail( filepath = expandPath( "./" ), filename = "sailrock.jpg", options = {} );
</cfscript>
<cfoutput>
<p>Usage:</p>
<p>
service.createThumbnail( filepath = expandPath( "./" ), filename = "sailrock.jpg", options = {} );
</p>
<p>Results:</p>
<cfdump var="#imgthumbnail#"/>
<p>Generated thumbnail:</p>
<cfloop from="1" to="#arraylen(imgthumbnail)#" index="i">
	<div style="display:inline;"><img src="tiles/#imgthumbnail[i]#" /></div>
</cfloop>
</cfoutput>