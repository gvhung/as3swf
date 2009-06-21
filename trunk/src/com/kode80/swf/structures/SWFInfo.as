package com.kode80.swf.structures 
{
	import com.kode80.swf.records.RectangleRecord;
	import com.kode80.swf.utils.BitReader;
	import flash.utils.ByteArray;
	
	/**
	* ...
	* @author Ben Hopkins
	*/
	public class SWFInfo
	{
		protected var _frameRectangle:RectangleRecord;
		protected var _frameRate:uint;
		protected var _numberOfFrames:uint;
		
		//=========================================================
		//	Properties
		//=========================================================
		
		public function get frameRectangle():RectangleRecord { return _frameRectangle; }
		
		public function get frameRate():uint { return _frameRate; }
		
		public function get numberOfFrames():uint { return _numberOfFrames; }
		
		//=========================================================
		//	Constructor
		//=========================================================
		
		public function SWFInfo() 
		{
			_frameRectangle = new RectangleRecord();
			_frameRate = 0;
			_numberOfFrames = 0;
		}
		
		//=========================================================
		//	Public Methods
		//=========================================================
	
		public function readFrom( bytes:ByteArray):void
		{
			var bits:BitReader = new BitReader( bytes);
			_frameRectangle.readFrom( bits);
			_frameRate = bytes.readUnsignedShort() >> 8;
			_numberOfFrames = bytes.readUnsignedShort();
		}
		
	}
	
}