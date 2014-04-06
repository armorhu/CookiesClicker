package
{
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.display.StageQuality;
	import flash.events.Event;
	
	import agame.endless.EndlessApplication;

	public class shell extends Sprite
	{
		public function shell()
		{
			super();
			stage.frameRate=60;
			stage.quality=StageQuality.LOW;
			NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, activeHandler);
		}

		protected function activeHandler(event:Event):void
		{
			// TODO Auto-generated method stub
			NativeApplication.nativeApplication.removeEventListener(Event.ACTIVATE, activeHandler);
//			try
//			{
//				TestFlighter.setup();
//			}
//			catch (error:Error)
//			{
//
//			}

			var app:EndlessApplication=new EndlessApplication;
			addChild(app)
			app.startup();
		}
	}
}
