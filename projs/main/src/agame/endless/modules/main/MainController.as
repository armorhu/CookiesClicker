package agame.endless.modules.main
{
	import com.agame.framework.module.Module;
	import com.agame.utils.Beautify;

	import flash.utils.getTimer;

	import agame.endless.appStage;
	import agame.endless.modules.main.model.Game;
	import agame.endless.modules.main.model.MainModel;
	import agame.endless.modules.main.model.objects.ObjectData;
	import agame.endless.modules.main.view.MainView;
	import agame.endless.services.frame.Enterframe;
	import agame.endless.services.frame.IEnterframe;

	import starling.events.Event;
	import starling.events.EventDispatcher;

	public class MainController extends EventDispatcher implements IEnterframe
	{
		protected var _module:Module;

		protected var _view:MainView;

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
			Enterframe.current.add(this);
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
			Game=new MainModel;
			Game.initliaze();
			Game.addEvents(modelEventHandler);
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

		private function modelEventHandler(evt:Event):void
		{
			if (evt.type == MainModel.NEWTICKER_CHANGED)
				_view.content.newsTickerLabel.text=Game.Ticker;
			else if (evt.type == MainModel.REBUILD_STORED)
				rebuildStored();
			else if (evt.type == MainModel.REBUILD_UPGRADES)
				rebuildUpgrades();
		}

		private function rebuildStored():void
		{
			var objectData:ObjectData;
			for (var i:int=1; i < ObjectData.ObjectDatasN; i++)
			{
				objectData=Game.ObjectsById[i] as ObjectData;
				trace(objectData.id, objectData.name, objectData.displayName);
			}
		}

		private function rebuildUpgrades():void
		{
		}

		public function enterframe():void
		{
			// TODO Auto Generated method stub
			Game.enterframe();
			_view.enterframe();
			_view.cookies.text=Beautify(Game.cookies) + ' ' + (Game.cookies <= 1 ? 'cookie' : 'cookies');
			_view.cps.text='+' + Beautify(Game.cookiesPs) + '  per secend!';
		}

	}
}
