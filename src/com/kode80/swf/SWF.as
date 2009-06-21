package com.kode80.swf 
{
	import com.kode80.swf.records.RectangleRecord;
	import com.kode80.swf.structures.SWFHeader;
	import com.kode80.swf.structures.SWFInfo;
	import com.kode80.swf.tags.DefineBitsLossless;
	import com.kode80.swf.tags.DefineBitsLossless2;
	import com.kode80.swf.tags.DefineSceneAndFrameLabelDataTag;
	import com.kode80.swf.tags.DoABCTag;
	import com.kode80.swf.tags.FileAttributesTag;
	import com.kode80.swf.tags.MetaDataTag;
	import com.kode80.swf.tags.ScriptLimitsTag;
	import com.kode80.swf.tags.SetBackgroundColorTag;
	import com.kode80.swf.tags.SymbolClassTag;
	import com.kode80.swf.tags.Tag;
	import com.kode80.swf.tags.TagCodes;
	import com.kode80.swf.tags.TagHeader;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	/**
	* ...
	* @author Ben Hopkins
	*/
	public class SWF 
	{
		private var _header:SWFHeader;
		private var _info:SWFInfo;
		private var _tags:Array;
		private var _filterTagCode:uint;
		
		//=========================================================
		//	Properties
		//=========================================================
		
		public function get isCompressed():Boolean { return _header.isCompressed; }
		
		public function get version():uint { return _header.version; }
		
		public function get uncompressedFileSize():uint { return _header.fileLength; }
		
		public function get frameRectangle():RectangleRecord { return _info.frameRectangle; }
		
		public function get frameRate():uint { return _info.frameRate; }
		
		public function get numberOfFrames():uint { return _info.numberOfFrames; }
		
		public function get numberOfTags():uint { return _tags.length; }
		
		//=========================================================
		//	Constructor
		//=========================================================
		
		public function SWF() 
		{
			_tags = new Array();
		}
		
		//=========================================================
		//	Private Methods
		//=========================================================
		
		private function _createNewTag( tagCode:uint):Tag
		{
			var tag:Tag;
			
			switch( tagCode)
			{
				case TagCodes.DEFINE_BITS_LOSSLESS: tag = new DefineBitsLossless(); break;
				case TagCodes.DEFINE_BITS_LOSSLESS2: tag = new DefineBitsLossless2(); break;
				case TagCodes.DEFINE_SCENE_AND_FRAME_LABEL_DATA: tag = new DefineSceneAndFrameLabelDataTag(); break;
				case TagCodes.DO_ABC: tag = new DoABCTag(); break;
				case TagCodes.FILE_ATTRIBUTES: tag = new FileAttributesTag(); break;
				case TagCodes.METADATA: tag = new MetaDataTag(); break;
				case TagCodes.SCRIPT_LIMITS: tag = new ScriptLimitsTag(); break;
				case TagCodes.SET_BACKGROUND_COLOR: tag = new SetBackgroundColorTag(); break;
				case TagCodes.SYMBOL_CLASS: tag = new SymbolClassTag(); break;
				default:
					tag = new Tag();
			}
			
			return tag;
		}
		
		private function _readTags( bytes:ByteArray):Array
		{
			var tags:Array = new Array();
			var tagHeader:TagHeader;
			var tag:Tag;
			
			while ( bytes.bytesAvailable > 0)
			{
				tagHeader = new TagHeader();
				tagHeader.readFrom( bytes);
				
				tag = _createNewTag( tagHeader.tagCode);
				tag.readFrom( bytes, tagHeader);
				
				tags.push( tag);
			}
			
			return tags;
		}
		
		private function _filterTagsByCode(item:*, index:int, array:Array):Boolean
		{
			var tag:Tag = array[ index];
			return tag.tagCode == _filterTagCode;
		}
		
		//=========================================================
		//	Public Methods
		//=========================================================
		
		public function readFrom( bytes:ByteArray):void
		{
			_header = new SWFHeader();
			_header.readFrom( bytes);
			
			if ( _header.isCompressed)
			{
				var ba:ByteArray = new ByteArray();
				bytes.readBytes( ba);
				ba.uncompress();
				ba.endian = Endian.LITTLE_ENDIAN;
				bytes = ba;
			}
			
			_info = new SWFInfo();
			_info.readFrom( bytes);
			
			_tags = _readTags( bytes);
		}
		
		public function getTagAt( index:uint):Tag
		{
			return _tags[ index];
		}
		
		public function getTagsByCode( tagCode:uint):Array
		{
			_filterTagCode = tagCode;
			return _tags.filter( _filterTagsByCode);
		}
		
		public function isSupportedTag( tagCode:uint):Boolean
		{
			switch( tagCode)
			{
				case TagCodes.DEFINE_BITS_LOSSLESS:
				case TagCodes.DEFINE_BITS_LOSSLESS2:
				case TagCodes.DEFINE_SCENE_AND_FRAME_LABEL_DATA:
				case TagCodes.DO_ABC:
				case TagCodes.FILE_ATTRIBUTES:
				case TagCodes.METADATA:
				case TagCodes.SCRIPT_LIMITS:
				case TagCodes.SET_BACKGROUND_COLOR:
				case TagCodes.SYMBOL_CLASS:
					return true;
				default:
			}
			
			return false;
		}
	}
	
}