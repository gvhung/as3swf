package com.kode80.swf.abc 
{
	import com.kode80.swf.abc.multinames.AbstractMultiname;
	import com.kode80.swf.abc.multinames.MultinameL;
	import com.kode80.swf.abc.multinames.QName;
	import com.kode80.swf.abc.multinames.Multiname;
	import com.kode80.swf.abc.multinames.RTQName;
	import com.kode80.swf.abc.multinames.RTQNameL;
	import flash.utils.ByteArray;
	
	/**
	* ...
	* @author Ben Hopkins
	*/
	public class MultinameInfo 
	{
		protected var _kind:uint;
		protected var _data:AbstractMultiname;
		protected var _constantPool:CPoolInfo;
		
		//=========================================================
		//	Properties
		//=========================================================
		
		public function get constantPool():CPoolInfo { return _constantPool; }
		
		public function get data():AbstractMultiname { return _data; }
		
		public function get kind():uint { return _kind; }
		
		//=========================================================
		//	Constructor
		//=========================================================
		
		public function MultinameInfo( constantPool:CPoolInfo) 
		{
			_constantPool = constantPool;
			_data = new AbstractMultiname( this);
		}
		
		//=========================================================
		//	Public Methods
		//=========================================================
		
		public function readFrom( bytes:ByteArray):void
		{
			_kind = bytes.readUnsignedByte();
			
			switch( _kind)
			{
				case MultinameKinds.QNAME:
				case MultinameKinds.QNAMEA:
					_data = new com.kode80.swf.abc.multinames.QName( this);
					_data.readFrom( bytes);
				break;
				
				case MultinameKinds.RTQNAME:
				case MultinameKinds.RTQNAMEA:
					_data = new RTQName( this);
					_data.readFrom( bytes);
				break;
				
				case MultinameKinds.RTQNAMEL:
				case MultinameKinds.RTQNAMELA:
					_data = new RTQNameL( this);
					_data.readFrom( bytes);
				break;
				
				case MultinameKinds.MULTINAME:
				case MultinameKinds.MULTINAMEA:
					_data = new Multiname( this);
					_data.readFrom( bytes);
				break;
				
				case MultinameKinds.MULTINAMEL:
				case MultinameKinds.MULTINAMELA:
					_data = new MultinameL( this);
					_data.readFrom( bytes);
				break;
			}
		}
	}
	
}