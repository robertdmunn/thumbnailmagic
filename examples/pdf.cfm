<cfoutput> <p>PDF</p></cfoutput>

<cfscript>
	pdfthumbnail = service.createThumbnail( filepath = expandPath( "./" ), filename = "Open Source.pdf", options = { pages : "1,3,5-6" } );
</cfscript>
<cfoutput><p>Usage:</p>
<p>service.createThumbnail( filepath = expandPath( "./" ), filename = "Open Source.pdf", options = { pages : "1,3,5-6" } );</p>
<p>Results:</p>
<cfdump var="#pdfthumbnail#"/>
<p>Generated thumbnails:</p>
<cfloop from="1" to="#arraylen(pdfthumbnail)#" index="i">
	<div style="display:inline;"><img src="tiles/#pdfthumbnail[i]#" /></div>
</cfloop>
</cfoutput>