package agame.endless.modules.main
{
	import agame.endless.modules.main.particle.CookieParticleSystem;
	import agame.endless.services.assets.Assets;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extension.starlingide.display.movieclip.StarlingMovieClip;

	public class MainView extends Sprite
	{
		public static const CLICK_COOKIE:String='click_cookie';
		public var content:StarlingMovieClip;


		/**
		 *粒子系统
		 */
		private var _cookieParticleSystem:CookieParticleSystem;

		public function MainView()
		{
			super();
			initiliaze();
		}

		private function initiliaze():void
		{
			content=Assets.current.main.context;
			addChild(content);
			content.addEventListener(Event.TRIGGERED, triggeredMeHandler);
			_cookieParticleSystem=new CookieParticleSystem(content.cookieCenter);
		}

		private function triggeredMeHandler(evt:Event):void
		{
			var targetName:String=evt.target['name'];
			trace(evt.target['name']);
			if (targetName == 'bigCookie')
				dispatchEventWith(CLICK_COOKIE);
		}


		public function particleAdd(x:Number=0, y:Number=0, xd:Number=0, yd:Number=0, size:int=0, dur:Number=0, z:Number=0, pic:String=null, text:String=null):void
		{
			_cookieParticleSystem.particleAdd(x, y, xd, yd, size, dur, z, pic, text);
		}
	}
}
