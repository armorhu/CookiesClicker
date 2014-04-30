package agame.endless
{
	import com.agame.framework.Application;

	import agame.endless.configs.AppConfig;
	import agame.endless.configs.AppConfigModel;
	import agame.endless.services.assets.Assets;
	import agame.endless.services.wechat.WechatProxy;
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
			WechatProxy.setup('wx83705d131d3c73ef'); //别踩黑块的appid
//			WechatProxy.setup('wxe38b42d5a650dc12'); //农场的appid
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
