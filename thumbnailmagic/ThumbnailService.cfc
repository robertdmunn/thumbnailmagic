component {

	public thumbnailmagic.ThumbnailService function init(){
		variables.instance = {};
		setThumbnailPath( arguments.thumbnailPath );
		setOS( server.os.name );

		if (server.ColdFusion.ProductName CONTAINS "Railo"){ 
			local.cf_server = "Railo";
		} else if (server.ColdFusion.ProductName CONTAINS "BlueDragon") { 
			local.cf_server = "BlueDragon"; 
		} else if (server.ColdFusion.ProductName CONTAINS "ColdFusion") { 
			local.cf_server = "ACF"; 
		} 

		setcfServer( local.cf_server );
		_setCreators( thumbnailPath = getThumbnailPath(), os = getOS(), cfserver = getcfServer() );
		
		return this;
	}

	public array function createThumbnail( required string filepath, required string filename, numeric height, numeric width ){
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

		local.contentType = _getContentType( filepath = arguments.filepath, filename = arguments.filename );
		local.args = {};
		local.args.filepath = arguments.filepath;
		local.args.height = arguments.height;
		local.args.width = arguments.width;
			
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

			case "application/pdf":
				local.creator =  getCreator( creatorType = "PDF" );
				local.args.filepath = getThumbnailPath();
				local.filename = local.creator.createThumbnail( argumentcollection = arguments );
				break;

			case "video/mp4":
			case "video/avi":
			case "video/mov":
			case "video/flv":
			case "video/mpg":
			case "video/mpeg":
			case "video/ogg":
				local.creator =  getCreator( creatorType = "video" );
				local.args.filepath = getThumbnailPath();
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
			return local.results;
		}catch( e ){
			writeoutput( local.contentType & "<br/><br/> " & e.message & e.detail );
		}
	}

	public void function setThumbnailPath( path ){
		variables.instance.thumbnailPath = arguments.path;
	}

	public string function getThumbnailPath(){
		return variables.instance.thumbnailPath;
	}

	public void function setOS( os ){
		variables.instance.os = arguments.os;
	}

	public string function getOS(){
		return variables.instance.os;
	}	

	public void function setcfServer( cfserver ){
		variables.instance.cfserver = arguments.cfserver;
	}

	public string function getcfServer(){
		return variables.instance.cfserver;
	}		
	
	private void function _setCreators( required string thumbnailPath, required string os, required string cfServer ){
		variables.instance.creator = {
			video : createObject( "thumbnailmagic.system.VideoThumbnailCreator" ).init( thumbnailPath = getThumbnailPath(), os = getOS(), cfserver = getcfServer() ),
			image : createObject( "thumbnailmagic.system.ImageThumbnailCreator" ).init( thumbnailPath = getThumbnailPath(), os = getOS(), cfserver = getcfServer() ),
			pdf : createObject( "thumbnailmagic.system.PDFThumbnailCreator" ).init( thumbnailPath = getThumbnailPath(), os = getOS(), cfserver = getcfServer() )
		};
	}
	
	public any function getCreator( string creatorType ){
		return variables.instance.creator[ creatorType ];
	}
	
	private string function _getContentType( required string filepath, required string filename ){
		//probeContentType is broken in OS X
		if( getOS() eq "Mac OS X" ){
			local.Tika = createObject( "java", "org.apache.tika.Tika" ).init();
			local.contentType = local.Tika.detect( arguments.filepath & arguments.filename );
		}else{
			local.path = createObject( "java", "java.nio.file.Paths" ).get( arguments.filepath, [arguments.filename] );
			local.Files = createObject( "java", "java.nio.file.Files" );
			local.contentType = local.Files.probeContentType( local.path );	
		}
		return local.contentType;
	}
}