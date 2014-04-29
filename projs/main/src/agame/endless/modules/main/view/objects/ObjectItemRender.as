package agame.endless.modules.main.view.objects
{
	import com.agame.utils.Beautify;
	import com.agame.utils.DisplayUtil;
	
	import flash.events.Event;
	import flash.media.SoundChannel;
	
	import agame.endless.modules.main.model.objects.ObjectData;
	import agame.endless.services.assets.Assets;
	import agame.endless.services.feathers.itemRender.CustomItemRender;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Event;
	import starling.extension.starlingide.display.button.StarlingButton;
	import starling.extension.starlingide.display.movieclip.StarlingMovieClip;
	import starling.extension.starlingide.display.textfield.StarlingTextField;
	import starling.utils.VAlign;

	public class ObjectItemRender extends CustomItemRender
	{
		public function ObjectItemRender()
		{
			super();
		}

		private var _icon:Image;
		private var view:StarlingMovieClip;
		private var touchMask:DisplayObject;

		override protected function initialize():void
		{
			if (this.view == null)
			{
				this.view=Assets.current.getLinkageInstance('endless.ui.StoreItemUI') as StarlingMovieClip;
				view.touchMask.visible=false;
				view.disableMask.visible=false;
				view.objName.fontName=Assets.FontName;
				view.price.fontName=Assets.FontName;
				view.num.fontName=Assets.FontName;
				view.objName.autoScale=true;
				view.price.autoScale=true;
				view.num.autoScale=true;
				view.num.vAlign=VAlign.BOTTOM;
				addChild(view);
				setSize(view.width, view.height);
				touchMask=view.touchMask;
				addChild(view.touchMask);
				view.flatten();
				(view.btnInfo as StarlingButton).addEventListener(starling.events.Event.TRIGGERED, triggerdButtonInfo);
			}
		}

		private var ingore:Boolean;

		private function triggerdButtonInfo(evt:starling.events.Event):void
		{
			// TODO Auto Generated method stub
			trace('triggerdButtonInfo');
			ingore=true;
		}

		private var price:Number=0;

		override protected function commitData():void
		{
			var data:ObjectData=this._data as ObjectData;
			if (data)
			{
				view.unflatten();
				if (_icon == null)
				{
					_icon=Assets.current.getLinkageInstance(data.icon) as Image;
					DisplayUtil.alignWith(_icon, view.icon);
				}

				if (!data.lock || data.amount > 0)
					view.objName.text=data.displayName;
				else
					view.objName.text='???';

				if (price != data.price)
				{
					price=data.price;
					view.price.text=Beautify(data.price);
					if (data.canBuy)
					{
						view.disableMask.visible=false;
						(view.price as StarlingTextField).color=0x66FF66;
						isDisabled=false;
					}
					else
					{
						view.disableMask.visible=true;
						(view.price as StarlingTextField).color=0xff0000;
						isDisabled=true;
					}
				}

				if (data.amount > 0)
					view.num.text='' + data.amount;
				else
					view.num.text='';

				_icon.texture=Assets.current.getLinkageTexture(data.icon);
				_icon.color=(data.amount == 0 && data.lock) ? 0x0 : 0xffffff;
				view.flatten();
			}
		}

		override protected function set touchPointID(value:int):void
		{
			super.touchPointID=value;
			touchMask.visible=value >= 0;
		}

		private var sc:SoundChannel;

		override protected function itemClicked():void
		{
			if (ingore)
			{
				ingore=false;
				return;
			}
			trace('itemClicked');
			Assets.current.playSound('select_item');
//			if (isSelected)
//			{
			if (sc == null)
			{
				if (data.id == 1)
				{
					sc=Assets.current.playSound('Grandma');
					if (sc)
						sc.addEventListener(flash.events.Event.SOUND_COMPLETE, soundComplete);
				}
			}
			data.buy();
//			}
		}

//		override public function set isSelected(value:Boolean):void
//		{
//			if (value != isSelected)
//			{
//				if (value)
//					showObjectItemDetial(this);
//				if (value)
//					setSize(view.width, view.height + _objectItemDetial.height);
//				else
//					setSize(view.width, view.height);
//				super.isSelected=value;
//			}
//		}

		private function soundComplete(evt:flash.events.Event):void
		{
			evt.target.removeEventListener(flash.events.Event.SOUND_COMPLETE, soundComplete);
			sc=null;
		}


		private static var _objectItemDetial:StarlingMovieClip;

		public static function showObjectItemDetial(itemRender:ObjectItemRender):void
		{
			if (_objectItemDetial == null)
				_objectItemDetial=Assets.current.getLinkageInstance('endless.ui.ObjectDetailItem') as StarlingMovieClip;

			_objectItemDetial.y=itemRender.view.height;
			itemRender.addChild(_objectItemDetial);
		}
	}
}
