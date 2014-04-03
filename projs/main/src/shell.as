package
{
	import flash.display.Sprite;
	import flash.display.StageQuality;
	
	import agame.endless.EndlessApplication;

	public class shell extends Sprite
	{
		public function shell()
		{
			super();
			stage.frameRate = 60;
			stage.quality = StageQuality.LOW;
			var app:EndlessApplication=new EndlessApplication;
			addChild(app)
			app.startup();
			
//			var o:ObjectModels = new ObjectModels;
//			o.setup();
//			
//			var u:UpgradeModels = new UpgradeModels;
//			u.setup();
//
//			var a:AchementModels = new AchementModels;
//			a.setup();
		}
	}
}
