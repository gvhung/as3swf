package com.kode80.swf.abc.multinames 
{
	import flash.utils.ByteArray;
	import com.kode80.swf.abc.MultinameInfo;
	
	/**
	* ...
	* @author Ben Hopkins
	*/
	public class RTQNameL extends AbstractMultiname
	{
		//=========================================================
		//	Constructor
		//=========================================================
		
		public function RTQNameL( info:MultinameInfo) 
		{
			super( info);
		}
		
		//=========================================================
		//	Public Methods
		//=========================================================
		
		override public function readFrom(bytes:ByteArray):void 
		{
			super.readFrom(bytes);
		}
	}
	
}