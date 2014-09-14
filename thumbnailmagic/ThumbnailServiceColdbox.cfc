component extends="thumbnailmagic.ThumbnailService"{
	property name="thumbNailPath" inject="coldbox:setting:thumbNailPath";

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

	public thumbnailmagic.ThumbnailService function init( string thumbnailPath ){
		variables.instance = {};

		return this;
	}

	public void function configure() onDIComplete{
		
		setGlobals( createObject( "thumbnailmagic.system.Globals" ).init( thumbnailPath = variables.thumbnailPath ) );
		setPDFCreator();
		setHTTPUtil();
		_setCreators();
	}

}