<cfcomponent extends="thumbnailmagic.system.BaseThumbnailCreator">


	<cffunction name="init" access="public" returntype="thumbnailmagic.system.OOThumbnailCreator">
		<cfargument name="globals" type="thumbnailmagic.system.Globals" required="true" />
		
		<cfscript>
			super.init( argumentcollection = arguments );

			return this;
		</cfscript>
	</cffunction>

	<cffunction name="createThumbnail" access="public" returntype="array">
		<cfargument name="filepath" type="string" required="true" />
		<cfargument name="filename" type="string" required="true" />
		<cfargument name="options" type="struct" required="false" />
		
		<cfscript>
			//base options
			local.filename = arguments.filename;
						
			if( not isNull( arguments.options ) )
				structAppend( local, setOptions( arguments.options ) );

			local.filename = _verifyFilename( filepath = arguments.filepath, filename = local.filename, overwrite = local.overwrite );
		</cfscript>
		
		
		<cfzip file="#arguments.filepath##arguments.filename#" action="readBinary" 
    		entryPath="Thumbnails/thumbnail.png" variable="local.results">
	
		<cffile action="write" file="#getGlobals().getThumbnailPath()##local.filename#.png" output="#local.results#"/>

		<cfreturn ["#local.filename#.png"] />
	</cffunction>
</cfcomponent>
