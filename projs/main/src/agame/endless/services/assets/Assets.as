package agame.endless.services.assets
{
	import agame.endless.EndlessApplication;
	import agame.endless.work.EndlessWork;

	import starling.events.Event;
	import starling.extension.starlingide.display.loader.StarlingLoader;
	import starling.text.BitmapFont;

	public class Assets extends EndlessWork
	{
		private static var _assets:Assets;
		
		public static const FontName:String=BitmapFont.MINI;

		public static function get current():Assets
		{
			return _assets;
		}

		public function Assets(app:EndlessApplication)
		{
			super(app);
			_assets=this;
		}

		public var main:StarlingLoader;
		private var _loadingQueue:Vector.<StarlingLoader>;

		override public function start():void
		{
			_loadingQueue=new Vector.<StarlingLoader>;

			main=new StarlingLoader;
			load(main, 'res/swf/iphone_temp/iphone_pack.swf');
		}

		private function load(loader:StarlingLoader, url:String):void
		{
			loader.load(url);
			loader.addEventListener(Event.COMPLETE, loadComplete);
			_loadingQueue.push(loader);
		}

		private function loadComplete(evt:Event):void
		{
			var target:StarlingLoader=evt.target as StarlingLoader;
			target.removeEventListener(Event.COMPLETE, loadComplete);
			var index:int=_loadingQueue.indexOf(target);
			_loadingQueue.splice(index, 1);
			if (_loadingQueue.length == 0)
				workComplete();
		}
	}
}
