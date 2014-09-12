<cfcomponent>

	<cffunction name="init" access="public" returntype="thumbnailmagic.system.BaseThumbnailCreator">
		<cfargument name="thumbnailPath" type="string" required="true" />
		<cfargument name="os" type="string" required="true" />
		<cfargument name="cfServer" type="string" required="true" />

		<cfscript>
			variables.instance = {};
			setThumbnailPath( arguments.thumbnailPath );
			setOS( arguments.os );
			setcfServer( arguments.cfServer );
			return this;
		</cfscript>	
	</cffunction>

	<cffunction name="createThumbnail" access="public" returntype="array">
		<cfargument name="filepath" type="string" required="true" />
		<cfargument name="filename" type="string" required="true" />
		<cfargument name="newfilename" type="string" required="false" />
		<cfargument name="options" type="struct" required="false" />
		<cfscript>
			throw( type="custom", message="Not implemented in the base class." );
		</cfscript>
	
	</cffunction>

	<cffunction name="setThumbnailPath" access="public" returntype="void">
		<cfargument name="path" type="string" required="true" />
		<cfset variables.instance.thumbnailPath = arguments.path />
	</cffunction>
 
	<cffunction name="getThumbnailPath" access="public" returntype="string">
		<cfreturn variables.instance.thumbnailPath />
	</cffunction>

	<cffunction name="setOS" access="public" returntype="void">
		<cfargument name="os" type="string" required="true" />
		<cfset variables.instance.os = arguments.path />
	</cffunction>
 
	<cffunction name="getOS" access="public" returntype="string">
		<cfreturn variables.instance.os />
	</cffunction>

	<cffunction name="setcfServer" access="public" returntype="void">
		<cfargument name="cfserver" type="string" required="true" />
		<cfset variables.instance.cfserver = arguments.cfserver />
	</cffunction>
 
	<cffunction name="getcfServer" access="public" returntype="string">
		<cfreturn variables.instance.cfserver />
	</cffunction>	
		
</cfcomponent>

