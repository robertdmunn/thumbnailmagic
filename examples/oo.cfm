
<cfoutput><p>OO</p></cfoutput>
<cfscript>
	oothumbnail =  service.createThumbnail( filepath = expandPath( "./" ), filename = "minutes.odt", options = {} );
	oothumbnailhq =  service.createThumbnail( filepath = expandPath( "./" ), filename = "minutes.odt", options = { extract : false } );
</cfscript>
<cfoutput>
<p>Usage (low quality, fast):</p>
<p>service.createThumbnail( filepath = expandPath( "./" ), filename = "minutes.odt", options = {} );</p>
<p>Results:</p>
<cfdump var="#oothumbnail#"/>
<p>Generated thumbnail:</p>
<cfloop from="1" to="#arraylen(oothumbnail)#" index="i">
	<div style="display:inline;"><img src="tiles/#oothumbnail[i]#" /></div>
</cfloop>
<p>Usage (high quality):</p>
<p>service.createThumbnail( filepath = expandPath( "./" ), filename = "minutes.odt", options = { extract : false } );</p>
<p>Results:</p>
<cfdump var="#oothumbnail#"/>
<p>Generated thumbnail:</p>
<cfloop from="1" to="#arraylen(oothumbnailhq)#" index="i">
	<div style="display:inline;"><img src="tiles/#oothumbnailhq[i]#" /></div>
</cfloop>	

</cfoutput>