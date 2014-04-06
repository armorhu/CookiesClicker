package agame.endless.modules.main.view.objects
{
	import com.agame.utils.Beautify;

	import flash.events.Event;
	import flash.media.SoundChannel;

	import agame.endless.modules.main.model.objects.ObjectData;
	import agame.endless.services.assets.Assets;
	import agame.endless.services.feathers.itemRender.CustomItemRender;

	import starling.display.Image;
	import starling.extension.starlingide.display.movieclip.StarlingMovieClip;
	import starling.extension.starlingide.display.textfield.StarlingTextField;

	public class ObjectItemRender extends CustomItemRender
	{
		public function ObjectItemRender()
		{
			super();
		}

		private var _icon:Image;
		private var view:StarlingMovieClip;

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
				addChild(view);

				setSize(view.width, view.height);
			}
		}

		override protected function commitData():void
		{
			if (data)
			{
				if (_icon == null)
				{
					_icon=Assets.current.getLinkageInstance(data.icon) as Image;
					view.addChildAt(_icon, 1);
				}

				if (!data.lock || data.amount > 0)
					view.objName.text=data.name;
				else
					view.objName.text='???';
				view.price.text=Beautify(data.getPrice());
				if (data.amount > 0)
					view.num.text='' + data.amount;
				else
					view.num.text='';
				disable=data.disable;
				_icon.color=(data.amount == 0 && data.disable) ? 0x0 : 0xffffff;
			}
		}

		protected function get data():ObjectData
		{
			return _data as ObjectData;
		}

		override protected function set touchPointID(value:int):void
		{
			super.touchPointID=value;
//			this.unflatten()
			view.touchMask.visible=value >= 0;
//			this.flatten();
		}

		override protected function set disable(value:Boolean):void
		{
			super.disable=value;
			view.disableMask.visible=value;
			if (value)
			{
				view.alpha=0.5;
				(view.price as StarlingTextField).color=0xff0000;
			}
			else
			{
				view.alpha=1;
				(view.price as StarlingTextField).color=0x66FF66;
			}
		}

		private var sc:SoundChannel;

		override protected function itemClicked():void
		{
			if (sc == null)
			{
				if (data.id == 1)
				{
					sc=Assets.current.playSound('Grandma');
					sc.addEventListener(flash.events.Event.SOUND_COMPLETE, soundComplete);
				}
			}
			Assets.current.playSound('select_item');
			data.buy();
		}

		private function soundComplete(evt:flash.events.Event):void
		{
			sc.removeEventListener(flash.events.Event.SOUND_COMPLETE, soundComplete);
			sc=null;
		}
	}
}
