package agame.endless.modules.main.view.buildings
{
	import com.agame.utils.Beautify;
	import com.agame.utils.DisplayUtil;

	import flash.geom.Rectangle;

	import agame.endless.configs.lang.Lang;
	import agame.endless.configs.lang.LangPattern;
	import agame.endless.configs.texts.TextsTIDDefs;
	import agame.endless.modules.main.model.Game;
	import agame.endless.modules.main.model.buildings.BuildingData;
	import agame.endless.modules.main.model.objects.ObjectData;
	import agame.endless.services.assets.Assets;
	import agame.endless.services.feathers.itemRender.CustomItemRender;
	import agame.endless.services.frame.Enterframe;
	import agame.endless.services.frame.IEnterframe;

	import feathers.controls.ScrollContainer;
	import feathers.controls.Scroller;
	import feathers.display.TiledImage;

	import starling.core.RenderSupport;
	import starling.display.Image;
	import starling.display.QuadBatch;
	import starling.events.Event;
	import starling.extension.starlingide.display.movieclip.StarlingMovieClip;

	/**
	 * 建筑渲染器
	 * @author hufan
	 */
	public class BuildingItemRender extends CustomItemRender implements IEnterframe
	{
		//ui
		private var _view:StarlingMovieClip;
		private var _viewWidth:Number;
		public var viewHeight:Number;

		public function BuildingItemRender()
		{
			super();
		}

		private var mAmount:int=0;
		private var mCps:Number=0;
		private var mTotalCookies:Number=0;

		override protected function initialize():void
		{
			_view=Assets.current.getLinkageInstance('endless.ui.BuildingItemUI') as StarlingMovieClip;
			addChild(_view);
			_viewWidth=_view.width;
		}

		override protected function addedToStageHandler(event:Event):void
		{
			super.addedToStageHandler(event);
			Enterframe.current.add(this);
		}

		override protected function removedFromStageHandler(event:Event):void
		{
			super.removedFromStageHandler(event);
			Enterframe.current.remove(this);
		}

		private var _scrollContainer:ScrollContainer;
		private var _background:TiledImage; //背景
		private var _picQuad:QuadBatch; //人物
		private var _picImage:Image;


		private var _itemWidth:Number;
		private var _itemHeight:Number;

		private function initWithData():void
		{
			//滚动条。。。。
			_scrollContainer=new ScrollContainer;
			_scrollContainer.width=_viewWidth;
			DisplayUtil.alignWith(_scrollContainer, _view.buildingContent);

			_background=new TiledImage(Assets.current.getLinkageTexture(data.bg));
			_scrollContainer.height=_background.height;
			_scrollContainer.addChild(_background);
			_scrollContainer.horizontalScrollPolicy=Scroller.SCROLL_POLICY_ON;
			_scrollContainer.verticalScrollPolicy=Scroller.SCROLL_POLICY_OFF;
			_scrollContainer.scrollBarDisplayMode=Scroller.SCROLL_BAR_DISPLAY_MODE_FLOAT;

			_picQuad=new QuadBatch;
			_scrollContainer.addChild(_picQuad);
			_picImage=new Image(Assets.current.getLinkageTexture(data.pic));

			viewHeight=_background.height + _view.title.height;
			setSize(_viewWidth, viewHeight);
			enterframe();
		}

		override public function render(support:RenderSupport, parentAlpha:Number):void
		{
			if (_buildingDetail && _buildingDetail.parent == this && Game.T % 5 == 0)
			{
				var storedTotalCps:Number=Game.ObjectsById[int(data.id)].totalCookies;
				_buildingDetail.totalCookies.text=Lang(TextsTIDDefs.TID_COOKIES_BAKED).replace(LangPattern.Number, Beautify(storedTotalCps));
			}

			super.render(support, parentAlpha);
		}

		override protected function commitData():void
		{
			this.unflatten();
			var data:BuildingData=_data as BuildingData;
			if (_background == null)
			{
				initWithData();
			}
			else
			{
				_picImage.texture=Assets.current.getLinkageTexture(data.pic);
				_background.texture=Assets.current.getLinkageTexture(data.bg);
			}

			if (data.id == 1)
			{
				_picImage.scaleX=_picImage.scaleY=1.5;
			}
			else
			{
				_picImage.scaleX=_picImage.scaleY=1.0;
			}
			var newWidht:Number=data.bgW > _viewWidth ? data.bgW : _viewWidth;
			if (_background.width != newWidht)
			{
				_background.width=newWidht;
				_scrollContainer.readjustLayout();
				if (data.bgW > _viewWidth)
					_picQuad.x=_background.x=_viewWidth - data.bgW;
				else
					_picQuad.x=_background.x=0;
			}
			_picQuad.reset();
			var len:int=data.points.length;
			for (var i:int=0; i < len; i++)
			{
				_picImage.x=data.points[i].x;
				_picImage.y=data.points[i].y;
				_picQuad.addImage(_picImage);
			}
			helperObjectData=Game.ObjectsById[data.id];
			_view.amount.text=Lang(TextsTIDDefs.TID_CPS).replace(LangPattern.Number, Beautify(helperObjectData.storedTotalCps, 1));
			this.flatten();
		}

		override public function set isSelected(value:Boolean):void
		{
			if (value != isSelected)
			{
				super.isSelected=value;
				if (value)
				{
					showObjectItemDetial(this);
					setSize(_viewWidth, viewHeight + _buildingDetail.height);
					this.unflatten();
				}
				else
				{
					if (_buildingDetail && _buildingDetail.parent == this)
						_buildingDetail.removeFromParent();
					setSize(_viewWidth, viewHeight);
					this.flatten();
				}
			}
		}

		private static var helperBuildingData:BuildingData;
		private static var helperObjectData:ObjectData;

		public function enterframe():void
		{
			return;
			// TODO Auto Generated method stub
			helperBuildingData=data as BuildingData;
			if (helperBuildingData)
				helperObjectData=Game.ObjectsById[helperBuildingData.id];
			if (helperBuildingData && helperObjectData)
			{
				if (helperObjectData.amount != mAmount || helperObjectData.storedTotalCps != mCps)
				{
					mAmount=helperObjectData.amount;
					//render amount
					mCps=helperObjectData.storedTotalCps;
					// render cps
					_view.amount.text=helperObjectData.displayName + ' X' + mAmount + '(cps=' + Beautify(mCps, 1) + ')';
				}
			}
			helperBuildingData=null;
			helperObjectData=null;
		}

		override public function setSize(width:Number, height:Number):void
		{
			this.clipRect=new Rectangle(0, 0, width, height);
			super.setSize(width, height);
		}


		private static var _buildingDetail:StarlingMovieClip;


		public static function showObjectItemDetial(itemRender:BuildingItemRender):void
		{
			if (_buildingDetail == null)
				_buildingDetail=Assets.current.getLinkageInstance('endless.ui.BuildingDetailItemUI') as StarlingMovieClip;
			_buildingDetail.y=itemRender.viewHeight;
			itemRender.addChild(_buildingDetail);
		}
	}
}
