component {

	/*
	 * ThumbnailMagic 
	 * 
	 * copyright 2014 Robert Munn
	 * 
	 * version: 0.9.1
	 * 
	 * author: Robert Munn robert.d.munn@gmail.com
	 * 
	 * license: MIT license
	 * 
	 **/

	public thumbnailmagic.ThumbnailService function init( string thumbnailPath, struct options default = {} ){
		variables.instance = {};

		setGlobals( createObject( "thumbnailmagic.system.Globals" ).init( thumbnailPath = arguments.thumbnailPath ) );
		setPDFCreator();
		setHTTPUtil();
		_setCreators( options = arguments.options );
		
		return this;
	}

	public array function createThumbnail( string filepath, string filename, string uri, struct options ){
		//Javaloader is causing a Xerces conflict in the Tika library, so Tika must be copied to the CFML server lib path for now
		//local.file = createObject( "java", "java.lang.String" ).init( arguments.filepath & arguments.filename );
		//local.path = createObject( "java", "java.nio.file.Paths" ).get( arguments.filepath, [arguments.filename] );
		//local.Files = createObject( "java", "java.nio.file.Files" );
		//local.paths = [];
		//local.paths[2] = expandPath( "/thumbnailmagic/lib/tika-app-1.6.jar" );
		//local.paths[1] = expandPath( "/thumbnailmagic/lib/xerces.jar" );
		//local.paths[3] = expandPath( "/thumbnailmagic/lib/apache-xml-xalan.jar" );
		//local.loader = createObject("component", "javaloader.JavaLoader").init( local.paths );
		//local.Tika = local.loader.create( "org.apache.tika.Tika" ).init();/
		
		local.args = {};
		// OO doc option
		local.args.extract = true;

		if( not isNull( arguments.options ) )
			structAppend( local.args, setOptions( arguments.options ) );	
					
		//flag to use 
		if( not isNull( arguments.uri ) ){
			local.contentType = "uri";
			local.args.filepath = getGlobals().getThumbnailPath();
		}else{
			local.contentType = _getContentType( filepath = arguments.filepath, filename = arguments.filename );
			local.args.filepath = arguments.filepath;
		}

		local.thumbnailcreator = getCreator( creatorType = "image" );
 
		switch( trim( local.contentType ) ){
			case "image/gif":
			case "image/png":
			case "image/jpg":
			case "image/jpeg":
			case "image/tiff":
			case "image/x-tiff":
				local.filename = [ arguments.filename ];
				break;
			case "uri":
				local.filename = getHTTPUtil().createThumbnail( arguments.uri );
				break;
			case "text/plain":
			case "text/html":
			case "text/css":
			case "text/csv":
			case "text/xml":
			case "application/xml":
				// make a pdf and continue on to thumbnail the pdf
				//if we're using a uri we already have the source
				if( isNull( local.source ) ) local.source = fileRead( arguments.filepath & arguments.filename );
				arguments.filename = getPDFCreator().createPDF( source = local.source, contenttype = local.contentType );
				local.tempfile = arguments.filename;
				arguments.filepath = getGlobals().getThumbnailPath();
				
			case "application/pdf":
				local.creator =  getCreator( creatorType = "PDF" );
				local.args.filepath = getGlobals().getThumbnailPath();
				local.filename = local.creator.createThumbnail( argumentcollection = arguments );
				break;
			case "application/vnd.oasis.opendocument.chart":
			case "application/vnd.oasis.opendocument.formula":
			case "application/vnd.oasis.opendocument.graphics":
			case "application/vnd.oasis.opendocument.image":
			case "application/vnd.oasis.opendocument.presentation":
			case "application/vnd.oasis.opendocument.spreadsheet":
			case "application/vnd.oasis.opendocument.text":
				if( local.args.extract ) {
					local.creator =  getCreator( creatorType = "oo" );
					return local.creator.createThumbnail( argumentcollection = arguments );
					break;
				}
			case "application/msword":
			case "application/vnd.openxmlformats-officedocument.wordprocessingml.document":
			case "application/vnd.ms-excel":
				local.creator =  getCreator( creatorType = "oo" );
				// we need to generate a pdf to make thumbnails
				local.overwrite = true;
				if( NOT isNull( arguments.options.overwrite ) )
					local.overwrite = ( local.overwrite eq "overwrite" ? true : false );	
				arguments.filename = listlast( local.creator.convert( filepath = arguments.filepath, filename = arguments.filename, overwrite = local.overwrite ), "\/" );
				arguments.filepath = getGlobals().getThumbnailPath();
				// re-call the function sending in the pdf as the argument

				local.results = createThumbnail( argumentcollection = arguments );
				fileDelete( arguments.filepath & arguments.filename );
				return local.results;
				break;	
			case "video/mp4":
			case "video/avi":
			case "video/mov":
			case "video/flv":
			case "video/mpg":
			case "video/mpeg":
			case "video/ogg":
				local.creator =  getCreator( creatorType = "video" );
				local.args.filepath = getGlobals().getThumbnailPath();
				local.filename = local.creator.createThumbnail( argumentcollection = arguments );
				break;			

			default:
				if( isNull( local.contentType ) ){
					throw( message = "Content type not detected." );
				}else{
					throw( message = "Content type #local.contentType# not supported." );
				}

				break;
		}
		try{

			local.results = [];
			for( local.i = 1; local.i lte arraylen( local.filename ); local.i++ ){
				local.args.filename = local.filename[ local.i ];
				local.results[ local.i ] = local.thumbnailcreator.createThumbnail( argumentcollection = local.args )[1];							
			}
			
			//clean up temp files
			if( not isNull( local.tempfile ) ){
				fileDelete( getGlobals().getThumbnailPath() & local.tempfile );
			}
			
			return local.results;
		}catch( e ){
			writeoutput( local.contentType & "<br/><br/> " & e.message & e.detail );
		}
	}

	public void function setGlobals( required thumbnailmagic.system.Globals globals ){
		variables.instance.globals = arguments.globals;
	}

	public thumbnailmagic.system.Globals function getGlobals(){
		return variables.instance.globals;
	}	

	public void function setPDFCreator(){
		variables.instance.PDFCreator = createObject( "thumbnailmagic.system.PDFCreator" ).init( globals = getGlobals() );
	}

	public thumbnailmagic.system.PDFCreator function getPDFCreator(){
		return variables.instance.PDFCreator;
	}
	
	public thumbnailmagic.system.HTTPUtil function getHTTPUtil(){
		return variables.instance.HTTPUtil;
	}	

	public void function setHTTPUtil(){
		variables.instance.HTTPUtil = createObject( "thumbnailmagic.system.HTTPUtil" ).init( globals = getGlobals() );
	}

	private void function _setCreators( struct options ){
		variables.instance.creator = {
			video : createObject( "thumbnailmagic.system.VideoThumbnailCreator" ).init( globals = getGlobals() ),
			image : createObject( "thumbnailmagic.system.ImageThumbnailCreator" ).init( globals = getGlobals()  ),
			oo : createObject( "thumbnailmagic.system.OOThumbnailCreator" ).init( globals = getGlobals(), options = arguments.options ),
			pdf : createObject( "thumbnailmagic.system.PDFThumbnailCreator" ).init( globals = getGlobals()  )
		};
	}

	public any function getCreator( string creatorType ){
		return variables.instance.creator[ creatorType ];
	}

	private string function _getContentType( required string filepath, required string filename ){
		//probeContentType is broken in OS X
		if( getGlobals().getOS() eq "Mac OS X" ){
			local.Tika = createObject( "java", "org.apache.tika.Tika" ).init();
			local.contentType = local.Tika.detect( arguments.filepath & arguments.filename );
		}else{
			local.path = createObject( "java", "java.nio.file.Paths" ).get( arguments.filepath, [arguments.filename] );
			local.Files = createObject( "java", "java.nio.file.Files" );
			local.contentType = local.Files.probeContentType( local.path );	
		}
		return local.contentType;
	}

	private struct function setOptions( required struct options ){
		local.options = {};
		if( not isNull( arguments.options ) ){
			for( local.key in arguments.options ){
				local.options[ local.key ] =  arguments.options[ local.key ]; 
			}
		}
		return local.options;
	}	
}