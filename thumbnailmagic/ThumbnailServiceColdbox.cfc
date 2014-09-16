component extends="thumbnailmagic.ThumbnailService"{
	property name="thumbNailPath" inject="coldbox:setting:thumbNailPath";
	property name="pathToOO" inject="coldbox:setting:pathToOO";
	property name="ooHost" inject="coldbox:setting:ooHost";
	property name="ooPort" inject="coldbox:setting:ooPort";		
	/*
	 * ThumbnailMagic 
	 * 
	 * copyright 2014 Robert Munn
	 * 
	 * version: 0.9
	 * 
	 * author: Robert Munn robert.d.munn@gmail.com
	 * 
	 * license: MIT license
	 * 
	 **/

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