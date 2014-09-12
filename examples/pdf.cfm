 <p>PDF</p>

<cfscript>
	pdfthumbnail = service.createThumbnail( filepath = expandPath( "./" ), filename = "Open Source.pdf", options = { pages : "1,3,5-6" } );
</cfscript>

<p>service.createThumbnail( filepath = expandPath( "./" ), filename = "Open Source.pdf", options = { pages : "1,3,5-6" } );</p>
<cfdump var="#pdfthumbnail#"/>

<cfloop from="1" to="#arraylen(pdfthumbnail)#" index="i">
<cfoutput>	<div style="display:inline;"><img src="tiles/#pdfthumbnail[i]#" /></div></cfoutput>
</cfloop>