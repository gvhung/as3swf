package com.kode80.swf.abc.multinames 
{
	import com.kode80.swf.abc.NamespaceInfo;
	import flash.utils.ByteArray;
	import com.kode80.swf.abc.MultinameInfo;
	import com.kode80.swf.utils.readEncodedU32;
	
	/**
	* ...
	* @author Ben Hopkins
	*/
	public class QName extends AbstractMultiname
	{
		protected var _namespaceIndex:uint;
		protected var _nameIndex:uint;
		
		//=========================================================
		//	Properties
		//=========================================================
		
		public function get nameSpace():NamespaceInfo { return _info.constantPool.getNamespaceAt( _namespaceIndex); }
		
		public function get name():String { return _info.constantPool.getStringAt( _nameIndex); }
		
		//=========================================================
		//	Constructor 
		//=========================================================
		
		public function QName( info:MultinameInfo) 
		{
			super( info);
		}
		
		//=========================================================
		//	Public Methods
		//=========================================================
		
		override public function readFrom(bytes:ByteArray):void 
		{
			_namespaceIndex = readEncodedU32( bytes);
			_nameIndex = readEncodedU32( bytes);
		}
		
		override public function toString():String 
		{
			return super.toString() + "\nname:" + name + "\nnamespace:" + nameSpace + "\n";
		}
	}
	
}