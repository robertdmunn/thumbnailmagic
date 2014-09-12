<p>
Video: NASA solar flare video - http://www.nasa.gov/downloadable/videos/spurting_plasma.mp4
</p>	
<cfscript>
	videothumbnail = service.createThumbnail( filepath = expandPath( "./" ), filename = "spurting_plasma.mp4", options = { rate : 1, frames : 1, start: "00:00:10" } );
</cfscript>


<p>service.createThumbnail( filepath = expandPath( "./" ), filename = "spurting_plasma.mp4", options = { rate : 1, frames : 1, start: "00:00:10" } );</p>
<cfdump var="#videothumbnail#"/>

<cfloop from="1" to="#arraylen(videothumbnail)#" index="i">
<cfoutput>	<div style="display:inline;"><img src="tiles/#videothumbnail[i]#" /></div></cfoutput>
</cfloop>
