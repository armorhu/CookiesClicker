package agame.endless.modules.main.particle
{
	import flash.text.TextField;

	import agame.endless.services.assets.Assets;

	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.extension.starlingide.display.movieclip.StarlingMovieClip;
	import starling.extension.starlingide.display.textfield.StarlingTextField;

	public class AppParticle extends Sprite
	{
		public var xd:int=0;
		public var yd:int=0;
		public var z:int=0;
		public var size:int=1;
		public var dur:int=2;
		public var life:int=-1;


		private var _view:StarlingMovieClip;

		private var cookie:StarlingMovieClip;
		private var numText:StarlingTextField;

		public function AppParticle()
		{
			_view=Assets.current.main.createInstance('endless.ui.CookieParticle');
			cookie=_view.cookie;
			numText=_view.num;
			addChild(_view);
		}

		public function set r(value:int):void
		{
			(_view.cookie as DisplayObject).rotation=(value / 360) * Math.PI * 2;
		}

		public function set text(value:String):void
		{
			numText.text = value;
		}

		public function get text():String
		{
			return numText.text;
		}
	}
}
