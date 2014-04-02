package agame.endless.modules.main
{
	import com.agame.framework.module.Module;
	import com.agame.utils.Beautify;
	
	import flash.utils.getTimer;
	
	import agame.endless.Game;
	import agame.endless.appStage;
	
	import starling.events.Event;
	import starling.events.EventDispatcher;

	public class MainController extends EventDispatcher
	{
		protected var _module:Module;

		protected var _view:MainView;

		protected var _model:MainModel;

		public function MainController(module:Module)
		{
			this._module=module;
			super();
			initliaze();
		}

		protected function initliaze():void
		{
			initModel();
			initView();
		}

		protected function initView():void
		{
			_view=new MainView();
			_module.container.addChild(_view);


			_view.addEventListener(MainView.CLICK_COOKIE, viewEventHandler);
		}

		protected function disposeView():void
		{
		}

		protected function initModel():void
		{
		}

		protected function disposeModel():void
		{
		}



		/**
		 * 视图层事件。
		 * @param evt
		 */
		private function viewEventHandler(evt:Event):void
		{
			if (evt.type == MainView.CLICK_COOKIE)
				clickCookie();
		}

		private function clickCookie():void
		{
			var time:int=getTimer();
			if (time - Game.lastClick < 1000 / 250)
			{
			}
			else
			{
				if (time - Game.lastClick < 1000 / 15)
				{
					Game.autoclickerDetected+=Game.fps;
					if (Game.autoclickerDetected >= Game.fps * 5)
						Game.Win('Uncanny clicker');
				}
				Game.Earn(Game.computedMouseCps);
				Game.handmadeCookies+=Game.computedMouseCps;
				if (Game.prefs.particles)
				{
					_view.particleAdd();
					_view.particleAdd(appStage.mouseX, appStage.mouseY, Math.random() * 4 - 2, Math.random() * -2 - 2, Math.random() * 0.5 + 0.2, 1, 2);
				}
				if (Game.prefs.numbers)
					_view.particleAdd(appStage.mouseX + Math.random() * 8 - 4, appStage.mouseY - 8 + Math.random() * 8 - 4, 0, -2, 1, 4, 2, '', '+' + Beautify(Game.computedMouseCps, 1));
				Game.cookieClicks++;
			}
			Game.lastClick=time;
		}
	}
}
