package agame.endless.work.init
{
	import com.agame.framework.module.Module;

	import flash.geom.Rectangle;

	import agame.endless.EndlessApplication;
	import agame.endless.appStage;
	import agame.endless.enm.EnmModuleName;
	import agame.endless.modules.main.ModuleMain;
	import agame.endless.work.EndlessWork;

	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;

	public class StartupStarlingWorker extends EndlessWork
	{
		protected var m_starling:Starling;
		protected var viewPort:Rectangle;

		public function StartupStarlingWorker(app:EndlessApplication)
		{
			super(app);
		}

		override public function start():void
		{
			viewPort=new Rectangle();
			viewPort.width=Math.max(appStage.fullScreenWidth, appStage.fullScreenHeight);
			viewPort.height=Math.min(appStage.fullScreenWidth, appStage.fullScreenHeight);

			Starling.handleLostContext=true; //android建议处理
			m_starling=new Starling(StarlingRoot, appStage, viewPort);
			m_starling.addEventListener(Event.ROOT_CREATED, onCreateContext3d);
			m_starling.simulateMultitouch=false;
			m_starling.enableErrorChecking=false;
		}


		/**
		 * Context3d构造成功
		 * @param e
		 */
		private function onCreateContext3d(e:Event):void
		{
			e.target.removeEventListener(Event.ROOT_CREATED, onCreateContext3d);

			Starling.current.start();
			workComplete();
		}

		protected function registeStarlingModule():void
		{
			var layer:Sprite=new Sprite;
			Starling.current.stage.addChild(layer);
			app.moduleManager.registeModule(EnmModuleName.Main, ModuleMain, layer);
		}
	}
}

import starling.display.Sprite;

class StarlingRoot extends Sprite
{
}