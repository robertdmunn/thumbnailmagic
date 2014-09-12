
<p>URI</p>
<cfscript>
	urithumbnail = service.createThumbnail( uri = "www.wikipedia.org" );
</cfscript>


<p>service.createThumbnail( uri = "http://www.cnn.com" );
<cfdump var="#urithumbnail#"/>
<cfloop from="1" to="#arraylen(urithumbnail)#" index="i">
<cfoutput>	<div style="display:inline;"><img src="tiles/#urithumbnail[i]#" /></div></cfoutput>
</cfloop>	