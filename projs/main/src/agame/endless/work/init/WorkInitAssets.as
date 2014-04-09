package agame.endless.work.init
{
	import agame.endless.EndlessApplication;
	import agame.endless.services.assets.Assets;
	import agame.endless.services.feathers.theme.GameTheme;
	import agame.endless.work.EndlessWork;
	
	import starling.core.Starling;
	import starling.events.Event;

	public class WorkInitAssets extends EndlessWork
	{
		public function WorkInitAssets(app:EndlessApplication)
		{
			super(app);
		}

		override public function start():void
		{
			Assets.current.start();
			Assets.current.addEventListener(Event.COMPLETE, function(evt:Event):void
			{
				//初始化游戏主题
				new GameTheme(Starling.current.stage);
				workComplete();
			})
		}
	}
}
