package agame.endless.services.feathers.theme
{
	import flash.display.Bitmap;
	import flash.geom.Rectangle;
	import flash.text.TextFormatAlign;
	import flash.text.engine.CFFHinting;
	import flash.text.engine.ElementFormat;
	import flash.text.engine.FontDescription;
	import flash.text.engine.FontLookup;
	import flash.text.engine.FontPosture;
	import flash.text.engine.FontWeight;
	import flash.text.engine.RenderingMode;
	
	import agame.endless.services.assets.Assets;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.SimpleScrollBar;
	import feathers.core.DisplayListWatcher;
	import feathers.display.Scale3Image;
	import feathers.skins.SmartDisplayObjectStateValueSelector;
	import feathers.text.BitmapFontTextFormat;
	import feathers.textures.Scale3Textures;
	import feathers.textures.Scale9Textures;
	
	import starling.display.DisplayObjectContainer;
	import starling.text.TextField;

	public class GameTheme extends DisplayListWatcher
	{
		protected static const THEME_NAME_HORIZONTAL_SIMPLE_SCROLL_BAR_THUMB:String="metal-works-mobile-horizontal-simple-scroll-bar-thumb";
		protected static const THEME_NAME_VERTICAL_SIMPLE_SCROLL_BAR_THUMB:String="metal-works-mobile-vertical-simple-scroll-bar-thumb";

		protected var scale:Number=1;

		protected var buttonUpSkinTextures:Scale9Textures;
		protected var buttonDownSkinTextures:Scale9Textures;
		protected var buttonDisabledSkinTextures:Scale9Textures;
		protected var buttonSelectedUpSkinTextures:Scale9Textures;
		protected var buttonSelectedDisabledSkinTextures:Scale9Textures;
//		protected var buttonCallToActionUpSkinTextures:Scale9Textures;
//		protected var buttonCallToActionDownSkinTextures:Scale9Textures;
//		protected var buttonDangerUpSkinTextures:Scale9Textures;
//		protected var buttonDangerDownSkinTextures:Scale9Textures;
//		protected var buttonBackUpSkinTextures:Scale3Textures;
//		protected var buttonBackDownSkinTextures:Scale3Textures;
//		protected var buttonBackDisabledSkinTextures:Scale3Textures;
//		protected var buttonForwardUpSkinTextures:Scale3Textures;
//		protected var buttonForwardDownSkinTextures:Scale3Textures;
//		protected var buttonForwardDisabledSkinTextures:Scale3Textures;
		protected var verticalScrollBarThumbSkinTextures:Scale3Textures;
		protected var horizontalScrollBarThumbSkinTextures:Scale3Textures;

		protected var darkUIDisabledElementFormat:ElementFormat;
		protected var darkUIElementFormat:ElementFormat;


		protected static const DEFAULT_SCALE9_GRID:Rectangle=new Rectangle(5, 5, 22, 22);
		protected static const BUTTON_SCALE9_GRID:Rectangle=new Rectangle(5, 5, 50, 50);
		protected static const BUTTON_SELECTED_SCALE9_GRID:Rectangle=new Rectangle(8, 8, 44, 44);
		protected static const BACK_BUTTON_SCALE3_REGION1:Number=24;
		protected static const BACK_BUTTON_SCALE3_REGION2:Number=6;
		protected static const FORWARD_BUTTON_SCALE3_REGION1:Number=6;
		protected static const FORWARD_BUTTON_SCALE3_REGION2:Number=6;
		protected static const ITEM_RENDERER_SCALE9_GRID:Rectangle=new Rectangle(13, 0, 2, 82);
		protected static const INSET_ITEM_RENDERER_FIRST_SCALE9_GRID:Rectangle=new Rectangle(13, 13, 3, 70);
		protected static const INSET_ITEM_RENDERER_LAST_SCALE9_GRID:Rectangle=new Rectangle(13, 0, 3, 75);
		protected static const INSET_ITEM_RENDERER_SINGLE_SCALE9_GRID:Rectangle=new Rectangle(13, 13, 3, 62);
		protected static const TAB_SCALE9_GRID:Rectangle=new Rectangle(19, 19, 50, 50);
		protected static const SCROLL_BAR_THUMB_REGION1:int=5;
		protected static const SCROLL_BAR_THUMB_REGION2:int=14;

		protected var boldFontDescription:FontDescription;

		protected static const DARK_TEXT_COLOR:uint=0xffffff;
		protected static const DARK_DISABLED_TEXT_COLOR:uint=0x666666;

		private var atlas:Assets;

		public function GameTheme(topLevelContainer:DisplayObjectContainer)
		{
			super(topLevelContainer);
			initliaze();
		}

		private function initliaze():void
		{
			atlas=Assets.current;

			initFonts();
			initTextures();
			setInitializerForClass(Button, buttonInitializer);


			this.setInitializerForClass(SimpleScrollBar, simpleScrollBarInitializer);
			this.setInitializerForClass(Button, horizontalSimpleScrollBarThumbInitializer, THEME_NAME_HORIZONTAL_SIMPLE_SCROLL_BAR_THUMB);
			this.setInitializerForClass(Button, verticalSimpleScrollBarThumbInitializer, THEME_NAME_VERTICAL_SIMPLE_SCROLL_BAR_THUMB);
			
			
			this.horizontalScrollBarThumbSkinTextures = new Scale3Textures(this.atlas.getLinkageTexture("horizontal_scroll_bar_thumb_skin"), SCROLL_BAR_THUMB_REGION1, SCROLL_BAR_THUMB_REGION2, Scale3Textures.DIRECTION_HORIZONTAL);
			this.verticalScrollBarThumbSkinTextures = new Scale3Textures(this.atlas.getLinkageTexture("vertical_scroll_bar_thumb_skin"), SCROLL_BAR_THUMB_REGION1, SCROLL_BAR_THUMB_REGION2, Scale3Textures.DIRECTION_VERTICAL);
		}

		protected function simpleScrollBarInitializer(scrollBar:SimpleScrollBar):void
		{
			if (scrollBar.direction == SimpleScrollBar.DIRECTION_HORIZONTAL)
			{
				scrollBar.paddingRight=scrollBar.paddingBottom=scrollBar.paddingLeft=4 * this.scale;
				scrollBar.customThumbName=THEME_NAME_HORIZONTAL_SIMPLE_SCROLL_BAR_THUMB;
			}
			else
			{
				scrollBar.paddingTop=scrollBar.paddingRight=scrollBar.paddingBottom=4 * this.scale;
				scrollBar.customThumbName=THEME_NAME_VERTICAL_SIMPLE_SCROLL_BAR_THUMB;
			}
		}

		protected function horizontalSimpleScrollBarThumbInitializer(thumb:Button):void
		{
			var defaultSkin:Scale3Image=new Scale3Image(this.horizontalScrollBarThumbSkinTextures, this.scale);
			defaultSkin.width=10 * this.scale;
			thumb.defaultSkin=defaultSkin;
		}

		protected function verticalSimpleScrollBarThumbInitializer(thumb:Button):void
		{
			var defaultSkin:Scale3Image=new Scale3Image(this.verticalScrollBarThumbSkinTextures, this.scale);
			defaultSkin.height=10 * this.scale;
			thumb.defaultSkin=defaultSkin;
		}

		private function initFonts():void
		{
			this.boldFontDescription=new FontDescription('SourceSansPro', FontWeight.NORMAL, FontPosture.NORMAL, FontLookup.EMBEDDED_CFF, RenderingMode.CFF, CFFHinting.NONE);
			// TODO Auto Generated method stub
			this.darkUIElementFormat=new ElementFormat(this.boldFontDescription, 24 * this.scale, DARK_TEXT_COLOR);
			this.darkUIDisabledElementFormat=new ElementFormat(this.boldFontDescription, 24 * this.scale, DARK_DISABLED_TEXT_COLOR);
		}

		private function initTextures():void
		{
			// TODO Auto Generated method stub
			this.buttonUpSkinTextures=new Scale9Textures(this.atlas.getLinkageTexture("button_up_skin"), BUTTON_SCALE9_GRID);
			this.buttonDownSkinTextures=new Scale9Textures(this.atlas.getLinkageTexture("button_down_skin"), BUTTON_SCALE9_GRID);
			this.buttonDisabledSkinTextures=new Scale9Textures(this.atlas.getLinkageTexture("button_disabled_skin"), BUTTON_SCALE9_GRID);
			this.buttonSelectedUpSkinTextures=new Scale9Textures(this.atlas.getLinkageTexture("button_selected_up_skin"), BUTTON_SELECTED_SCALE9_GRID);
			this.buttonSelectedDisabledSkinTextures=new Scale9Textures(this.atlas.getLinkageTexture("button_selected_disabled_skin"), BUTTON_SELECTED_SCALE9_GRID);
//			this.buttonCallToActionUpSkinTextures=new Scale9Textures(this.atlas.getLinkageTexture("button-call-to-action-up-skin"), BUTTON_SCALE9_GRID);
//			this.buttonCallToActionDownSkinTextures=new Scale9Textures(this.atlas.getLinkageTexture("button-call-to-action-down-skin"), BUTTON_SCALE9_GRID);
//			this.buttonDangerUpSkinTextures=new Scale9Textures(this.atlas.getLinkageTexture("button-danger-up-skin"), BUTTON_SCALE9_GRID);
//			this.buttonDangerDownSkinTextures=new Scale9Textures(this.atlas.getLinkageTexture("button-danger-down-skin"), BUTTON_SCALE9_GRID);
//			this.buttonBackUpSkinTextures=new Scale3Textures(this.atlas.getLinkageTexture("button-back-up-skin"), BACK_BUTTON_SCALE3_REGION1, BACK_BUTTON_SCALE3_REGION2);
//			this.buttonBackDownSkinTextures=new Scale3Textures(this.atlas.getLinkageTexture("button-back-down-skin"), BACK_BUTTON_SCALE3_REGION1, BACK_BUTTON_SCALE3_REGION2);
//			this.buttonBackDisabledSkinTextures=new Scale3Textures(this.atlas.getLinkageTexture("button-back-disabled-skin"), BACK_BUTTON_SCALE3_REGION1, BACK_BUTTON_SCALE3_REGION2);
//			this.buttonForwardUpSkinTextures=new Scale3Textures(this.atlas.getLinkageTexture("button-forward-up-skin"), FORWARD_BUTTON_SCALE3_REGION1, FORWARD_BUTTON_SCALE3_REGION2);
//			this.buttonForwardDownSkinTextures=new Scale3Textures(this.atlas.getLinkageTexture("button-forward-down-skin"), FORWARD_BUTTON_SCALE3_REGION1, FORWARD_BUTTON_SCALE3_REGION2);
//			this.buttonForwardDisabledSkinTextures=new Scale3Textures(this.atlas.getLinkageTexture("button-forward-disabled-skin"), FORWARD_BUTTON_SCALE3_REGION1, FORWARD_BUTTON_SCALE3_REGION2);

		}

		private function initLabel(label:Label):void
		{
			// TODO Auto Generated method stub
		}

		protected function buttonInitializer(button:Button):void
		{
			const skinSelector:SmartDisplayObjectStateValueSelector=new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue=this.buttonUpSkinTextures;
			skinSelector.defaultSelectedValue=this.buttonSelectedUpSkinTextures;
			skinSelector.setValueForState(this.buttonDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.buttonDisabledSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.setValueForState(this.buttonSelectedDisabledSkinTextures, Button.STATE_DISABLED, true);
			skinSelector.displayObjectProperties={width: 60 * this.scale, height: 60 * this.scale, textureScale: this.scale};
			button.stateToSkinFunction=skinSelector.updateValue;
			this.baseButtonInitializer(button);
		}

		protected function baseButtonInitializer(button:Button):void
		{
			button.defaultLabelProperties.textFormat=new BitmapFontTextFormat(Assets.FontName, 24 * this.scale, DARK_TEXT_COLOR, TextFormatAlign.CENTER);
//			button.disabledLabelProperties.textFormat=this.darkUIDisabledElementFormat;
//			button.selectedDisabledLabelProperties.textFormat=this.darkUIDisabledElementFormat;

			button.paddingTop=button.paddingBottom=4 * this.scale;
			button.paddingLeft=button.paddingRight=8 * this.scale;
			button.gap=2 * this.scale;
			button.minWidth=button.minHeight=60 * this.scale;
			button.minTouchWidth=button.minTouchHeight=88 * this.scale;
		}

		private function initList(list:List):void
		{
			// TODO Auto Generated method stub
		}

	}
}
