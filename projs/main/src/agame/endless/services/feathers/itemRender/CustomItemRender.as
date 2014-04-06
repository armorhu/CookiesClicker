package agame.endless.services.feathers.itemRender
{
	import flash.geom.Point;

	import feathers.controls.List;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.core.FeathersControl;

	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class CustomItemRender extends FeathersControl implements IListItemRenderer
	{
		private static const HELPER_POINT:Point=new Point();


		public function CustomItemRender()
		{
			this.addEventListener(TouchEvent.TOUCH, touchHandler);
			this.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);

		}

		protected var _index:int=-1;

		public function get index():int
		{
			return this._index;
		}

		public function set index(value:int):void
		{
			if (this._index == value)
			{
				return;
			}
			this._index=value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}

		protected var _owner:List;

		public function get owner():List
		{
			return List(this._owner);
		}

		public function set owner(value:List):void
		{
			if (this._owner == value)
			{
				return;
			}
			if (this._owner)
			{
				this._owner.removeEventListener(Event.SCROLL, owner_scrollHandler);
			}
			this._owner=value;
			if (this._owner)
			{
				this._owner.addEventListener(Event.SCROLL, owner_scrollHandler);
			}
			this.invalidate(INVALIDATION_FLAG_DATA);
		}

		protected function owner_scrollHandler(event:Event):void
		{
			this.touchPointID=-1;
		}
		protected var _data:Object;

		public function get data():Object
		{
			return this._data;
		}

		public function set data(value:Object):void
		{
			if (this._data == value)
			{
				return;
			}
			this._data=value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}

		protected var _isSelected:Boolean;

		public function get isSelected():Boolean
		{
			return this._isSelected;
		}

		public function set isSelected(value:Boolean):void
		{
			if (this._isSelected == value)
			{
				return;
			}
			this._isSelected=value;
			this.invalidate(INVALIDATION_FLAG_SELECTED);
			this.dispatchEventWith(Event.CHANGE);
		}

		override protected function initialize():void
		{
		}

		override protected function draw():void
		{
			const dataInvalid:Boolean=this.isInvalid(INVALIDATION_FLAG_DATA);
			const selectionInvalid:Boolean=this.isInvalid(INVALIDATION_FLAG_SELECTED);
			var sizeInvalid:Boolean=this.isInvalid(INVALIDATION_FLAG_SIZE);

			if (dataInvalid)
			{
				this.commitData();
			}


			if (dataInvalid || sizeInvalid)
			{
				this.layout();
			}
		}

		protected function commitData():void
		{
		}

		protected function layout():void
		{
			this.width=this.actualWidth;
			this.height=this.actualHeight;
		}

		protected function removedFromStageHandler(event:Event):void
		{
			this.touchPointID=-1;
		}

		protected function touchHandler(event:TouchEvent):void
		{
			if (disable)
				return;
			const touches:Vector.<Touch>=event.getTouches(this);
			if (touches.length == 0)
			{
				//hover has ended
				return;
			}
			if (this.touchPointID >= 0)
			{
				var touch:Touch;
				for each (var currentTouch:Touch in touches)
				{
					if (currentTouch.id == this.touchPointID)
					{
						touch=currentTouch;
						break;
					}
				}
				if (!touch)
				{
					return;
				}
				if (touch.phase == TouchPhase.ENDED)
				{
					this.touchPointID=-1;

					touch.getLocation(this, HELPER_POINT);
					//check if the touch is still over the target
					//also, only change it if we're not selected. we're not a toggle.
					if (this.hitTest(HELPER_POINT, true) != null)
					{
						itemClicked();
						if (!this._isSelected)
							this.isSelected=true;
					}
					return;
				}
			}
			else
			{
				for each (touch in touches)
				{
					if (touch.phase == TouchPhase.BEGAN)
					{
						this.touchPointID=touch.id;
						return;
					}
				}
			}
		}

		private var _touchPointID:int=-1;

		protected function get touchPointID():int
		{
			return _touchPointID;
		}

		protected function set touchPointID(value:int):void
		{
			_touchPointID=value;
		}

		private var _disable:Boolean;

		protected function get disable():Boolean
		{
			return _disable;
		}

		protected function set disable(value:Boolean):void
		{
			_disable=value;
			if (value)
				touchable=-1;
		}


		protected function itemClicked():void
		{

		}
	}
}
