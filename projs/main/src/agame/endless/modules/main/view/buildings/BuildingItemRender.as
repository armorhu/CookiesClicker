package agame.endless.modules.main.view.buildings
{
	import com.agame.utils.Beautify;
	import com.agame.utils.DisplayUtil;

	import agame.endless.configs.lang.Lang;
	import agame.endless.configs.texts.TextsTIDDefs;
	import agame.endless.modules.main.model.Game;
	import agame.endless.modules.main.model.buildings.BuildingData;
	import agame.endless.modules.main.model.objects.ObjectData;
	import agame.endless.services.assets.Assets;
	import agame.endless.services.feathers.itemRender.CustomItemRender;
	import agame.endless.services.frame.Enterframe;
	import agame.endless.services.frame.IEnterframe;

	import feathers.controls.Button;
	import feathers.controls.ScrollContainer;
	import feathers.controls.Scroller;
	import feathers.display.TiledImage;

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

		private var _btnSell:Button;

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

			_view.amount.autoScale=true;
			_view.amount.fontName=Assets.FontName;

			_view.cps.autoScale=true;
			_view.cps.fontName=Assets.FontName;

			_view.totalCookies.autoScale=true;
			_view.totalCookies.fontName=Assets.FontName;

			_btnSell=new Button();
			_btnSell.label=Lang(TextsTIDDefs.TID_BUTTON_LABEL_SELL);
			_btnSell.nameList.add(Button.ALTERNATE_NAME_QUIET_BUTTON);
			_btnSell.width=_view.btnSell.width;
			_btnSell.height=_view.btnSell.height;
			DisplayUtil.alignWith(_btnSell, _view.btnSell);

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

			setSize(_viewWidth, _background.height + _view.title.height);

			enterframe();
		}

		override protected function commitData():void
		{
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

			var newWidht:Number=data.bgW > _viewWidth ? data.bgW : _viewWidth;
			if (_background.width != newWidht)
			{
				_background.width=newWidht;
				_scrollContainer.readjustLayout();
				if (data.bgW > _viewWidth)
					_scrollContainer.scrollToPosition(data.bgW - _viewWidth, 0);
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

		private static var helperBuildingData:BuildingData;
		private static var helperObjectData:ObjectData;

		public function enterframe():void
		{
			// TODO Auto Generated method stub
			helperBuildingData=data as BuildingData;
			if (helperBuildingData)
				helperObjectData=Game.ObjectsById[helperBuildingData.id];
			if (helperBuildingData && helperObjectData)
			{
				if (helperObjectData.amount != mAmount)
				{
					mAmount=helperObjectData.amount;
					//render amount
					_view.amount.text=helperObjectData.displayName + ' X' + mAmount;
				}

				if (helperObjectData.storedTotalCps != mCps)
				{
					mCps=helperObjectData.storedTotalCps;
					// render cps
					_view.cps.text='cps:' + Beautify(mCps, 1);
				}

				if (helperObjectData.totalCookies != mTotalCookies)
				{
					mTotalCookies=helperObjectData.totalCookies;
					//render total cookies
					_view.totalCookies.text='total:' + Beautify(mTotalCookies);
				}
			}
			helperBuildingData=null;
			helperObjectData=null;
		}

		override public function set isSelected(value:Boolean):void
		{
			super.isSelected=value;
			_btnSell.visible=value;
		}

	}
}
