component extends="thumbnailmagic.system.BaseThumbnailCreator" {

	public thumbnailmagic.system.ImageThumbnailCreator function init( thumbnailmagic.system.Globals globals ){
		super.init( argumentcollection = arguments );
		return this;
	}

	public array function createThumbnail( required string filepath, required string filename, struct options  ){
		local.image = imageRead( path = arguments.filepath & arguments.filename );
		local.fileInfo = imageInfo( local.image );

		//base options
		local.height = 200;
		local.overwrite = "overwrite";
		local.filename = arguments.filename;
		
		if( not isNull( arguments.options ) )
			structAppend( local, setOptions( arguments.options ) );	

		local.filename = _verifyFilename( filepath = arguments.filepath, filename = local.filename, overwrite = local.overwrite );

		local.heightPercent = ( local.height / local.fileInfo.height  ) * 100;
		if( isNull( local.width )){
			local.widthPercent = local.heightPercent;
		}else{
			local.widthPercent = ( local.width / local.fileInfo.width ) * 100;
		}

		imageResize( name="local.image", width="#local.widthPercent#%", height="#local.heightPercent#%");

		imageWrite(name="local.image", destination="#getGlobals().getThumbnailPath()##local.filename#");
		return [ local.filename ];
	}
}
