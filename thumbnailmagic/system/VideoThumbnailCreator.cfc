component extends="thumbnailmagic.system.BaseThumbnailCreator" {

	public thumbnailmagic.system.VideoThumbnailCreator function init( required string thumbnailPath, required string os, required string cfServer ){
		super.init( argumentcollection = arguments );
		_setffmpeg();
		return this;
	}

	public array function createThumbnail( required string filepath, required string filename, string newfilename, struct options  ){
		
		//base options
		local.rate = 1;
		local.frames = 1;
		local.start = "00:01:00";
		local.timeout = 60;
		if( not isNull( arguments.options ) ){
			for( local.key in arguments.options ){
				local[ key ] =  arguments.options[ key ]; 
			} 
		}


		local.create = variables["_createThumbnail#getcfServer()#"];
		local.create( filepath = arguments.filepath, filename = arguments.filename, destination = getThumbnailPath(), rate = local.rate, frames = local.frames, start = local.start, timeout = local.timeout );

		local.results = [];
		for( local.i = 1; local.i lte local.frames; local.i++ ){
			local.results[ local.i ] = arguments.filename & "-" & local.i & ".jpg";
			
		}
		return local.results;
	
	}
	
	private void function _createThumbnailACF( required string filepath, required string filename, required string destination, required numeric scale, required string pages, required numeric timeout ){

	}

	private void function _createThumbnailRailo( required string filepath, required string filename, required string destination, required numeric rate, required numeric frames, required string start, required numeric timeout){
		//  ffmpeg -i inputfile.avi  -r 1 -vframes 120 -ss  01:30:14 image-%d.jpeg
		execute
			name="#_getffmpeg()#"
			arguments="-i #arguments.filepath##arguments.filename# -r #arguments.rate# -vframes #arguments.frames# -ss #arguments.start# #arguments.destination##arguments.filename#-%d.jpg"
			timeout="#arguments.timeout#"
			errorVariable="errorOut"{};
	}	

	private void function _setffmpeg(){
		if( getOS() contains "Windows" ){
			variables.instance.ffmpeg = "ffmpeg.exe";
		}else{
			variables.instance.ffmpeg = "ffmpeg";
		}
	}
	
	private string function _getffmpeg(){
		return variables.instance.ffmpeg;
	}
}

