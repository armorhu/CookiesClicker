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
		}
	}
}
