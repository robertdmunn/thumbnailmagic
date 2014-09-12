component{

	public thumbnailmagic.system.Globals function init( required string thumbnailPath ){
		variables.instance = {};
		setThumbnailPath( arguments.thumbnailPath );
		setOS( server.os.name );
		setcfServer();
		return this;
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
	
		if (server.ColdFusion.ProductName CONTAINS "Railo"){ 
			variables.instance.cfserver = "Railo";
		} else if (server.ColdFusion.ProductName CONTAINS "BlueDragon") { 
			variables.instance.cfserver = "BlueDragon"; 
		} else if (server.ColdFusion.ProductName CONTAINS "ColdFusion") { 
			variables.instance.cfserver = "ACF"; 
		} 
	}

	public string function getcfServer(){
		return variables.instance.cfserver;
	}
}