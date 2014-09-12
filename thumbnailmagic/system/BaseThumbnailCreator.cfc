component {

	public thumbnailmagic.system.BaseThumbnailCreator function init( thumbnailmagic.system.Globals globals ){
		variables.instance = {};
		setGlobals( arguments.globals );
		return this;
	}

	public array function createThumbnail( required string filepath, required string filename, string newfilename, struct options ){
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
	
	
}