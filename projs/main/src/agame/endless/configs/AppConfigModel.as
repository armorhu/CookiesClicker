package agame.endless.configs
{
	import com.agame.services.load.resource.Resource;

	import flash.utils.getTimer;

	import agame.endless.EndlessApplication;
	import agame.endless.work.EndlessWork;

	//==========================不要动我!!!!!!!========================//
	/**
	 * 程序配置模型，在此可以获得所有与配置相关的信息
	 * @author wesleysong
	 */



	/**自动生成的import代码--start**/
	import agame.endless.configs.objects.ObjectsConfigModel;
	import agame.endless.configs.upgrades.UpgradesConfigModel;
	import agame.endless.configs.achievements.AchievementsConfigModel;
	import agame.endless.configs.news.NewsConfigModel;
	import agame.endless.configs.texts.TextsConfigModel;
	/**自动生成的import代码--end**/
	public class AppConfigModel extends EndlessWork
	{
		//==========================不要动我!!!!!!!========================//
		/**自动生成的属性代码--start**/
		public var objectsConfigModel:ObjectsConfigModel;
		public var upgradesConfigModel:UpgradesConfigModel;
		public var achievementsConfigModel:AchievementsConfigModel;
		public var newsConfigModel:NewsConfigModel;
		public var textsConfigModel:TextsConfigModel;
		/**自动生成的属性代码--end**/
		//==========================不要动我!!!!!!!========================//
		private var _urls:Vector.<String>;
		private var _iConfigs:Vector.<IConfigModel>;


		public function AppConfigModel(app:EndlessApplication)
		{
			super(app);
			init()
		}

		public function init():void
		{
			_urls=new Vector.<String>;
			_iConfigs=new Vector.<IConfigModel>;
			//==========================不要动我!!!!!!!========================//
			/**自动生产的logic代码--start**/
			objectsConfigModel = new ObjectsConfigModel;
			bindle("config/objects.csv",objectsConfigModel);
			upgradesConfigModel = new UpgradesConfigModel;
			bindle("config/upgrades.csv",upgradesConfigModel);
			achievementsConfigModel = new AchievementsConfigModel;
			bindle("config/achievements.csv",achievementsConfigModel);
			newsConfigModel = new NewsConfigModel;
			bindle("config/news.csv",newsConfigModel);
			textsConfigModel = new TextsConfigModel;
			bindle("config/texts.csv",textsConfigModel);
		/**自动生产的logic代码--end**/
			//==========================不要动我!!!!!!!========================//
		}

		private function bindle(url:String, iConfig:IConfigModel):void
		{
			_urls.push(url);
			_iConfigs.push(iConfig);
		}

		override public function start():void
		{
			//开发环境就走正常的流程
			const len:int=_urls.length;
			for (var i:int=0; i < len; i++)
				app.loadResource(_urls[i], loadConfigComplete);
		}

		private static const UUID:String='429739c0-3f99-11e3-aa6e-0800200c9a66';

		private function loadConfigComplete(res:Resource):void
		{
			loadConfig(res.url, res.data as String);
//			StageInstance.stage.dispatchEvent(new CommonEvent('loadConfig', {url: res.url, data: res.data}));
//			if (_urls.length == 0)
//				StageInstance.stage.dispatchEvent(new CommonEvent('loadConfig_complete', {url: res.url, data: res.data}));
		}

		public function loadConfig(url:String, text:String):void
		{
			var idx:int=_urls.indexOf(url);
			if (idx == -1)
				return;

			var time:int=getTimer();
			_iConfigs[idx].init(text);
			_iConfigs.splice(idx, 1);
			_urls.splice(idx, 1);
			if (_urls.length == 0)
			{
				workComplete();
			}
			else
			{
			}
		}
	}
}
