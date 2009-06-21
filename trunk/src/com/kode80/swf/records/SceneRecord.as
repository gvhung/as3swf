package com.kode80.swf.records 
{
	import com.kode80.swf.utils.readStringFromBytes;
	import com.kode80.swf.utils.readEncodedU32;
	import flash.utils.ByteArray;
	
	/**
	* ...
	* @author Ben Hopkins
	*/
	public class SceneRecord 
	{
		protected var _frameOffset:uint;
		protected var _name:String;
		
		//=========================================================
		//	Properties
		//=========================================================
		
		public function get name():String { return _name; }
		
		public function get frameOffset():uint { return _frameOffset; }
		
		//=========================================================
		//	Constructor
		//=========================================================
		
		public function SceneRecord() 
		{
			
		}
		
		//=========================================================
		//	Public Methods
		//=========================================================
		
		public function readFrom( bytes:ByteArray):void
		{
			_frameOffset = readEncodedU32( bytes);
			_name = readStringFromBytes( bytes);
		}
	}
	
}