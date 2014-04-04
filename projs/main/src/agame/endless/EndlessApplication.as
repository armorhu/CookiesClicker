package agame.endless
{
	import com.agame.framework.Application;

	import agame.endless.configs.AppConfig;
	import agame.endless.configs.AppConfigModel;
	import agame.endless.modules.main.model.MainModel;
	import agame.endless.services.assets.Assets;
	import agame.endless.work.StartupGameWork;

	public class EndlessApplication extends Application
	{
		protected var _startupGameWork:StartupGameWork;

		public function EndlessApplication()
		{
			super();
		}

		private function initliaze():void
		{
			appStage=stage;
			AppConfig=new AppConfigModel(this);
			new Assets(this);
		}

		override public function startup():void
		{
			super.startup();
			initliaze();
			_startupGameWork=new StartupGameWork(this);
			_startupGameWork.start();
		}
	}
}
