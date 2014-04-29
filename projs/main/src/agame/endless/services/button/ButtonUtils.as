package agame.endless.services.button
{
	import flash.geom.Rectangle;

	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class ButtonUtils
	{
		private static var _buttons:Vector.<ButtonItem> //=new Vector.<ButtonItem>();

		public function ButtonUtils()
		{
		}

		public static function buildButton(target:DisplayObject):void
		{
			var item:ButtonItem=getItemByTarget(target);
			if (item == null)
			{
				item=new ButtonItem;
				item.target=target;
				item.touchID=-1;
				item.oriScaleX=target.scaleX;
				item.oriScaleY=target.scaleY;
				target.addEventListener(TouchEvent.TOUCH, touchEventHandler);
				_buttons.push(item);
			}
		}

		public static function destoryButton(target:DisplayObject):void
		{
			var item:ButtonItem=getItemByTarget(target);
			if (item)
			{
				resetButtonItem(item);
				target.removeEventListener(TouchEvent.TOUCH, touchEventHandler);
				_buttons.splice(_buttons.indexOf(item), 1);
			}
		}

		private static function getItemByTarget(target:DisplayObject):ButtonItem
		{
			if (_buttons == null)
				_buttons=new Vector.<ButtonItem>;
			var len:int=_buttons.length;
			for (var i:int=0; i < len; i++)
			{
				if (_buttons[i].target == target)
					return _buttons[i];
			}

			return null;
		}
		private static const MAX_DRAG_DIST:Number=50;

		private static function touchEventHandler(evt:TouchEvent):void
		{
			var target:DisplayObject=evt.currentTarget as DisplayObject;
			var item:ButtonItem=getItemByTarget(target);
			if (item == null)
				return;
			var touch:Touch
			if (item.touchID >= 0)
			{
				touch=evt.getTouch(target, null, item.touchID);
				if (touch)
				{
					if (touch.phase == TouchPhase.ENDED)
					{
						resetButtonItem(item);
						target.dispatchEventWith(Event.TRIGGERED, true);
					}
					else if (touch.phase == TouchPhase.MOVED)
					{
						var buttonRect:Rectangle=target.getBounds(target.stage);
						if (touch.globalX < buttonRect.x - MAX_DRAG_DIST || //
							touch.globalY < buttonRect.y - MAX_DRAG_DIST || //
							touch.globalX > buttonRect.x + buttonRect.width + MAX_DRAG_DIST || // 
							touch.globalY > buttonRect.y + buttonRect.height + MAX_DRAG_DIST)
						{
							resetButtonItem(item);
						}
					}
				}
			}
			else
			{
				touch=evt.getTouch(target, TouchPhase.BEGAN);
				if (touch)
				{
					item.touchID=touch.id;
					item.target.scaleX=item.oriScaleX * 0.9;
					item.target.scaleY=item.oriScaleY * 0.9;
				}
			}
		}

		private static function resetButtonItem(item:ButtonItem):void
		{
			item.touchID=-1;
			item.target.scaleX=item.oriScaleX;
			item.target.scaleY=item.oriScaleY;
		}
	}
}
import starling.display.DisplayObject;


class ButtonItem
{
	public var oriScaleX:Number;
	public var oriScaleY:Number;
	public var target:DisplayObject;
	public var touchID:int=-1;
}
