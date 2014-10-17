component extends="thumbnailmagic.ThumbnailService"{
	property name="thumbNailPath" inject="coldbox:setting:thumbNailPath";
	property name="ooPath" inject="coldbox:setting:ooPath";
	property name="ooHost" inject="coldbox:setting:ooHost";
	property name="ooPort" inject="coldbox:setting:ooPort";

	public thumbnailmagic.ThumbnailService function init( string thumbnailPath, struct options default = {} ){
		variables.instance = {};

		return this;
	}

	public void function configure() onDIComplete{

		setGlobals( createObject( "thumbnailmagic.system.Globals" ).init( thumbnailPath = variables.thumbnailPath ) );
		setPDFCreator();
		setHTTPUtil();
		_setCreators( options = variables );
	}

}