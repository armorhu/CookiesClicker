package
{
	import flash.display.Sprite;
	import flash.display.StageQuality;
	import flash.events.Event;
	
	import agame.endless.EndlessApplication;
	
	import testflight.TestFlighter;

	public class shell extends Sprite
	{
		public function shell()
		{
			super();
			stage.frameRate=30;
			stage.quality=StageQuality.LOW;
			
			try
			{
				TestFlighter.setup();
			}
			catch (error:Error)
			{
			}
			
			var app:EndlessApplication=new EndlessApplication;
			addChild(app)
			app.startup();
		}

		protected function activeHandler(event:Event):void
		{
			// TODO Auto-generated method stub
//			NativeApplication.nativeApplication.removeEventListener(Event.ACTIVATE, activeHandler);

		}
	}
}
