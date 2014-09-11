component{

	public thumbnailmagic.system.BaseThumbnailCreator function init( required string thumbnailPath, required string os, required string cfServer ){
		variables.instance = {};
		setThumbnailPath( arguments.thumbnailPath );
		setOS( arguments.os );
		setcfServer( arguments.cfServer );
		return this;
	}

	public array function createThumbnail( required string filepath, required string filename, string newfilename, struct options ){
		throw( type="custom", message="Not implemented in the base class." );
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
		
}

