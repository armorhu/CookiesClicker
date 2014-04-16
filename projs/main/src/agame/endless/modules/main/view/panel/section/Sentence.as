package agame.endless.modules.main.view.panel.section
{
	import agame.endless.services.assets.Assets;

	import starling.core.RenderSupport;
	import starling.display.QuadBatch;
	import starling.utils.HAlign;

	public class Sentence extends QuadBatch
	{
		private var mHead:String;
		private var mContext:String;

		private var textWidth:Number=560;
		private var textHeight:Number=40;
		private var fontSzie:Number=30;
		private var headColor:uint=0x999999;
		private var contextColor:uint=0xfffff;

		private var needRenderText:Boolean;

		public function Sentence(width:Number, height:Number, fontSize:Number, headColor:uint, contextColor:uint)
		{
			this.textWidth=width;
			this.textHeight=height;
			this.fontSzie=fontSize;
			this.headColor=headColor;
			this.contextColor=contextColor;
		}

		public function set head(value:String):void
		{
			if (head == value)
				return;
			mHead=value;
			needRenderText=true;
		}

		public function get head():String
		{
			return mHead
		}



		public function set context(value:String):void
		{
			if (mContext == value)
				return;
			mContext=value;
			needRenderText=true;
		}

		public function get context():String
		{
			return mContext
		}

		override public function render(support:RenderSupport, parentAlpha:Number):void
		{
			if (needRenderText)
			{
				renderText();
				needRenderText=false;
			}
			super.render(support, parentAlpha);
		}

		private function renderText():void
		{
			reset();
			Assets.current.particleBmFont.fillQuadBatch(0, 0, 1, 0, this, headColor, Assets.current.particleBmFont.arrangeChars(textWidth, textHeight, mHead, fontSzie, HAlign.LEFT));
			Assets.current.particleBmFont.fillQuadBatch(bounds.width, 0, 1, 0, this, contextColor, Assets.current.particleBmFont.arrangeChars(textWidth, textHeight, mContext, fontSzie, HAlign.LEFT));
		}

		override public function get width():Number
		{
			return textWidth;
		}

		override public function get height():Number
		{
			return textHeight;
		}
	}
}
