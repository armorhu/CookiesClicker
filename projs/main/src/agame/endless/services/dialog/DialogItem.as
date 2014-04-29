package agame.endless.services.dialog
{
	import starling.display.DisplayObject;
	import starling.display.Sprite;

	public class DialogItem
	{
		public function DialogItem()
		{
		}
		public var dialog:Sprite;
		public var mask:DisplayObject;
		public var okCall:Function;
		public var cancelCall:Function;
		public var clickHandler:Function;
		public var blankClose:Boolean;
		public var intervalID:int;

		public var oriScaleX:Number;
		public var oriScaleY:Number;

		public function setBlankClose():void
		{
			blankClose=true;
			intervalID=-1;
		}

		public function removeFromParent():void
		{
			dialog.removeFromParent();
			dialog.scaleX=oriScaleX;
			dialog.scaleY=oriScaleY;
		}

	}
}
