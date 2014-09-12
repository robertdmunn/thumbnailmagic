component extends="thumbnailmagic.system.BaseThumbnailCreator" {

	public thumbnailmagic.system.ImageThumbnailCreator function init( thumbnailmagic.system.Globals globals ){
		super.init( argumentcollection = arguments );
		return this;
	}

	public array function createThumbnail( required string filepath, required string filename, string newfilename, struct options  ){
		local.image = imageRead( path = arguments.filepath & arguments.filename );
		local.fileInfo = imageInfo( local.image );

		//base options
		local.height = 200;

		if( not isNull( arguments.options ) )
			structAppend( local, setOptions( arguments.options ) );	
		
		local.heightPercent = ( local.height / local.fileInfo.height  ) * 100;
		if( isNull( local.width )){
			local.widthPercent = local.heightPercent;
		}else{
			local.widthPercent = ( local.width / local.fileInfo.width ) * 100;
		}

		imageResize( name="local.image", width="#local.widthPercent#%", height="#local.heightPercent#%");

		if( not isNull( arguments.newFilename ) ){
			imageWrite(name="local.image", destination="#getGlobals().getThumbnailPath()##arguments.newFilename#");
			return [ arguments.newFilename ];
		}else{
			imageWrite(name="local.image", destination="#getGlobals().getThumbnailPath()##arguments.filename#");
			return [ arguments.filename ];
		}	
	}
}

