package agame.endless.modules.main.view
{
	import com.greensock.TimelineMax;
	import com.greensock.TweenLite;

	import agame.endless.modules.main.model.Game;
	import agame.endless.modules.main.view.buildings.BuildingItemRender;
	import agame.endless.modules.main.view.objects.ObjectItemRender;
	import agame.endless.modules.main.view.particle.CookieParticleSystem;
	import agame.endless.modules.main.view.upgrades.UpgradeItemRender;
	import agame.endless.services.assets.Assets;
	import agame.endless.services.frame.IEnterframe;

	import feathers.controls.List;
	import feathers.controls.Scroller;
	import feathers.data.ListCollection;
	import feathers.layout.TiledRowsLayout;

	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.QuadBatch;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extension.starlingide.display.movieclip.StarlingMovieClip;
	import starling.extension.starlingide.display.textfield.StarlingTextField;

	public class MainView extends Sprite implements IEnterframe
	{
		public static const CLICK_COOKIE:String='click_cookie';

		public var content:StarlingMovieClip;
		public var cookies:StarlingTextField; //饼干数量
		public var cps:StarlingTextField; //cps.

		/**
		 *粒子系统
		 */
		private var _cookieParticleSystem:CookieParticleSystem;

		private var _shine:StarlingMovieClip; //shine；
		private var _shine2:StarlingMovieClip; //shine2;


		private var _buttomCanvas:QuadBatch;
		private var _upCanvas:QuadBatch;
		private var _textCanvas:QuadBatch;

		private var _bigCookie:DisplayObject;

		public function MainView()
		{
			super();
			initiliaze();
		}

		private function initiliaze():void
		{
//			new MetalWorksMobileTheme;
//			new MinimalMobileTheme;

			content=Assets.current.getLinkageInstance('endless.ui.MainUIView') as StarlingMovieClip;
			addChild(content);
			content.addEventListener(Event.TRIGGERED, triggeredMeHandler);


			_buttomCanvas=new QuadBatch(); //最下面的画布
			_upCanvas=new QuadBatch(); //最上面的画布
			_textCanvas=new QuadBatch(); //位图字体的画布
			content.cookieCenter.particleContainer.addChild(_buttomCanvas);
			content.cookieCenter.particleCotnainer2.addChild(_upCanvas);
			content.cookieCenter.particleCotnainer2.addChild(_textCanvas);
			(content.cookieCenter.particleContainer as DisplayObject).touchable=false;
			(content.cookieCenter.particleCotnainer2 as DisplayObject).touchable=false;
			_bigCookie=content.cookieCenter.bigCookie;
			//particles
			_cookieParticleSystem=new CookieParticleSystem(content.cookieCenter.cookiesLabel.x, content.cookieCenter.cookiesLabel.width);

			//cursers
			curserImg=Assets.current.getLinkageInstance('cursor') as Image;

			cookies=content.cookieCenter.cookiesLabel;
			cookies.fontName=Assets.FontName;
			cookies.autoScale=true;
			cps=content.cookieCenter.cpsLabel;
			cps.fontName=Assets.FontName;
			cps.autoScale=true;
			_shine=content.cookieCenter.shine;
			_shine2=content.cookieCenter.shine2;
			_shine.alpha=0.2;
			_shine2.alpha=0.2;
			_shine.flatten();
			_shine2.flatten();

			(content.newsTickerLabel as StarlingTextField).fontName=Assets.FontName;
			(content.newsTickerLabel as StarlingTextField).autoScale=true;

			initStoreList();
			initBuildingList();
			initUpgradesStoreList();
		}

		private function alignWith(source:DisplayObject, target:DisplayObject):void
		{
			source.x=target.x;
			source.y=target.y;
			var parentIndex:int=target.parent.getChildIndex(target);
			target.parent.addChildAt(source, parentIndex);
			target.parent.removeChild(target);
		}

		private function triggeredMeHandler(evt:Event):void
		{
			var targetName:String=evt.target['name'];
			if (targetName == 'bigCookie')
				dispatchEventWith(CLICK_COOKIE);
		}


		public function particleAdd(x:Number=0, y:Number=0, xd:Number=0, yd:Number=0, size:int=0, dur:Number=0, z:Number=0, pic:String=null, text:String=null):void
		{
			_cookieParticleSystem.particleAdd(x, y, xd, yd, size, dur, z, pic, text);
		}

		private var randnum:Number;

		public function enterframe():void
		{
			// TODO Auto Generated method stub
			_buttomCanvas.reset();
			_upCanvas.reset();
			_textCanvas.reset();

			_cookieParticleSystem.particlesDraw(_buttomCanvas, _upCanvas, _textCanvas);
			drawCurser();

			_shine.rotation+=0.02;
			_shine2.rotation-=0.02;
		}


		///////----------------------------------------------------------------------------------------------------//////
		///////----------------------------------------StoreList Render--------------------------------------------//////
		///////----------------------------------------------------------------------------------------------------//////
		///////----------------------------------------------------------------------------------------------------//////
		//商店列表
		private var _storeList:List;

		private function initStoreList():void
		{
			_storeList=new List;
			_storeList.dataProvider=new ListCollection;
			_storeList.height=Starling.current.stage.stageHeight;
			_storeList.itemRendererType=ObjectItemRender;
			alignWith(_storeList, content.storeList);
		}

		public function setStoreItem(item:Object):void
		{
			var index:int=_storeList.dataProvider.getItemIndex(item);
			if (index == -1)
				_storeList.dataProvider.addItem(item);
			else
				_storeList.dataProvider.updateItemAt(index);
		}

		///////----------------------------------------------------------------------------------------------------//////
		///////--------------------------------------BuildingList Render-------------------------------------------//////
		///////----------------------------------------------------------------------------------------------------//////
		///////----------------------------------------------------------------------------------------------------//////
		//商店列表
		private var _buildingList:List;

		private function initBuildingList():void
		{
			_buildingList=new List();
			addChild(_buildingList);
			_buildingList.height=Starling.current.stage.stageHeight;
			BuildingItemRender.VIEW_WIDTH=content.leftLines.x;
			_buildingList.dataProvider=new ListCollection;
			_buildingList.itemRendererType=BuildingItemRender;
		}

		/**
		 * 设置buildingItem
		 * @param item
		 * @param insertIndex
		 * @param remove
		 *
		 */
		public function setBuildingItem(item:Object, itemIndex:int, remove:Boolean=false):void
		{
			if (remove)
				_buildingList.dataProvider.removeItem(item);
			else
			{
				var index:int=_buildingList.dataProvider.getItemIndex(item);
				if (index == -1)
					_buildingList.dataProvider.addItemAt(item, itemIndex);
				else
					_buildingList.dataProvider.updateItemAt(index);
			}
		}

		///////----------------------------------------------------------------------------------------------------//////
		///////--------------------------------Upgrades Store List Render------------------------------------------//////
		///////----------------------------------------------------------------------------------------------------//////
		///////----------------------------------------------------------------------------------------------------//////
		private var _upgradeStoreList:List;

		private function initUpgradesStoreList():void
		{
			_upgradeStoreList=new List();
			_upgradeStoreList.dataProvider=new ListCollection();
			alignWith(_upgradeStoreList, content.upgradeStoreList);
			_upgradeStoreList.width=64 * 3;
			_upgradeStoreList.height=128;
			_upgradeStoreList.verticalScrollPolicy=Scroller.SCROLL_POLICY_OFF;
			_upgradeStoreList.horizontalScrollPolicy=Scroller.SCROLL_POLICY_ON;
			const listLayout:TiledRowsLayout=new TiledRowsLayout;
			listLayout.paging=TiledRowsLayout.PAGING_HORIZONTAL;
			listLayout.useSquareTiles=false;
			listLayout.tileHorizontalAlign=TiledRowsLayout.TILE_HORIZONTAL_ALIGN_CENTER;
			listLayout.horizontalAlign=TiledRowsLayout.HORIZONTAL_ALIGN_CENTER;
			listLayout.manageVisibility=true;
			listLayout.gap=4;
			_upgradeStoreList.layout=listLayout;
			_upgradeStoreList.itemRendererType=UpgradeItemRender;
		}


		public function resetUpgradesItem(items:Object):void
		{
			_upgradeStoreList.dataProvider.removeAll();
			var len:int=items.length;
			for (var i:int=0; i < len; i++)
				_upgradeStoreList.dataProvider.addItem(items[i]);
			var offset:Number=0;
			if (len == 0)
				offset=0;
			else if (len <= 3)
				offset=64;
			else
				offset=64 * 2;

			if (_storeList.y != offset)
			{
				TweenLite.killTweensOf(_storeList);
				TweenLite.to(_storeList, 0.5, {y: offset, onComplete: function():void
				{
					_storeList.height=Starling.current.stage.stageHeight - _storeList.y;
				}});
			}
		}
		///////----------------------------------------------------------------------------------------------------//////
		///////-------------------------------------------Curser Render--------------------------------------------//////
		///////----------------------------------------------------------------------------------------------------//////
		///////----------------------------------------------------------------------------------------------------//////
		private var curserImg:Image;
		private var nextCurser:int=0;
		private var curserTimeline:TimelineMax;
		private var _curserStyles:Array=[];

		private function drawCurser():void
		{
			var len:int=_curserStyles.length;
			for (var i:int=0; i < len; i++)
			{
				curserImg.x=_curserStyles[i].x;
				curserImg.y=_curserStyles[i].y;
				curserImg.rotation=_curserStyles[i].r;
				curserImg.scaleX=curserImg.scaleY=_curserStyles[i].s;
				_upCanvas.addImage(curserImg);
			}

			if (len && Game.T % Game.fps == 0)
			{
				if (nextCurser >= len - 1)
					nextCurser=0;
				else
					nextCurser++;

				var target:Object=_curserStyles[nextCurser];
				var r:Number=target.r;
				var radius:Number=-10;
				var offsetX:Number=Math.floor(Math.sin(-r) * radius);
				var offsetY:Number=Math.floor(Math.cos(-r) * radius);

				if (curserTimeline)
				{
					curserTimeline.kill();
					curserTimeline.clear();
					curserTimeline.stop();
					curserTimeline=null;
				}

				curserTimeline=new TimelineMax();
				curserTimeline.autoRemoveChildren=true;
				curserTimeline.append(TweenLite.to(target, 0.25, {x: offsetX + target.x, y: offsetY + target.y, s: 0.75}));
				curserTimeline.append(TweenLite.to(target, 0.25, {x: target.x, y: target.y, s: 1}));
				curserTimeline.play();
			}
		}

		public function updateCurserAmount(amount:int):void
		{
			var radius:int=int(_bigCookie.width / 2) - 10;
			while (true)
			{
				var len:int=_curserStyles.length;
				if (len < amount)
				{
					var n:Number=Math.floor(len / 50);
					var a:Number=((len + 0.5 * n) % 50) / 50;
					var r:Number=-(a) * Math.PI * 2;
					var x:Number=Math.floor(Math.sin(-r) * radius) + _bigCookie.x;
					var y:Number=Math.floor(Math.cos(-r) * radius) + _bigCookie.y;
					_curserStyles.push({x: x, y: y, r: r, s: 1});
				}
				else if (len > amount)
				{
					_curserStyles.pop();
				}
				else
					break;
			}
		}

	}
}
