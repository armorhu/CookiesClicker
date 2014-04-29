package agame.endless.services.assets
{
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
			shell.loading.txt.text='Loading...' + int(progress * 100) + '%';
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
			initConfig();
			initSWF();
		}

		private function initSWF():void
		{
			// TODO Auto Generated method stub
			var ba:ByteArray;
			ba=getByteArray('iphone_pack');
			main=new StarlingLoader
			main.loadBytes(ba);
			main.addEventListener(Event.COMPLETE, loadComplete);
		}

		private function initConfig():void
		{
			registeBitmapFont(); //需要在加载swf之前调用。
			var ba:ByteArray;

			ba=getByteArray('texts');
			LangConfigModel.init(ba.readUTFBytes(ba.bytesAvailable), 'ZH');
			removeByteArray('texts');

			ba=getByteArray('news');
			AppConfig.newsConfigModel=new NewsConfigModel();
			AppConfig.newsConfigModel.init(ba.readUTFBytes(ba.bytesAvailable));
			removeByteArray('news');
		}

		private function registeBitmapFont():void
		{
			//注册位图字体
			Assets.FontName='Wawati SC Regular';
			var texture:Texture=Texture.fromBitmap(new EmbedAssets.BitmapChars());
			var xml:XML=new XML(new EmbedAssets.BritannicXML());
			var bitmapFont:BitmapFont=new BitmapFont(texture, xml);
			TextField.registerBitmapFont(bitmapFont, Assets.FontName);
			particleBmFont=new ParticleBitmapFont(texture, xml);
			StarlingTextField.registerBitmapFont(bitmapFont, Assets.FontName);
		}

		public function loadComplete(evt:Event):void
		{
			removeByteArray('iphone_pack');
			dispatchEventWith(Event.COMPLETE);
		}


		override public function playSound(name:String, startTime:Number=0, loops:int=0, transform:SoundTransform=null):SoundChannel
		{
//			return null;
			return super.playSound(name, startTime, loops, transform);
		}
	}
}
