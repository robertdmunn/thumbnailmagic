<cfcomponent displayname="ooLib" hint="Object for interacting with OpenOffice.">
	<cffunction name="convertDocument">
		<cfargument name="srcfile" required="true" hint="Full expanded path to the source file." />
		<cfargument name="filename" required="true" hint="Full expanded path of the destination file." />
		<cfargument name="overwrite" required="false" default="false" hint="Whether or not to overwrite the destination filename. (Default false)" />
		<cfargument name="format" required="false" default="pdf" hint="Currently PDF is the only valid format." />
		<cfargument name="pathToOO" required="false" hint="Path to soffice.exe file" />
		
		<cfset _setOS()/>
		<cfif isNull( arguments.pathToOO )>
			<cfset _setPathToOO() />
		</cfif>

		<cfset var results = structNew() />
		<!--- check for file existing, and return error if it exists --->
		<cfif NOT arguments.overwrite and fileExists(filename)>
			<cfset results.converted = 0 />
			<cfset results.errorMessage = "The file you attempted to create already exists." />
			<cfset results.filename = "" />
			<cfset results.fullpath = "" />
			<cfreturn results />
		</cfif>
		<!--- Create needed Java Objects --->
		<cfobject type="java" class="com.artofsolving.jodconverter.openoffice.converter.OpenOfficeDocumentConverter" name="jodDocumentConverter">
		<cfobject type="java" class="com.artofsolving.jodconverter.openoffice.connection.SocketOpenOfficeConnection" name="jodOpenOfficeConnection">
		<cfobject type="java" class="java.io.File" name="jodFile">
		<!--- Set up input files --->
		<cfset inputFile = jodFile.init("#arguments.srcfile#")>
		<cfset outputFile = jodFile.init("#arguments.filename#")> 
		<!--- Initialize the connection object.  If you are using a remote OO server, change it here and in the ARGS below. --->
		<cfset jodOpenOfficeConnection.init("localhost", 8100)>
		<cftry>
			<cfset jodOpenOfficeConnection.connect()>
			<cfcatch type="any"> <!--- If the initial connect fails, start the service and try again --->
				<cfset args = '-headless -nofirststartwizard -accept="socket,host=localhost,port=8100;urp;StarOffice.Service"'>
				<cfexecute name="#_getPathToOO()#" arguments="#args#" />
				<cfset jodOpenOfficeConnection.connect()>
			</cfcatch>
		</cftry>
		<cfset success = jodOpenOfficeConnection.isConnected()>

		<cfif success EQ "YES"><!--- If we connected successfully, continue --->
  			<cfset jodDocumentConverter.init(jodOpenOfficeConnection)>
  			<cfset jodDocumentConverter.convert(inputFile, outputFile)><!--- This does the actual conversion --->
			<cfset disconn = jodOpenOfficeConnection.disconnect()>
			<cfset results.converted = 1 />
			<cfset results.filename = listLast(arguments.fileName,"\") />
			<cfset results.fullpath = arguments.filename />
		<cfelse>
			<cfset disconn = jodOpenOfficeConnection.disconnect()>			
			<cfset results.converted = 0 />
			<cfset errorMessage = "Unable to establish a connection to OpenOffice." />
			<cfset results.filename = "" />
			<cfset results.fullpath = "" />
		</cfif>
		<cfreturn results />		
	</cffunction>
	
	<cffunction name="_setPathToOO" access="private" returntype="void">
		<cfif server.os.name contains "Windows">
			<cfset variables.instance.pathToOO = "C:\Program Files (x86)\OpenOffice.org 3\program\soffice.exe"/>
		<cfelseif server.os.name contains "OS X">
			<cfset variables.instance.pathToOO = "/Applications/OpenOffice.app/Contents/MacOS/soffice"/>
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
</cfcomponent>