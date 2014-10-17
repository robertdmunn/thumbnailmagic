<cfcomponent displayname="ooLib" hint="Object for interacting with OpenOffice.">
	<cffunction name="init" access="public" returntype="oolib">
		<cfargument name="ooPath" required="false" hint="Path to Open Office" />
		<cfargument name="ooHost" required="false" default="localhost" hint="OpenOffice host server"/>
		<cfargument name="ooPort" required="false" default="2002" hint="OpenOffice host port"/>
		<cfscript>
			_setOS();

			if( isNull( arguments.ooPath ) ){
				_setooPath();
			}else{
				_setooPath( arguments.ooPath );
			}

			_setooHost( oohost = arguments.ooHost );
			_setooPort( ooport = arguments.ooPort );

			variables.jodOfficeManager  = createObject( "java", "org.artofsolving.jodconverter.office.DefaultOfficeManagerConfiguration" )
				.setOfficeHome( _getooPath() )
				.setPortNumber( _getooPort() )
				.buildOfficeManager();
			variables.jodOfficeManager.start();
			variables.jodDocumentConverter = createObject( "java", "org.artofsolving.jodconverter.OfficeDocumentConverter" ).init( variables.jodOfficeManager );
			return this;
		</cfscript>
	</cffunction>

	<cffunction name="convertDocument">
		<cfargument name="srcfile" required="true" hint="Full expanded path to the source file." />
		<cfargument name="filename" required="true" hint="Full expanded path of the destination file." />
		<cfargument name="overwrite" required="false" default="false" hint="Whether or not to overwrite the destination filename. (Default false)" />
		<cfargument name="format" required="false" default="pdf" hint="Currently PDF is the only valid format." />

		<cfscript>
			local.results = structNew();
			//	check for file existing, and return error if it exists

			if( NOT arguments.overwrite and fileExists( arguments.filename ) ){
				local.results.converted = 0;
				local.results.errorMessage = "The file you attempted to create already exists.";
				local.results.filename = "";
				local.results.fullpath = "";
				return local.results;
			}
			local.jodFile = createObject( "java", "java.io.File" );
			//Set up input files
			local.inputFile = local.jodFile.init( arguments.srcfile );
			local.outputFile = local.jodFile.init( arguments.filename );

			variables.jodDocumentConverter.convert(local.inputFile, local.outputFile);
			//local.disconn = local.jodOpenOfficeConnection.disconnect();
			local.results.converted = 1;
			local.results.filename = listLast( arguments.fileName, "\" );
			local.results.fullpath = arguments.filename;

			return local.results;
		</cfscript>

	</cffunction>

	<cffunction name="_setooPath" access="private" returntype="void">
		<cfargument name="path" type="string" required="false" />
		<cfif not isNull( arguments.path )>
			<cfset variables.instance.ooPath = arguments.path />
		<cfelse>
			<!--- set default based on OS --->
			<cfif server.os.name contains "Windows">
				<cfset variables.instance.ooPath = "C:\Program Files (x86)\OpenOffice.org 3\program\soffice.exe"/>
			<cfelseif server.os.name contains "OS X">
				<cfset variables.instance.ooPath = "/Applications/OpenOffice.app/Contents"/>
			</cfif>
		</cfif>
	</cffunction>

	<cffunction name="_getooPath" access="private" returntype="string">
		<cfreturn variables.instance.ooPath />
	</cffunction>

	<cffunction name="_setOS" access="private" returntype="void">
		<cflock name="server_os" type="readonly" timeout="10">
			<cfset variables.instance.os = server.os.name />
		</cflock>
	</cffunction>

	<cffunction name="_getOS" access="private" returntype="string">
		<cfreturn variables.instance.os />
	</cffunction>

	<cffunction name="_setooHost" access="private" returntype="void">
		<cfargument name="oohost" type="string" required="true" />
		<cfset variables.instance.oohost = arguments.oohost />

	</cffunction>

	<cffunction name="_getooHost" access="private" returntype="string">
		<cfreturn variables.instance.oohost />
	</cffunction>

	<cffunction name="_setooPort" access="private" returntype="void">
		<cfargument name="ooport" type="string" required="true" />
			<cfset variables.instance.ooport = arguments.ooport />
	</cffunction>

	<cffunction name="_getooPort" access="private" returntype="string">
		<cfreturn variables.instance.ooport />
	</cffunction>
</cfcomponent>