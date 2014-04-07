package agame.endless.modules.main.model.newsticker
{
	import com.agame.utils.choose;

	import agame.endless.configs.AppConfig;
	import agame.endless.configs.lang.Lang;
	import agame.endless.configs.news.NewsConfig;
	import agame.endless.modules.main.model.Game;
	import agame.endless.modules.main.model.MainModel;
	import agame.endless.modules.main.model.objects.ObjectData;

	public class NewsTicker
	{
		private static const newsList1:Vector.<int>=new Vector.<int>;
		private static const newsList2:Vector.<int>=new Vector.<int>;

		public function NewsTicker()
		{
		}

		public static function setup():void
		{
			var ids:Vector.<int>=AppConfig.newsConfigModel.getIndexList();
			var len:int=ids.length;
			var config:NewsConfig;
			for (var i:int=0; i < len; i++)
			{
				config=AppConfig.newsConfigModel.getNewsConfigByID(ids[i]);
				if (config.type == 1)
					newsList1.push(ids[i]);
				else if (config.type == 2)
					newsList2.push(ids[i]);
			}
			newsList2.fixed=true;
			newsList2.fixed=true;
		}

		private static const sHelperList:Vector.<String>=new Vector.<String>;

		public static function getTicker():void
		{
			if (Game.TickerN % 2 == 0 || Game.cookiesEarned >= 10100000000)
			{
				var len:int=newsList1.length;
				var configs:Vector.<NewsConfig>;
				var flag:Boolean;
				for (var i:int=0; i < len; i++)
				{
					configs=AppConfig.newsConfigModel.getNewsConfigListByID(newsList1[i]);
					if (configs.length == 0)
						continue;
					flag=false;
					if (configs[0].tierObject != '')
					{
						if ((Game.Objects[configs[0].tierObject] as ObjectData).amount > configs[0].tierObjectAmount)
							flag=true;
					}
					else if (configs[0].tierAchievment != '')
					{
						if (Game.HasAchiev(configs[0].tierAchievment))
							flag=true;
					}
					else if (configs[0].tierUpgrade != '')
					{
						if (Game.HasAchiev(configs[0].tierUpgrade))
							flag=true;
					}

					if (flag)
						sHelperList.push(chooseContext(configs));
				}
			}

			if (sHelperList.length == 0)
			{
				len=newsList2.length;
				for (i=0; i < len; i++)
				{
					configs=AppConfig.newsConfigModel.getNewsConfigListByID(newsList2[i]);
					if (configs.length == 0)
						continue;
					if (Game.cookiesEarned < configs[0].cookieEarned)
					{
						sHelperList.push(chooseContext(configs));
						break;
					}
				}
			}

			Game.TickerAge=Game.fps * 10;
			if (sHelperList.length == 0)
				Game.Ticker='';
			else
			{
				Game.Ticker=Lang(sHelperList[int(sHelperList.length * Math.random())]);
				sHelperList.splice(0, sHelperList.length);
			}
			Game.TickerN++;
			Game.dispatchEventWith(MainModel.NEWTICKER_CHANGED);
		}

		private static function chooseContext(configs:Vector.<NewsConfig>):String
		{
			return configs[int(Math.random() * configs.length)].context
		}
	}
}
