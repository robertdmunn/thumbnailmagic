<p>Text File</p>

<cfscript>
	textthumbnail = service.createThumbnail( filepath = expandPath( "./" ), filename = "mitlicense.txt" );	
</cfscript>


<p>service.createThumbnail( filepath = expandPath( "./" ), filename = "mitlicense.txt" );

<cfdump var="#textthumbnail#"/>

<cfloop from="1" to="#arraylen(textthumbnail)#" index="i">
<cfoutput>	<div style="display:inline;"><img src="tiles/#textthumbnail[i]#" /></div></cfoutput>
</cfloop> 