<cfoutput><p>Office multiple thumbnails</p></cfoutput>

<cfscript>
	officethumbnails = service.createThumbnail( filepath = expandPath( "./" ), filename = "grimms_fairy_tales.doc", options = { pages : "1,50-52,213" }   );	
</cfscript>
<cfoutput>	
<p>Usage:</p>
<p>service.createThumbnail( filepath = expandPath( "./" ), filename = "grimms_fairy_tales.doc", options = { pages : "1,50-52,213" }  );

<p>Results:</p>
<cfdump var="#officethumbnails#"/>
<p>Generated thumbnails:</p>
<cfloop from="1" to="#arraylen(officethumbnails)#" index="i">
<div style="display:inline;"><img src="tiles/#officethumbnails[i]#" /></div>
</cfloop> 
</cfoutput>