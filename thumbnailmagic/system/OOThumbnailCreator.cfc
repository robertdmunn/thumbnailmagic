<cfcomponent extends="thumbnailmagic.system.BaseThumbnailCreator">


	<cffunction name="init" access="public" returntype="thumbnailmagic.system.OOThumbnailCreator">
		<cfargument name="globals" type="thumbnailmagic.system.Globals" required="true" />
		<!--- these arguments are being passed by ThumbnailService as a struct called options but are not named --->

		<cfscript>
			super.init( argumentcollection = arguments );
			_setOOLib( argumentcollection = arguments.options );
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
			local.pages = 1;
			local.overwrite = "overwrite";
			if( not isNull( arguments.options ) )
				structAppend( local, setOptions( arguments.options ) );

			local.filename = _verifyFilename( filepath = arguments.filepath, filename = local.filename, overwrite = local.overwrite );

			local.overwrite = ( local.overwrite eq "overwrite" ? true : false );

			//if( local.pages eq 1 ){
				// just extract the thumbnail from the document
			return _extractThumbnail( filepath = arguments.filepath, filename = arguments.filename, outputfilename = local.filename );
			/*	}else{

			}	*/
		</cfscript>
	</cffunction>

	<cffunction name="convert" access="public" returntype="string">
		<cfargument name="filepath" type="string" required="true" />
		<cfargument name="filename" type="string" required="true" />
		<cfargument name="overwrite" type="boolean" required="true" />

		<cfset local.results = _getooLib().convertDocument( arguments.filepath & arguments.filename, getGlobals().getThumbnailPath() & arguments.filename & ".pdf", arguments.overwrite ) />

		<cfreturn local.results.filename />
	</cffunction>

	<cffunction name="_extractThumbnail" access="private" returntype="array">
		<cfargument name="filepath" type="string" required="true" />
		<cfargument name="filename" type="string" required="true" />
		<cfargument name="outputfilename" type="string" required="true" />

		<cfzip file="#arguments.filepath##arguments.filename#" action="readBinary"
    		entryPath="Thumbnails/thumbnail.png" variable="local.results">

		<cffile action="write" file="#getGlobals().getThumbnailPath()##arguments.outputfilename#.png" output="#local.results#"/>

		<cfreturn ["#arguments.outputfilename#.png"] />
	</cffunction>

	<cffunction name="_setOOLib" access="private" returntype="void">
		<cfargument name="ooPath" required="false" hint="Path to soffice binary" />
		<cfargument name="ooHost" required="false" default="localhost" hint="OpenOffice host server"/>
		<cfargument name="ooPort" required="false" default="8100" hint="OpenOffice host port"/>
		<cfset variables.instance.oolib = createObject( 'thumbnailmagic.system.oolib' ).init( ooPath = arguments.ooPath, ooHost = arguments.ooHost, ooPort = arguments.ooPort ) />
	</cffunction>

	<cffunction name="_getOOLib" access="private" returntype="thumbnailmagic.system.oolib">
		<cfreturn variables.instance.oolib />
	</cffunction>
</cfcomponent>
