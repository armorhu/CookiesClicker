package agame.endless.services.assets
{
	import flash.display.Bitmap;
	import flash.filesystem.File;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.ByteArray;

	import agame.endless.EndlessApplication;
	import agame.endless.configs.AppConfig;
	import agame.endless.configs.lang.LangConfigModel;
	import agame.endless.configs.news.NewsConfigModel;
	import agame.endless.modules.main.view.particle.ParticleBitmapFont;

	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.extension.starlingide.display.loader.StarlingLoader;
	import starling.extension.starlingide.display.textfield.StarlingTextField;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.AssetManager;

	public class Assets extends AssetManager
	{

		private static var _assets:Assets;

		public static var FontName:String;
		public var particleBmFont:ParticleBitmapFont;

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
			enqueue('res/swf/iphone_temp/iphone_pack.swf');
			enqueue(File.applicationDirectory.resolvePath('config'));
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
			var ba:ByteArray;

			ba=getByteArray('texts');
			LangConfigModel.init(ba.readUTFBytes(ba.bytesAvailable), 'ZH');
			removeByteArray('texts');

			ba=getByteArray('news');
			AppConfig.newsConfigModel=new NewsConfigModel();
			AppConfig.newsConfigModel.init(ba.readUTFBytes(ba.bytesAvailable));
			removeByteArray('news');

			ba=getByteArray('iphone_pack');
			main=new StarlingLoader
			main.loadBytes(ba);
			main.addEventListener(Event.COMPLETE, loadComplete);
		}

		private function registeBitmapFont():void
		{
			//注册位图字体

			var bitmap:Bitmap=new EmbedAssets.BitmapChars();
			var texture:Texture=Texture.fromBitmap(bitmap);

//			var texture:Texture=getLinkageTexture('fonts');

			var xml:XML=XML(new EmbedAssets.BritannicXML());
			var bitmapFont:BitmapFont=new BitmapFont(texture, xml);
			particleBmFont=new ParticleBitmapFont();

			Assets.FontName='fontsss';
			StarlingTextField.registerBitmapFont(bitmapFont, Assets.FontName);
			TextField.registerBitmapFont(bitmapFont, Assets.FontName);
		}

		public function loadComplete(evt:Event):void
		{
			removeByteArray('iphone_pack');
			registeBitmapFont();
			dispatchEventWith(Event.COMPLETE);
		}


		override public function playSound(name:String, startTime:Number=0, loops:int=0, transform:SoundTransform=null):SoundChannel
		{
//			return null;
			return super.playSound(name, startTime, loops, transform);
		}
	}
}
