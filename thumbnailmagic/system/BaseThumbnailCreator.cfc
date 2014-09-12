component {

	public thumbnailmagic.system.BaseThumbnailCreator function init( thumbnailmagic.system.Globals globals ){
		variables.instance = {};
		setGlobals( arguments.globals );
		return this;
	}

	public array function createThumbnail( required string filepath, required string filename, struct options ){
		throw( type="custom", message="Not implemented in the base class." );
	}
	
	public void function setGlobals( required thumbnailmagic.system.Globals globals ){
		variables.instance.globals = arguments.globals;
	}
	
	public thumbnailmagic.system.Globals function getGlobals(){
		return variables.instance.globals;
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
	
	private string function _verifyFilename( required string filepath, required string filename, required string overwrite ){
		
		if( arguments.overwrite eq "overwrite" ){
			return arguments.filename;		
		}else if( arguments.overwrite eq "rename" and fileExists( arguments.filepath & arguments.filename ) ){
			while( arguments.ok eq false ){
				local.filename = arguments.filename & local.i;
				if( NOT fileExists( local.filename )){
					local.ok = true;
				}else{
					local.i++;
				}
			}
			return local.filename;
		}else if( arguments.overwrite eq "error"  and fileExists( arguments.filepath & arguments.filename ) ){
			throw( message="Thumbnail already exists.");
		}
	}
	
	
}