package com.kode80.swf.records 
{
	import com.kode80.swf.utils.readStringFromBytes;
	import com.kode80.swf.utils.readEncodedU32;
	import flash.utils.ByteArray;
	
	/**
	* ...
	* @author Ben Hopkins
	*/
	public class FrameLabelRecord 
	{
		protected var _frame:uint;
		protected var _label:String;
		
		//=========================================================
		//	Properties
		//=========================================================
		
		public function get label():String { return _label; }
		
		public function get frame():uint { return _frame; }
		
		//=========================================================
		//	Constructor
		//=========================================================
		
		public function FrameLabelRecord() 
		{
			
		}
		
		//=========================================================
		//	Public Methods
		//=========================================================
		
		public function readFrom( bytes:ByteArray):void 
		{
			_frame = readEncodedU32( bytes);
			_label = readStringFromBytes( bytes);
		}
	}
	
}