Project: OpenOffice Word/Excel to PDF Conversion CFC
Author: Michael Sprague (mike@brockettcreative.com)
License: It's free.  Do whatever you want with it.

DESCRIPTION

This component introduces Word/Excel conversion to PDF to CFML engines that do not natively support it.  It was written and tested for Railo, but should run on ColdFusion 7 or 8 and BlueDragon.  If you have ColdFusion 9, this functionality is already built into CF and you don't need this.

PREREQUISITES

1. This was written and tested for a Windows server.  It should work on Linux/Mac, but paths to OpenOffice will need to be adjusted.
2. OpenOffice must be installed on the server.  This was tested with OpenOffice 3.3.
3. You will need the JODconverter 2.2 Jar files in your CFML engine's class path.  I've listed the default classpaths below, but you can also use an alternate path and add it to the JVM classpath for your installation.  YOU WILL NEED TO RESTART YOUR CFML ENGINE BEFORE IT WILL WORK.
	JODconverter 2.2 can be downloaded from here: http://www.artofsolving.com/opensource/jodconverter
	* You only need the JAR files in the lib folder.  I've also included a zipped copy of the JARs with this download.
     3a. For Railo, you can drop the files at: {installation}\lib   (for example, c:\railo\lib\)
     3b. For ColdFusion Single-Instance, you can drop them at: {installation}\lib
     3c. For ColdFusion Multi-instance (Enterprise), you can drop them at: {drive:}\JRun4\servers\<instance name>\cfusion-ear\cfusion-war\WEB-INF\lib
     3d. If anyone wants to provide the BlueDragon path, e-mail it to me.

INSTRUCTIONS

- Instantiate the oolib.cfc object
- Call convertDocument and pass in the source and destination.

EXAMPLE  (see convert.cfm)
<!--- Create the Object --->
<cfset ooLib = createObject('component','oolib') />
<!--- Perform the Conversion --->
<cfset ooResults = ooLib.convertDocument(expandpath('WordDocument.docx'),expandpath('PdfDocument.pdf'),true)>
<!--- Check for success, and link to results --->
<cfif ooResults.converted>
	<cfoutput>SUCCESS <a href="#ooResults.filename#">VIEW PDF</a></cfoutput>
<cfelse>
	<cfoutput>ERROR: #ooResults.errorMessage#</cfoutput>
</cfif>
