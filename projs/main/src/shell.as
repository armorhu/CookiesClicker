package
{
	import com.gamua.flox.Flox;

	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageOrientation;
	import flash.display.StageQuality;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.StageOrientationEvent;
	import flash.media.AudioPlaybackMode;
	import flash.media.SoundMixer;
	import flash.ui.Keyboard;

	import agame.endless.EndlessApplication;
	import agame.endless.Version;

	public class shell extends Sprite
	{
		public static var loading:MovieClip;

		public function shell()
		{
			super();
			stage.color=0x0;
			Flox.init("Hv0X8ifOth3lKT7I", "1HtonojNasIz51PO", Version);
			stage.frameRate=60;
			stage.quality=StageQuality.LOW;
			loading=new LoadingBar;
			addChild(loading);
			loading.x=960 - loading.width;
			loading.y=640 - loading.height;
			loading.txt.text='Loading...';
			NativeApplication.nativeApplication.systemIdleMode=SystemIdleMode.KEEP_AWAKE; //保持屏幕唤醒
			stage.addEventListener(StageOrientationEvent.ORIENTATION_CHANGING, onOrientationChanging);
			NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, keyHandler);
			SoundMixer.audioPlaybackMode=AudioPlaybackMode.AMBIENT;
			try
			{
//				TestFlighter.setup();
			}
			catch (error:Error)
			{
			}

			var app:EndlessApplication=new EndlessApplication;
			addChild(app)
			app.startup();
		}

		protected function keyHandler(event:KeyboardEvent):void
		{
			// TODO Auto-generated method stub
			if (event.keyCode == Keyboard.BACK)
			{
				//android...
			}
		}

		/**only support landscape mode*/
		private function onOrientationChanging(event:StageOrientationEvent):void
		{
			// If the stage is about to move to an orientation we don't support, lets prevent it 
			// from changing to that stage orientation. 
			if (event.afterOrientation == StageOrientation.UPSIDE_DOWN || event.afterOrientation == StageOrientation.DEFAULT)
				event.preventDefault();
		}

		protected function activeHandler(event:Event):void
		{
			// TODO Auto-generated method stub
//			NativeApplication.nativeApplication.removeEventListener(Event.ACTIVATE, activeHandler);
		}
	}
}
