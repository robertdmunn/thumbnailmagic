<cfoutput><p>Text File</p></cfoutput>

<cfscript>
	textthumbnail = service.createThumbnail( filepath = expandPath( "./" ), filename = "mitlicense.txt" );	
</cfscript>
<cfoutput>	
<p>Usage:</p>
<p>service.createThumbnail( filepath = expandPath( "./" ), filename = "mitlicense.txt" );

<p>Results:</p>
<cfdump var="#textthumbnail#"/>
<p>Generated thumbnail:</p>
<cfloop from="1" to="#arraylen(textthumbnail)#" index="i">
<div style="display:inline;"><img src="tiles/#textthumbnail[i]#" /></div>
</cfloop> 
</cfoutput>