<cfoutput>
<p>
Video: NASA solar flare video - http://www.nasa.gov/downloadable/videos/spurting_plasma.mp4
</p>	
</cfoutput>
<cfscript>
	videothumbnail = service.createThumbnail( filepath = expandPath( "./" ), filename = "spurting_plasma.mp4", options = { rate : 1, frames : 1, start: "00:00:10" } );
</cfscript>
<cfoutput>
<p>Usage:</p>

<p>service.createThumbnail( filepath = expandPath( "./" ), filename = "spurting_plasma.mp4", options = { rate : 1, frames : 1, start: "00:00:10" } );</p>
<p>Results:</p>
<cfdump var="#videothumbnail#"/>
<p>Generated thumbnail:</p>
<cfloop from="1" to="#arraylen(videothumbnail)#" index="i">
	<div style="display:inline;"><img src="tiles/#videothumbnail[i]#" /></div>
</cfloop>
</cfoutput>