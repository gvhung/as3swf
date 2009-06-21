package com.kode80.swf.structures 
{
	import com.kode80.swf.records.RectangleRecord;
	import com.kode80.swf.utils.BitReader;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	/**
	* ...
	* @author Ben Hopkins
	*/
	public class SWFHeader 
	{
		protected var _isCompressed:Boolean;
		protected var _version:uint;
		protected var _fileLength:uint;
		
		//=========================================================
		//	Properties
		//=========================================================
		
		public function get isCompressed():Boolean { return _isCompressed; }
		
		public function get version():uint { return _version; }
		
		public function get fileLength():uint { return _fileLength; }
		
		//=========================================================
		//	Constructor
		//=========================================================
		
		public function SWFHeader() 
		{
			_isCompressed = false;
			_version = 0;
			_fileLength = 0;
		}
		
		//=========================================================
		//	Public Methods
		//=========================================================

		public function readFrom( bytes:ByteArray):void
		{
			var magic:String = String.fromCharCode( bytes.readUnsignedByte());
			magic += String.fromCharCode( bytes.readUnsignedByte());
			magic += String.fromCharCode( bytes.readUnsignedByte());
			
			if ( magic == "FWS" || magic == "CWS")
			{
				_isCompressed = magic.charAt( 0) == "C";
				_version = bytes.readUnsignedByte();
				_fileLength = bytes.readUnsignedInt();
			}
			else
			{
				throw new Error( "Wrong magic number in header, found \"" + magic + "\".");
			}
		}
		
	}
	
}