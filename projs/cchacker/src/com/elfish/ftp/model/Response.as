package com.elfish.ftp.model
{
	////////////////////////////////////////////////////////////////////////////////
	//
	//  Copyright (C) 2009-2010 www.elfish.com.cn
	//  The following is Source Code about Response.as
	//	Bug and advice to darkty2009@gmail.com
	//
	////////////////////////////////////////////////////////////////////////////////
	
	/**
	 * 格式化返回状态信息
	 */
	public class Response
	{
		include "../../Version.as";
		
		private var _code:int;
		private var _text:String;
		private var _data:*;
		
		public function Response(code:int, text:String = "", data:* = null)
		{
			_code = code;
			_text = text;
			_data = data;
		}
		
		public function set code(_code:int):void
		{
			this._code = _code;
		}
		public function get code():int
		{
			return this._code;
		}
		
		public function set text(_text:String):void
		{
			this._text = _text;
		}
		public function get text():String
		{
			return this._text;
		}
		
		public function set data(_data:*):void
		{
			this._data = _data;
		}
		public function get data():*
		{
			return this._data;
		}
	}
}