<p>
Image - Sail Rock
</p>
<cfscript>
	imgthumbnail = service.createThumbnail( filepath = expandPath( "./" ), filename = "sailrock.jpg", options = {} );
</cfscript>

<p>
service.createThumbnail( filepath = expandPath( "./" ), filename = "sailrock.jpg", options = {} );
</p>

<cfdump var="#imgthumbnail#"/>

<cfloop from="1" to="#arraylen(imgthumbnail)#" index="i">
<cfoutput>	<div style="display:inline;"><img src="tiles/#imgthumbnail[i]#" /></div></cfoutput>
</cfloop>
