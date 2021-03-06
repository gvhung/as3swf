﻿package com.kode80.swf.abc.multinames 
{
	import com.kode80.swf.abc.CPoolInfo;
	import com.kode80.swf.abc.MultinameInfo;
	import com.kode80.swf.abc.MultinameKinds;
	import flash.utils.ByteArray;
	
	/**
	* ...
	* @author Ben Hopkins
	*/
	public class AbstractMultiname 
	{
		protected var _info:MultinameInfo;
		
		//=========================================================
		//	Properties
		//=========================================================
		
		public function get kind():uint { return _info.kind; }
		
		public function get kindString():String { return MultinameKinds.multinameKindToString( _info.kind); }
		
		//=========================================================
		//	Constructor
		//=========================================================
		
		public function AbstractMultiname( info:MultinameInfo) 
		{
			_info = info;
		}
		
		//=========================================================
		//	Public Methods
		//=========================================================
		
		public function readFrom( bytes:ByteArray):void 
		{
		}
			
		public function toString():String
		{
			return "kind: " + kindString;
		}
	}
}