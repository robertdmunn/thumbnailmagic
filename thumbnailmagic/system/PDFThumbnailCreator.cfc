component extends="thumbnailmagic.system.BaseThumbnailCreator" {

	public thumbnailmagic.system.PDFThumbnailCreator function init( required string thumbnailPath, required string os, required string cfServer ){
		super.init( argumentcollection = arguments );
		return this;
	}

	public array function createThumbnail( required string filepath, required string filename, string newfilename, struct options ){

		if( right( arguments.filename, 4 ) eq ".pdf" ){
			local.basefileName = left( arguments.filename, len( arguments.filename ) - 4 );
		}else{
			local.basefileName = arguments.filename;
		}

		//default options
		local.scale = 50;
		local.pages = 1;
		local.overwrite = true;

		if( not isNull( arguments.options ) ){
			for( local.key in arguments.options ){
				local[ key ] =  arguments.options[ key ]; 
			} 
		}
		// courtesy J Harvey http://webdevsourcerer.com/index.cfm/blog/post/slug/tutorial-detecting-coldfusion-railo-or-bluedragon-with-cfscript
		//mods to simplify
		//SetupObject = createObject('component','#request.master.cfcPath#.Setup'); if (server.ColdFusion.ProductName CONTAINS "Railo"){ request.cf_server = "Railo"; request.server_version = listFirst(server.railo.version); } else if (server.ColdFusion.ProductName CONTAINS "BlueDragon") { request.cf_server = "BlueDragon"; request.server_version = server.coldfusion.productversion; } else if (server.ColdFusion.ProductName CONTAINS "ColdFusion") { request.cf_server = "ColdFusion"; request.server_version = server.coldfusion.productversion; } 


		//dynamic method injection
		local.create = variables["_createThumbnail#getcfServer()#"];
		local.create( destination=getThumbnailPath(), source=arguments.filepath & arguments.filename, scale=local.scale, pages=local.pages, overwrite=local.overwrite );

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
	}

	private void function _createThumbnailACF( required string destination, required string source, required numeric scale, required string pages, required boolean overwrite ){
		
		local.pdfService =  new pdf(); 
		pdfService.setSource( arguments.source ); 
		pdfService.thumbnail( destination = arguments.destination, scale = arguments.scale, pages = arguments.pages, overwrite=arguments.overwrite );
	}
	
	private void function _createThumbnailRailo( required string destination, required string source, required numeric scale, required string pages, required boolean overwrite ){
		
		pdf action="thumbnail" destination="#arguments.destination#" source="#arguments.source#" scale="#arguments.scale#" pages="#arguments.pages#" overwrite="#arguments.overwrite#"{};
	}


}

