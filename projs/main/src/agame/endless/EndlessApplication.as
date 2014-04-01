package agame.endless
{
	import com.agame.framework.Application;

	import agame.endless.configs.AppConfig;
	import agame.endless.configs.AppConfigModel;
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
