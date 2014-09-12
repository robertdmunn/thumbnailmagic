<cfcomponent extends="thumbnailmagic.system.BaseThumbnailCreator">


	<cffunction name="init" access="public" returntype="thumbnailmagic.system.VideoThumbnailCreator">
		<cfargument name="globals" type="thumbnailmagic.system.Globals" required="true" />
		
		<cfscript>
			super.init( argumentcollection = arguments );
			_setffmpeg();
			return this;
		</cfscript>
	</cffunction>

	<cffunction name="createThumbnail" access="public" returntype="array">
		<cfargument name="filepath" type="string" required="true" />
		<cfargument name="filename" type="string" required="true" />
		<cfargument name="newfilename" type="string" required="false" />
		<cfargument name="options" type="struct" required="false" />
		
		<cfscript>
			//base options
			local.rate = 1;
			local.frames = 1;
			local.start = "00:01:00";
			local.timeout = 60;
			if( not isNull( arguments.options ) )
				structAppend( local, setOptions( arguments.options ) );
		
		</cfscript>
		<cfexecute
			name="#_getffmpeg()#"
			arguments="-i #arguments.filepath##arguments.filename# -r #local.rate# -vframes #local.frames# -ss #local.start# #getGlobals().getThumbnailpath()##arguments.filename#-%d.jpg"
			timeout="#local.timeout#"
			errorVariable="errorOut" />
		<cfscript>

			local.results = [];
			for( local.i = 1; local.i lte local.frames; local.i++ ){
				local.results[ local.i ] = arguments.filename & "-" & local.i & ".jpg";
			}
			return local.results;
		</cfscript>

	</cffunction>

	<cffunction name="_setffmpeg" access="private" returntype="void">
		<cfscript>
			if( getGlobals().getOS() contains "Windows" ){
				variables.instance.ffmpeg = "ffmpeg.exe";
			}else{
				variables.instance.ffmpeg = "ffmpeg";
			}
		</cfscript>
	</cffunction>
 
	<cffunction name="_getffmpeg" access="private" returntype="string">
		<cfreturn variables.instance.ffmpeg />
	</cffunction>	

</cfcomponent>



