package agame.endless.services.assets
{
	import flash.filesystem.File;
	import flash.utils.ByteArray;

	import agame.endless.EndlessApplication;

	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.extension.starlingide.display.loader.StarlingLoader;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.AssetManager;

	public class Assets extends AssetManager
	{

		private static var _assets:Assets;

		public static var FontName:String;

		public static function get current():Assets
		{
			return _assets;
		}

		public function Assets(app:EndlessApplication)
		{
			super(app);
			_assets=this;
		}

		private var _loadingQueue:Vector.<StarlingLoader>;
		private var main:StarlingLoader;

		public function start():void
		{
			enqueue('res/fonts_xml.xml');
			enqueue('res/fonts_png.png');
			enqueue('res/swf/iphone_temp/iphone_pack.swf');
			enqueue(File.applicationDirectory.resolvePath('res/audio'));
			loadQueue(loading);
		}

		private function loading(progress:Number):void
		{
			trace('loading....' + progress);
			if (progress == 1)
				progressAssets();
		}

		public function getLinkageInstance(name:String):DisplayObject
		{
			return main.getLinkageInstance(name);
		}

		public function getLinkageTexture(name:String):Texture
		{
			return main.getLinakgeTexture(name);
		}

		public function progressAssets():void
		{
			trace(getXml('fonts'), getTexture('fonts_png'));
			var bitmapFont:BitmapFont=new BitmapFont(getTexture('fonts_png'), getXml('fonts_xml'));
			FontName='fontsss';
			TextField.registerBitmapFont(bitmapFont, FontName);

			var ba:ByteArray=getByteArray('iphone_pack');
			main=new StarlingLoader;
			main.loadBytes(ba);
			main.addEventListener(Event.COMPLETE, loadComplete);
		}

		public function loadComplete(evt:Event):void
		{
			dispatchEventWith(Event.COMPLETE);
		}

	}
}
