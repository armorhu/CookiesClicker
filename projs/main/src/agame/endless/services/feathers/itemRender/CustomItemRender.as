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
			this.addEventListener(TouchEvent.TOUCH, accessory_touchHandler);
			this.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
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
//			this.width=this.actualWidth;
//			this.height=this.actualHeight;
		}

		protected function removedFromStageHandler(event:Event):void
		{
			this.touchPointID=-1;
		}

		protected function addedToStageHandler(event:Event):void
		{
		}



		/**
		 * @private
		 */
		protected function accessory_touchHandler(event:TouchEvent):void
		{
			if (!this.isDisabled)
				return;

			if (this.touchPointID >= 0)
			{
				var touch:Touch=event.getTouch(this, TouchPhase.ENDED, this.touchPointID);
				if (!touch)
				{
					return;
				}
				this.touchPointID=-1;
			}
			else //if we get here, we don't have a saved touch ID yet
			{
				touch=event.getTouch(this, TouchPhase.BEGAN);
				if (touch)
				{
					itemClicked();
					if (!this._isSelected)
						this.isSelected=true;
					this.touchPointID=touch.id;
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

		protected function itemClicked():void
		{
		}

		override public function dispose():void
		{
			this.removeEventListener(TouchEvent.TOUCH, accessory_touchHandler);
			this.removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			super.dispose();
		}
		private var _disabled:Boolean=false;

		public function get isDisabled():Boolean
		{
			return _disabled;
		}

		public function set isDisabled(value:Boolean):void
		{
			if (_disabled != value)
			{
				_disabled=value;
				touchPointID=-1;
			}
		}

	}
}
