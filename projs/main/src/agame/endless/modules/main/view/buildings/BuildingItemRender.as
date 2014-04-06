package agame.endless.modules.main.view.buildings
{
	import flash.geom.Rectangle;

	import agame.endless.modules.main.model.buildings.BuildingData;
	import agame.endless.services.assets.Assets;
	import agame.endless.services.feathers.itemRender.CustomItemRender;

	import feathers.display.TiledImage;

	import starling.display.Image;
	import starling.display.QuadBatch;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	/**
	 * 建筑渲染器
	 * @author hufan
	 */
	public class BuildingItemRender extends CustomItemRender
	{
		public static var VIEW_WIDTH:Number=0;

		public function BuildingItemRender()
		{
			super();
		}

		private var _background:TiledImage; //背景
		private var _picQuad:QuadBatch; //人物
		private var _picImage:Image;

		override protected function commitData():void
		{
			var data:BuildingData=_data as BuildingData;
			if (_background == null)
			{
				_background=new TiledImage(Assets.current.getLinkageTexture(data.bg));
				addChild(_background);
				_picQuad=new QuadBatch;
				addChild(_picQuad);
				_picImage=new Image(Assets.current.getLinkageTexture(data.pic));
				this.clipRect=new Rectangle(0, 0, VIEW_WIDTH, _background.height);
				setSize(VIEW_WIDTH, clipRect.height);
			}
			else
			{
				_picImage.texture=Assets.current.getLinkageTexture(data.pic);
			}
			_background.width=data.bgW > VIEW_WIDTH ? data.bgW : VIEW_WIDTH;
			if (data.bgW > VIEW_WIDTH)
				setContextPostion(VIEW_WIDTH - data.bgW);
			
			_picQuad.reset();
			var len:int=data.points.length;
			for (var i:int=0; i < len; i++)
			{
				_picImage.x=data.points[i].x;
				_picImage.y=data.points[i].y;
				_picQuad.addImage(_picImage);
			}
		}

		override protected function touchHandler(event:TouchEvent):void
		{
			super.touchHandler(event);
			var data:BuildingData=_data as BuildingData;
			if (touchPointID >= 0 && data.bgW >= VIEW_WIDTH)
			{
				var touch:Touch=event.getTouch(this, TouchPhase.MOVED);
				if (touch)
					setContextPostion(_background.x + touch.globalX - touch.previousGlobalX);
			}
		}

		private function setContextPostion(px:int):void
		{
			if (px > 0)
				px=0;
			else if (px < VIEW_WIDTH - data.bgW)
				px=VIEW_WIDTH - data.bgW;
			_background.x=px;
			_picQuad.x=px;
		}
	}
}
