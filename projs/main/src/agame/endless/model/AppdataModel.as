package agame.endless.model
{
	import agame.endless.modules.main.particle.AppParticle;
	import agame.endless.model.prefs.AppPrefs;


	public class AppdataModel
	{
		//cookies 经济
		public var cookiesEarned:Number=0; //all cookies earned during gameplay
		public var cookies:Number=0; //cookies
		public var cookiesd:Number=0; //cookies display
		public var cookiesPs:Number=1; //cookies per second (to recalculate with every new purchase)
		public var cookiesReset:Number=0; //cookies lost to resetting
		public var frenzy:Number=0; //as long as >0, cookie production is multiplied by frenzyPower
		public var frenzyMax:Number=0; //how high was our initial burst
		public var frenzyPower:Number=1;
		public var clickFrenzy:Number=0; //as long as >0, mouse clicks get 777x more cookies
		public var clickFrenzyMax:Number=0; //how high was our initial burst
		public var cookieClicks:Number=0; //+1 for each click on the cookie
		public var goldenClicks:Number=0; //+1 for each golden cookie clicked (all time)
		public var goldenClicksLocal:Number=0; //+1 for each golden cookie clicked (this game only)
		public var missedGoldenClicks:Number=0; //+1 for each golden cookie missed
		public var handmadeCookies:Number=0; //all the cookies made from clicking the cookie
		public var milkProgress:Number=0; //you gain a little bit for each achievement. Each increment of 1 is a different milk displayed.
		public var milkH:Number=milkProgress / 2; //milk height, between 0 and 1 (although should never go above 0.5)
		public var milkHd:Number=0; //milk height display
		public var milkType:Number=-1; //custom milk : 0:Number=plain, 1:Number=chocolate...
		public var backgroundType:Number=-1; //custom background : 0:Number=blue, 1:Number=red...
		public var prestige:Array=[]; //cool stuff that carries over beyond resets
		public var resets:Number=0; //reset counter
		public var lastClick:int; //上一次点击时间。
		public var autoclickerDetected:int; //按键精灵检测器。
		public var computedMouseCps:int; //经过计算的鼠标点击的cps

		public var prefs:AppPrefs; //控制台。

		public var recalculateGains:Boolean;
		public var fps:int=60;

		public function AppdataModel()
		{
			initliaze();
		}

		private function initliaze():void
		{
			fps=60;
			prefs=new AppPrefs;
		}

		public function buyUpgrade(upgradeName:String):Boolean
		{
			var result:Boolean=false;
			return result;
		}


		public function Win(achivementName:String):void
		{
		}

		public function Earn(howmuch:Number):void
		{
			cookies+=howmuch;
			cookiesEarned+=howmuch;
		}

		public function Spend(howmuch:Number):void
		{
			cookies-=howmuch;
		}

		public function Dissolve(howmuch:Number):void
		{
			cookies-=howmuch;
			cookiesEarned-=howmuch;
		}
	}
}
