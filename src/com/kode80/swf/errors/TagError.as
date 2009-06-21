package com.kode80.swf.errors 
{
	
	/**
	* ...
	* @author Ben Hopkins
	*/
	public class TagError extends Error
	{
		
		public function TagError( message:String = "") 
		{
			super( message);
			name = "TagError";
		}
	}
	
}