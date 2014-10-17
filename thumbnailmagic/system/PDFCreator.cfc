<cfcomponent output="false">


	<cffunction name="init" access="public" output="false" returntype="thumbnailmagic.system.PDFCreator">
		<cfargument name="globals" type="thumbnailmagic.system.Globals" required="true" />
		<cfset variables.instance = {} />

		<cfset setGlobals( arguments.globals ) />
		<cfreturn this />
	</cffunction>

	<cffunction name="createPDF" access="public" output="false" returntype="string">
		<cfargument name="source" type="string" required="true" />
		<cfargument name="contenttype" type="string" required="true" />
		<cfargument name="htmlStyle" type="string" required="false" />
		<cfset local.htmlStyle = ( isNull( arguments.htmlStyle ) ? getGlobals().getHTMLStyle() : arguments.htmlStyle ) />
		<cfset local.id = createUUID() />
		<cfdocument filename="#getGlobals().getThumbnailPath()##local.id#.pdf" format="PDF" overwrite="true">
		<cfoutput>
			<cfif arguments.contenttype eq "text/html" and local.htmlStyle eq "rendered">
				#arguments.source#
			<cfelse>
				<pre>#htmleditformat( arguments.source )#</pre>
			</cfif>
		</cfoutput>
		</cfdocument>

		<cfreturn "#local.id#.pdf" />
	</cffunction>

	<cffunction name="setGlobals" access="public" returntype="void">
		<cfargument name="globals" type="thumbnailmagic.system.Globals" required="true" />

		<cfset variables.instance.globals = arguments.globals />
	</cffunction>

	<cffunction name="getGlobals" access="public" returntype="thumbnailmagic.system.Globals">
		<cfreturn variables.instance.globals />
	</cffunction>

</cfcomponent>