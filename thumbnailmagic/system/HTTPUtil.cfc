<cfcomponent output="false">


	<cffunction name="init" access="public" output="false" returntype="thumbnailmagic.system.HTTPUtil">
		<cfargument name="globals" type="thumbnailmagic.system.Globals" required="true" />
		<cfset variables.instance = {} />
		<cfset setGlobals( arguments.globals ) />
		<cfset _setNode() />
		<cfreturn this />
	</cffunction>

	<cffunction name="createThumbnail" access="public" output="false" returntype="array">
		<cfargument name="uri" type="string" required="true" />
		
		<cfset local.timeout = 30 />
		<cfexecute
			name="#_getNode()#"
			arguments="#expandpath('/thumbnailmagic/system/httpgrabber.js')#  h=#arguments.uri# -p=#getGlobals().getThumbnailPath()#"
			timeout="#local.timeout#"
			errorVariable="errorOut" />
			
		<cfreturn [arguments.uri & ".png"] />
	</cffunction>
	
	<cffunction name="setGlobals" access="public" returntype="void">
		<cfargument name="globals" type="thumbnailmagic.system.Globals" required="true" />
		
		<cfset variables.instance.globals = arguments.globals />
	</cffunction>
	
	<cffunction name="getGlobals" access="public" returntype="thumbnailmagic.system.Globals">
		<cfreturn variables.instance.globals />
	</cffunction>

	<cffunction name="_setNode" access="private" returntype="void">
		<cfscript>
			if( getGlobals().getOS() contains "Windows" ){
				variables.instance.Node = "node.exe";
			}else{
				variables.instance.Node = "node";
			}
		</cfscript>
	</cffunction>
 
	<cffunction name="_getNode" access="private" returntype="string">
		<cfreturn variables.instance.Node />
	</cffunction>			
</cfcomponent>