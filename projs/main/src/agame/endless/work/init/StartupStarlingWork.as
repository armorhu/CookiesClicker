package agame.endless.work.init
{
	import flash.display.Bitmap;
	import flash.geom.Rectangle;

	import agame.endless.EndlessApplication;
	import agame.endless.appStage;
	import agame.endless.enm.EnmModuleName;
	import agame.endless.modules.main.ModuleMain;
	import agame.endless.services.assets.Assets;
	import agame.endless.work.EndlessWork;

	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extension.starlingide.display.textfield.StarlingTextField;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;

	public class StartupStarlingWork extends EndlessWork
	{
		protected var m_starling:Starling;
		protected var viewPort:Rectangle;

		public function StartupStarlingWork(app:EndlessApplication)
		{
			super(app);
		}

		override public function start():void
		{
			viewPort=new Rectangle();
			viewPort.width=Math.max(appStage.fullScreenWidth, appStage.fullScreenHeight);
			viewPort.height=Math.min(appStage.fullScreenWidth, appStage.fullScreenHeight);

			Starling.handleLostContext=true; //android建议处理
			m_starling=new Starling(StarlingRoot, appStage, viewPort);
			m_starling.addEventListener(Event.ROOT_CREATED, onCreateContext3d);
			m_starling.simulateMultitouch=false;
			m_starling.enableErrorChecking=false;
			m_starling.showStats=true;
		}


		/**
		 * Context3d构造成功
		 * @param e
		 */
		private function onCreateContext3d(e:Event):void
		{
			e.target.removeEventListener(Event.ROOT_CREATED, onCreateContext3d);

			registeStarlingModule();

			registeBitmapFont();

			Starling.current.start();
			workComplete();
		}

		private function registeBitmapFont():void
		{
			//注册位图字体
			var bitmap:Bitmap=new EmbedFont.BitmapChars();
			var xml:XML=XML(new EmbedFont.BritannicXML());
			var bitmapFont:BitmapFont=new BitmapFont(Texture.fromBitmap(bitmap), xml);
			Assets.FontName='fontsss';
			StarlingTextField.registerBitmapFont(bitmapFont, Assets.FontName);
			TextField.registerBitmapFont(bitmapFont, Assets.FontName);
		}

		protected function registeStarlingModule():void
		{
			//注册主场景模块
			var layer:Sprite=new Sprite;
			Starling.current.stage.addChild(layer);
			app.registerModule(EnmModuleName.Main, ModuleMain, layer);
		}
	}
}

import starling.display.Sprite;

class StarlingRoot extends Sprite
{
}
