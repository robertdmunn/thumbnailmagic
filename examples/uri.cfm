
<cfoutput><p>URI</p></cfoutput>
<cfscript>
	urithumbnail = service.createThumbnail( uri = "www.wikipedia.org" );
</cfscript>
<cfoutput>	
<p>Usage:</p>

<p>service.createThumbnail( uri = "http://www.cnn.com" );
<p>Results:</p>
<cfdump var="#urithumbnail#"/>
<p>Generated thumbnail:</p>
<cfloop from="1" to="#arraylen(urithumbnail)#" index="i">
<div style="display:inline;"><img src="tiles/#urithumbnail[i]#" /></div>
</cfloop>	
</cfoutput>