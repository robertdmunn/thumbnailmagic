<cfcomponent displayname="ooLib" hint="Object for interacting with OpenOffice.">
	<cffunction name="init" access="public" returntype="oolib">
		<cfargument name="pathToOO" required="false" hint="Path to soffice binary" />
		<cfargument name="OOHost" required="false" default="localhost" hint="OpenOffice host server"/>
		<cfargument name="OOPort" required="false" default="8100" hint="OpenOffice host port"/>
		<cfscript>
			_setOS();
			local.pathToOO = ( isNull( arguments.pathToOO ) ? "" : arguments.pathToOO );
			_setPathToOO( path = local.pathToOO );
			_setOOHost( oohost = arguments.OOHost );
			_setOOPort( ooport = arguments.OOPort );
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
			// Create needed Java Objects 
			local.jodDocumentConverter = createObject( "java", "com.artofsolving.jodconverter.openoffice.converter.OpenOfficeDocumentConverter" );
			local.jodOpenOfficeConnection = createObject( "java", "com.artofsolving.jodconverter.openoffice.connection.SocketOpenOfficeConnection" );
			local.jodFile = createObject( "java", "java.io.File" );
			//Set up input files
			local.inputFile = local.jodFile.init( arguments.srcfile );
			local.outputFile = local.jodFile.init( arguments.filename );
			// Initialize the connection object
			local.jodOpenOfficeConnection.init( _getOOHost(), _getOOPort );
		</cfscript>
	
		<cftry>
			<cfset jodOpenOfficeConnection.connect() />
			<cfcatch type="any"> <!--- If the initial connect fails, start the service and try again --->
				<cfset local.args = '-headless -nofirststartwizard -accept="socket,host=#_getOOHost()#,port=#_getOOPort()#;urp;StarOffice.Service"' />
				<cfexecute name="#_getPathToOO()#" arguments="#local.args#" />
				<cfset local.jodOpenOfficeConnection.connect() />
			</cfcatch>
		</cftry>
		
		<cfscript>
			local.success = local.jodOpenOfficeConnection.isConnected();
			if( local.success EQ "YES" ){
				local.jodDocumentConverter.init( local.jodOpenOfficeConnection );
				local.jodDocumentConverter.convert(local.inputFile, local.outputFile);
				local.disconn = local.jodOpenOfficeConnection.disconnect();
				local.results.converted = 1;
				local.results.filename = listLast( arguments.fileName, "\" );
				local.results.fullpath = arguments.filename;
			}else{	 
				local.disconn = local.jodOpenOfficeConnection.disconnect();
				local.results.converted = 0;
				local.errorMessage = "Unable to establish a connection to OpenOffice.";
				results.filename = "";
				results.fullpath = "";
			}
			return local.results;
		</cfscript>

	</cffunction>
	
	<cffunction name="_setPathToOO" access="private" returntype="void">
		<cfargument name="path" type="string" required="false" />
		<cfif not isNull( arguments.path )>
			<cfset variables.instance.pathToOO = arguments.path />
		<cfelse>
			<!--- set default based on OS --->
			<cfif server.os.name contains "Windows">
				<cfset variables.instance.pathToOO = "C:\Program Files (x86)\OpenOffice.org 3\program\soffice.exe"/>
			<cfelseif server.os.name contains "OS X">
				<cfset variables.instance.pathToOO = "/Applications/OpenOffice.app/Contents/MacOS/soffice"/>
			</cfif>
		</cfif>
	</cffunction>

	<cffunction name="_getPathToOO" access="private" returntype="string">
		<cfreturn variables.instance.pathToOO />
	</cffunction>	
	
	<cffunction name="_setOS" access="private" returntype="void">
		<cflock name="server_os" type="readonly" timeout="10">
			<cfset variables.instance.os = server.os.name />
		</cflock>
	</cffunction>
	
	<cffunction name="_getOS" access="private" returntype="string">
		<cfreturn variables.instance.os />
	</cffunction>
	
	<cffunction name="_setOOHost" access="private" returntype="void">
		<cfargument name="oohost" type="string" required="true" />
		<cfset variables.instance.oohost = arguments.oohost />

	</cffunction>
	
	<cffunction name="_getOOHost" access="private" returntype="string">
		<cfreturn variables.instance.ooohosts />
	</cffunction>
	
	<cffunction name="_setOOPort" access="private" returntype="void">
		<cfargument name="ooport" type="string" required="true" />
			<cfset variables.instance.ooport = arguments.ooport />
	</cffunction>
	
	<cffunction name="_getOOPort" access="private" returntype="string">
		<cfreturn variables.instance.ooport />
	</cffunction>			
</cfcomponent>