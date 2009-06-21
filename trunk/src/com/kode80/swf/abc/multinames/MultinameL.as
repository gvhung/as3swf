package com.kode80.swf.abc.multinames 
{
	import flash.utils.ByteArray;
	import com.kode80.swf.abc.MultinameInfo;
	import com.kode80.swf.utils.readEncodedU32;
	import com.kode80.swf.abc.NamespaceSet;
	
	/**
	* ...
	* @author Ben Hopkins
	*/
	public class MultinameL extends AbstractMultiname
	{
		protected var _namespaceSetIndex:uint;
		
		//=========================================================
		//	Properties
		//=========================================================
		
		public function get namespaceSet():NamespaceSet { return _info.constantPool.getNamespaceSetAt( _namespaceSetIndex); }
		
		//=========================================================
		//	Constructor
		//=========================================================
		
		public function MultinameL( info:MultinameInfo) 
		{
			super( info);
		}
		
		//=========================================================
		//	Public Methods
		//=========================================================
		
		override public function readFrom(bytes:ByteArray):void 
		{
			_namespaceSetIndex = readEncodedU32( bytes);
		}
		
		override public function toString():String 
		{
			return super.toString() + "\nnamespace set:" + namespaceSet + "\n";
		}
	}
	
}