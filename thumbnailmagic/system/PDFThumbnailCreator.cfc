<cfcomponent extends="thumbnailmagic.system.BaseThumbnailCreator">

	<cffunction name="init" access="public" returntype="thumbnailmagic.system.PDFThumbnailCreator">
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
			//default options
			local.scale = 30;
			local.pages = 1;
			local.overwrite = "overwrite";
	
			if( not isNull( arguments.options ) )
				structAppend( local, setOptions( arguments.options ) );		

			if( right( arguments.filename, 4 ) eq ".pdf" ){
				local.basefileName = left( arguments.filename, len( arguments.filename ) - 4 );
			}else{
				local.basefileName = arguments.filename;
			}
			
			local.overwrite = ( local.overwrite eq "overwrite" ? true : false );
		</cfscript>
		
		<!---  once vendor support for cfpdf, cfexecute, etc. in cfscript is normalized we can convert the components to script, but for now we need tags to simplify the code --->
		<cfpdf action="thumbnail" destination="#getGlobals().getThumbnailPath()#" source="#arguments.filepath##arguments.filename#" scale="#local.scale#" pages="#local.pages#" overwrite="#local.overwrite#"/>
		
		<cfscript>
			
			local.results = [];
			local.pagesArr = listtoArray( local.pages );
			local.idx = 1;
			for( local.i = 1; local.i lte arraylen( local.pagesArr ); local.i++ ){
				local.page = trim( local.pagesArr[ local.i ] );
				if( isNumeric( local.page ) ){
					local.results[ local.idx ] = local.basefileName & "_page_" & local.page & ".jpg";
					local.idx++;
				}else{
					//range of pages
					local.start = getToken( local.page, 1, "-" );
					local.end = getToken( local.page, 2, "-" );
					for( local.j = local.start; local.j lte local.end; local.j++ ){
						local.results[ local.idx ] = local.basefileName & "_page_" & local.j & ".jpg";
						local.idx++;
					}
				}
			}
			
			return local.results;		
		</cfscript>
			
	</cffunction>
</cfcomponent>
