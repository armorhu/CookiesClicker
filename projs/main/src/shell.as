package
{
	import flash.display.Sprite;
	
	import agame.endless.EndlessApplication;

	public class shell extends Sprite
	{
		public function shell()
		{
			super();
			var app:EndlessApplication=new EndlessApplication;
			addChild(app)
			app.startup();
			
//			var o:ObjectModels = new ObjectModels;
//			o.setup();
			
//			var u:UpgradeModels = new UpgradeModels;
//			u.setup();

//			var a:AchementModels = new AchementModels;
//			a.setup();
		}
	}
}
