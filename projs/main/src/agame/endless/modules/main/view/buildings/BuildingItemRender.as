package agame.endless.modules.main.view.buildings
{
	import agame.endless.modules.main.model.buildings.BuildingData;
	import agame.endless.modules.main.view.MainStyle;
	import agame.endless.services.assets.Assets;
	import agame.endless.services.feathers.itemRender.CustomItemRender;

	import feathers.controls.ScrollContainer;
	import feathers.controls.Scroller;
	import feathers.display.TiledImage;

	import starling.display.Image;
	import starling.display.QuadBatch;

	/**
	 * 建筑渲染器
	 * @author hufan
	 */
	public class BuildingItemRender extends CustomItemRender
	{
		public function BuildingItemRender()
		{
			super();
		}

		private var _scrollContainer:ScrollContainer;

		private var _background:TiledImage; //背景
		private var _picQuad:QuadBatch; //人物
		private var _picImage:Image;

		override protected function commitData():void
		{
			var data:BuildingData=_data as BuildingData;
			if (_background == null)
			{
				_scrollContainer=new ScrollContainer;
				_scrollContainer.width=MainStyle.BUILDING_VIEW_WIDTH;
				addChild(_scrollContainer);

				_background=new TiledImage(Assets.current.getLinkageTexture(data.bg));
				_scrollContainer.height=_background.height;
				_scrollContainer.addChild(_background);
				_scrollContainer.horizontalScrollPolicy=Scroller.SCROLL_POLICY_ON;

				_picQuad=new QuadBatch;
				_scrollContainer.addChild(_picQuad);
				_picImage=new Image(Assets.current.getLinkageTexture(data.pic));

				setSize(MainStyle.BUILDING_VIEW_WIDTH, _scrollContainer.height);
			}
			else
			{
				_picImage.texture=Assets.current.getLinkageTexture(data.pic);
				_background.texture=Assets.current.getLinkageTexture(data.bg);
			}

			var newWidht:Number=data.bgW > MainStyle.BUILDING_VIEW_WIDTH ? data.bgW : MainStyle.BUILDING_VIEW_WIDTH;
			if (_background.width != newWidht)
			{
				_background.width=newWidht;
				_scrollContainer.readjustLayout();
				if (data.bgW > MainStyle.BUILDING_VIEW_WIDTH)
					_scrollContainer.scrollToPosition(data.bgW - MainStyle.BUILDING_VIEW_WIDTH, 0);
				else
					_scrollContainer.scrollToPosition(0, 0, 0);
			}

			_picQuad.reset();
			var len:int=data.points.length;
			for (var i:int=0; i < len; i++)
			{
				_picImage.x=data.points[i].x;
				_picImage.y=data.points[i].y;
				_picQuad.addImage(_picImage);
			}
		}
	}
}
