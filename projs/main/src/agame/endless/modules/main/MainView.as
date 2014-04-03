package agame.endless.modules.main
{
	import com.agame.utils.Beautify;

	import agame.endless.Game;
	import agame.endless.modules.main.particle.CookieParticleSystem;
	import agame.endless.services.assets.Assets;
	import agame.endless.services.frame.IEnterframe;

	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extension.starlingide.display.movieclip.StarlingMovieClip;
	import starling.extension.starlingide.display.textfield.StarlingTextField;

	public class MainView extends Sprite implements IEnterframe
	{
		public static const CLICK_COOKIE:String='click_cookie';
		public var content:StarlingMovieClip;
		/**
		 *粒子系统
		 */
		private var _cookieParticleSystem:CookieParticleSystem;
		private var _cookies:StarlingTextField; //饼干数量
		private var _cps:StarlingTextField; //cps.
		private var _shine:StarlingMovieClip; //shine；
		private var _shine2:StarlingMovieClip; //shine2;

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
			_cookies=content.cookieCenter.cookiesLabel;
			_cookies.fontName=Assets.FontName;
			_cps=content.cookieCenter.cpsLabel;
			_cps.fontName=Assets.FontName;
			_shine=content.cookieCenter.shine;
			_shine2=content.cookieCenter.shine2;
			_shine.alpha=0.2;
			_shine2.alpha=0.2;
			_shine.flatten();
			_shine2.flatten();
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

		private var randnum:Number;

		public function enterframe():void
		{
			// TODO Auto Generated method stub
			_cookieParticleSystem.enterframe();
			_shine.rotation+=0.01;
			_shine2.rotation-=0.01;

			_cookies.text=Beautify(Game.cookies) + '  cookies';
			_cps.text='+' + Beautify(Game.cookiesPs) + '  per secend!';
		}

	}
}
