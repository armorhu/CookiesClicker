package agame.endless.modules.main.view
{
	import com.agame.utils.DisplayUtil;
	import com.greensock.TimelineMax;
	import com.greensock.TweenLite;
	import com.greensock.easing.Strong;

	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	import agame.endless.configs.lang.Lang;
	import agame.endless.configs.texts.TextsTIDDefs;
	import agame.endless.modules.main.view.buildings.BuildingItemRender;
	import agame.endless.modules.main.view.curser.CurserCanvas;
	import agame.endless.modules.main.view.objects.ObjectItemRender;
	import agame.endless.modules.main.view.panel.stats.StatsPanel;
	import agame.endless.modules.main.view.particle.CookieParticleSystem;
	import agame.endless.modules.main.view.upgrades.UpgradeItemRender;
	import agame.endless.services.assets.Assets;
	import agame.endless.services.frame.IEnterframe;
	import agame.endless.services.utils.useEmbedFont;

	import feathers.controls.List;
	import feathers.controls.ScrollContainer;
	import feathers.controls.Scroller;
	import feathers.data.ListCollection;
	import feathers.display.TiledImage;
	import feathers.layout.TiledRowsLayout;
	import feathers.layout.VerticalLayout;

	import starling.animation.IAnimatable;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.display.QuadBatch;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.extension.starlingide.display.movieclip.StarlingMovieClip;
	import starling.extension.starlingide.display.textfield.StarlingTextField;
	import starling.extensions.PDParticleSystem;
	import starling.filters.DisplacementMapFilter;
	import starling.textures.Texture;

	public class MainView extends Sprite implements IEnterframe, IAnimatable
	{
		public static const CLICK_COOKIE:String='click_cookie';

		public var content:StarlingMovieClip;
		public var cookieCenter:StarlingMovieClip;
		public var cookies:StarlingTextField; //饼干数量
		private var frame:StarlingMovieClip;

		/**
		 *粒子系统
		 */
		private var _cookieParticleSystem:CookieParticleSystem;
		private var _shine:StarlingMovieClip; //shine；
		private var _shine2:StarlingMovieClip; //shine2;
		private var _buttomCanvas:QuadBatch;
		private var _textCanvas:QuadBatch;
		private var _bigCookie:DisplayObject;
		private var _statsPanel:StatsPanel; //统计面板

		/**
		 * 鼠标。。
		 */
		private var _curser:CurserCanvas;

		private var canvasX:Number;
		private var canvasWidth:Number;

		public var stageWidth:Number=0;
		public var stageHeight:Number=0;

		public function MainView()
		{
			super();
			initiliaze();
		}

		private function initiliaze():void
		{
			stageWidth=Starling.current.stage.stageWidth;
			stageHeight=Starling.current.stage.stageHeight;

			content=Assets.current.getLinkageInstance('endless.ui.MainUIView') as StarlingMovieClip;
			addChild(content);
			addEventListener(Event.TRIGGERED, triggeredMeHandler);


			frame=content.frame;
			useEmbedFont(frame.storeLabel);
			useEmbedFont(frame.buildingLabel);
			frame.storeLabel.text=Lang(TextsTIDDefs.TID_STORE);
			frame.buildingLabel.text=Lang(TextsTIDDefs.TID_BUILDING);
			frame.flatten();
			canvasX=content.newsTickerLabel.x;
			canvasWidth=content.newsTickerLabel.width;


			cookieCenter=content.cookieCenter;
			_buttomCanvas=new QuadBatch(); //最下面的画布
			_textCanvas=new QuadBatch(); //位图字体的画布
			cookieCenter.particleContainer.addChild(_buttomCanvas);
			cookieCenter.particleCotnainer2.addChild(_textCanvas);
			(cookieCenter.particleContainer as DisplayObject).touchable=false;
			(cookieCenter.particleCotnainer2 as DisplayObject).touchable=false;
			_bigCookie=cookieCenter.bigCookie;
			//particles
			_cookieParticleSystem=new CookieParticleSystem(canvasX, canvasWidth);

			cookies=cookieCenter.cookiesLabel;
			(content.newsTickerLabel as StarlingTextField).fontName=Assets.FontName;
			(content.newsTickerLabel as StarlingTextField).autoScale=true;

			_shine=cookieCenter.shine;
			_shine2=cookieCenter.shine2;
			_shine.flatten();
			_shine2.flatten();


			initMainStyle();

			initStoreList();
			initBuildingList();
			initUpgradesStoreList();


			var xml:XML=Assets.current.getXml('cookie_rain');
			var cookieTexture:Texture=Assets.current.getLinkageTexture('SmallCookie');
			xml.sourcePositionVariance.@x=content.newsTickerLabel.width / 2;
			xml.startParticleSize.@value=cookieTexture.width;
			xml.finishParticleSize.@value=cookieTexture.width;
			cookiesRain=new PDParticleSystem(xml, cookieTexture);
			Starling.juggler.add(cookiesRain);
			cookiesRain.x=content.newsTickerLabel.x + content.newsTickerLabel.width / 2;
			cookieCenter.particleContainer.addChildAt(cookiesRain, 0);

			xml=Assets.current.getXml('cookie_click');
			xml.startParticleSize.@value=cookieTexture.width;
			xml.finishParticleSize.@value=cookieTexture.width;
			cookiesClick=new PDParticleSystem(xml, cookieTexture);
			Starling.juggler.add(cookiesClick);

			cookieCenter.particleCotnainer2.addChildAt(cookiesClick, 0);


			content.btnStatsLabel.text=Lang(TextsTIDDefs.TID_BUTTON_LABEL_STATS);
			content.btnStatsLabel.touchable=false;
			content.btnMenuLabel.text=Lang(TextsTIDDefs.TID_BUTTON_LABEL_MENU);
			content.btnMenuLabel.touchable=false;

			Starling.juggler.add(this);

			_curser=new CurserCanvas(_bigCookie.width);
			_curser.x=_bigCookie.x;
			_curser.y=_bigCookie.y;
			cookieCenter.particleCotnainer2.addChildAt(_curser, 0);

			xml=Assets.current.getXml('cheer');
			xml.sourcePositionVariance.@x=content.newsTickerLabel.width / 2;
			cheer=new PDParticleSystem(xml, Assets.current.getTexture('particleTexture'));
			cheer.x=content.newsTickerLabel.x + content.newsTickerLabel.width / 2;
			cheer.y=stageHeight;
			Starling.juggler.add(cheer);
			addChild(cheer);

			//饼干背景
		}

		public var cookiesRain:PDParticleSystem;
		public var cookiesClick:PDParticleSystem;
		public var cheer:PDParticleSystem;

		private function initMainStyle():void
		{
			MainStyle.Upgrade_list_height=192;
			MainStyle.Upgrade_List_Width=192;
		}


		private function triggeredMeHandler(evt:Event):void
		{
			var targetName:String=evt.target['name'];
			if (targetName == 'bigCookie')
			{
				dispatchEventWith(CLICK_COOKIE);
				return;
			}

			Assets.current.playSound('select_item');
			if (targetName == 'btnClose')
				hideWindow();
			else if (targetName == 'btnStats')
			{
				if (_statsPanel == null)
					_statsPanel=new StatsPanel(stage.stageWidth);
				popupWindow(Lang(TextsTIDDefs.TID_BUTTON_LABEL_STATS), _statsPanel);
			}
			else if (targetName == 'btnMenu')
				popupWindow(Lang(TextsTIDDefs.TID_BUTTON_LABEL_MENU), null);
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
			_textCanvas.reset();
			_cookieParticleSystem.particlesDraw(_buttomCanvas, _textCanvas);
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
			_storeList.allowMultipleSelection=false;
			var vLayout:VerticalLayout=new VerticalLayout;
			vLayout.hasVariableItemDimensions=true;
			vLayout.manageVisibility=true;
			_storeList.layout=vLayout;
			_storeList.verticalScrollPolicy=Scroller.SCROLL_POLICY_ON;
			_storeList.scrollBarDisplayMode=Scroller.SCROLL_BAR_DISPLAY_MODE_NONE;
			DisplayUtil.alignWith(_storeList, content.storeList);
		}


		public function setStoreItem(item:Object):void
		{
			var index:int=_storeList.dataProvider.getItemIndex(item);
			if (index == -1)
				_storeList.dataProvider.addItem(item);
			else
				_storeList.dataProvider.updateItemAt(index);
		}

		public function tweenStoreListTo(py:Number, adjustList:Boolean):void
		{
			if (_storeList.y != py)
			{
				TweenLite.killTweensOf(_storeList);
				if (adjustList)
					TweenLite.to(_storeList, 0.5, {y: py, onUpdate: update, onComplete: function():void
					{
						_storeList.height=Starling.current.stage.stageHeight - _storeList.y;
					}});
				else
					TweenLite.to(_storeList, 0.5, {y: py, onUpdate: update});
			}

			function update():void
			{
				content.storeBorder.y=_storeList.y - 8;
			}
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
			var vLayout:VerticalLayout=new VerticalLayout;
			vLayout.hasVariableItemDimensions=true;
			_buildingList.layout=vLayout;
			_buildingList.verticalScrollPolicy=Scroller.SCROLL_POLICY_ON;
			_buildingList.scrollBarDisplayMode=Scroller.SCROLL_BAR_DISPLAY_MODE_NONE;

			_buildingList.dataProvider=new ListCollection;
			_buildingList.itemRendererType=BuildingItemRender;
			_buildingList.allowMultipleSelection=false;
			vLayout.manageVisibility=true;
			DisplayUtil.alignWith(_buildingList, content.buildingList);
			_buildingList.height=Starling.current.stage.stageHeight - _buildingList.y;
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
			DisplayUtil.alignWith(_upgradeStoreList, content.upgradeStoreList);
			_upgradeStoreList.width=MainStyle.Upgrade_List_Width;
			_upgradeStoreList.height=MainStyle.Upgrade_list_height;
			_upgradeStoreList.scrollBarDisplayMode=Scroller.SCROLL_BAR_DISPLAY_MODE_NONE;

//			_upgradeStoreList.verticalScrollPolicy=Scroller.SCROLL_POLICY_OFF;
//			_upgradeStoreList.horizontalScrollPolicy=Scroller.SCROLL_POLICY_ON;
//			const listLayout:TiledColumnsLayout=new TiledColumnsLayout;
//			listLayout.useSquareTiles=false;
//			listLayout.tileVerticalAlign=TiledColumnsLayout.TILE_VERTICAL_ALIGN_MIDDLE;
//			listLayout.verticalAlign=TiledColumnsLayout.V;
			const listLayout:TiledRowsLayout=new TiledRowsLayout;
			listLayout.paging=TiledRowsLayout.PAGING_VERTICAL;
			listLayout.gap=4;
			listLayout.manageVisibility=true;
			_upgradeStoreList.layout=listLayout;
			_upgradeStoreList.itemRendererType=UpgradeItemRender;
		}

		public function setUpgradeData(data:Object):void
		{
			var item:Object=data.upgradeData;
			var index:int=data.index;
			var inStore:Boolean=data.inStore;
			if (inStore)
				this._upgradeStoreList.dataProvider.addItemAt(item, index);
			else
				this._upgradeStoreList.dataProvider.removeItem(item);

			var offset:Number=Math.ceil(_upgradeStoreList.dataProvider.length / 2) * 91;
			if (offset > MainStyle.Upgrade_list_height)
				offset=MainStyle.Upgrade_list_height;
			offset+=_upgradeStoreList.y;
			tweenStoreListTo(offset, true);
		}

		private function addDistortionTo(target:DisplayObject, targetWidth:Number=0, targetHeight:Number=0):void
		{
			if (targetWidth == 0)
				targetWidth=target.width;
			if (targetHeight == 0)
				targetHeight=target.height;
			var offset:Number=0;
			var scale:Number=Starling.contentScaleFactor;
			var width:int=targetWidth * 1.2;
			var height:int=targetHeight * 1.2;

			var perlinData:BitmapData=new BitmapData(width * scale, height * scale, false);
			perlinData.perlinNoise(200 * scale, 20 * scale, 2, 5, true, true, 0, true);

			var dispMap:BitmapData=new BitmapData(perlinData.width, perlinData.height * 2, false);
			dispMap.copyPixels(perlinData, perlinData.rect, new Point(0, 0));
			dispMap.copyPixels(perlinData, perlinData.rect, new Point(0, perlinData.height));

			var texture:Texture=Texture.fromBitmapData(dispMap, false, false, scale);
			var filter:DisplacementMapFilter=new DisplacementMapFilter(texture, null, BitmapDataChannel.RED, BitmapDataChannel.RED, 40, 5);

			target.filter=filter;
			target.addEventListener("enterFrame", function(event:EnterFrameEvent):void
			{
				if (offset > height)
					offset-=height;
				else
					offset+=event.passedTime * 20;

				filter.mapPoint.y=offset - height;
			});
		}

		///////----------------------------------------------------------------------------------------------------//////
		///////---------------------------------draw Cookies Background--------------------------------------------//////
		///////----------------------------------------------------------------------------------------------------//////
		///////----------------------------------------------------------------------------------------------------//////
		public var cookiesBackground:Sprite;
		public var cookiesBackgroundImage:TiledImage;

		public function setCookiesBackgroundTexture():void
		{
			if (cookiesBackground == null)
				cookiesBackground=new Sprite;

		}

		///////----------------------------------------------------------------------------------------------------//////
		///////-----------------------------------------------draw Milk--------------------------------------------//////
		///////----------------------------------------------------------------------------------------------------//////
		///////----------------------------------------------------------------------------------------------------//////
		private const MilkPics:Array=['milkWave', 'chocolateMilkWave', 'raspberryWave', 'orangeWave', 'caramelWave'];
		public var milkContainer:Sprite;
		public var milkImage:TiledImage; //牛奶视图
		public var currentPic:int=-1;
		public var imageHeight:Number=0;

		//set milk's pic & height
		public function setMilkStyle(pic:int, height:Number):void
		{
			if (pic != currentPic)
			{
				//need change texture..
				currentPic=pic;
				var texture:Texture=Assets.current.getLinkageTexture(MilkPics[currentPic]);
				if (milkImage == null)
				{
					milkImage=new TiledImage(texture);
					milkImage.y=Starling.current.stage.stageHeight;
					milkImage.width=canvasWidth * 2;
					milkImage.alpha=0.8;
					milkImage.x=canvasX;
					milkContainer=new Sprite;
					cookieCenter.addChild(milkContainer);
					milkContainer.clipRect=new Rectangle(canvasX, Starling.current.stage.stageHeight - milkImage.height, canvasWidth, milkImage.height);
					milkContainer.addChild(milkImage);

//					addDistortionTo(content.btnStats);
//					addDistortionTo(milkImage);
				}
				else
				{
					milkImage.texture=texture;
				}
			}
			height*=milkImage.height;
			imageHeight=Starling.current.stage.stageHeight - height;
			trace('set milk stype', MilkPics[pic], imageHeight);
		}

		///////----------------------------------------------------------------------------------------------------//////
		///////-----------------------------------------Pop up Windows--------------------------------------------//////
		///////----------------------------------------------------------------------------------------------------//////
		///////----------------------------------------------------------------------------------------------------//////

		private var _window:StarlingMovieClip;

		public function popupWindow(title:String, windowContent:DisplayObject):void
		{
			//initliaze pop windows.
			if (_window == null)
			{
				_window=Assets.current.getLinkageInstance('endless.ui.PopWindowUI') as StarlingMovieClip;
				var bg:Quad=new Quad(_window.width, Starling.current.stage.stageHeight, 0x0);
				_window.bg.addChildAt(bg, 0);
				(_window.bg as Sprite).flatten();

				var scrollerContainer:ScrollContainer=new ScrollContainer();
				scrollerContainer.width=_window.width - _window.content.x * 2;
				scrollerContainer.height=_window.height - _window.content.y;
				scrollerContainer.horizontalScrollPolicy=Scroller.SCROLL_BAR_DISPLAY_MODE_NONE;
				DisplayUtil.alignWith(scrollerContainer, _window.content);
			}

			_window.title.text=title;
			_window.content.removeChildren();
			if (windowContent)
				_window.content.addChild(windowContent);

			if (!isPopupWindow)
			{
				addChild(_window);
				TweenLite.killTweensOf(_window);
				_window.y=Starling.current.stage.stageHeight;
				TweenLite.to(_window, 0.5, {y: Starling.current.stage.stageHeight - _window.height, onComplete: function():void
				{
//					Assets.current.playSound('popupwindow');
					content.removeFromParent();
				}});
			}
		}

		public function hideWindow():void
		{
			if (isPopupWindow)
			{
				addChildAt(content, 0);
				TweenLite.killTweensOf(_window);
				TweenLite.to(_window, 0.5, {y: Starling.current.stage.stageHeight, onComplete: function():void
				{
					_window.removeFromParent();
				}});
			}
		}

		public function get isPopupWindow():Boolean
		{
			return _window && _window.stage;
		}

		public function advanceTime(time:Number):void
		{
			// TODO Auto Generated method stub
			_shine.rotation+=Math.PI * time / 2;
			_shine2.rotation-=Math.PI * time / 2;
			if (milkImage)
			{
				if (milkImage.y != imageHeight)
				{
					milkImage.y+=(imageHeight - milkImage.y) * 0.1;
					if (Math.abs(milkImage.y - imageHeight) < 1)
						milkImage.y=imageHeight;
				}

				milkImage.x+=150 * time;
				milkImage.x=int(milkImage.x);
				if (milkImage.x >= canvasX)
					milkImage.x-=canvasWidth;
			}
			_curser.advanceTime(time);
		}

		public function updateCurserAmount(amount:int):void
		{
			// TODO Auto Generated method stub
			_curser.updateCurserAmount(amount);
		}
		private var _notifyViews:Vector.<StarlingMovieClip>=new Vector.<StarlingMovieClip>;

		public function notify(title:String, msg:String, icon:DisplayObject):void
		{
			var _notifyView:StarlingMovieClip;
			if (_notifyViews.length > 0)
				_notifyView=_notifyViews.pop();
			else
				_notifyView=Assets.current.getLinkageInstance('NoteWindow') as StarlingMovieClip;

			_notifyView.alpha=1;
			_notifyView.scaleY=1;
			_notifyView.x=stageWidth / 2;
			_notifyView.y=stageHeight + _notifyView.height;
			_notifyView.title.text=title;
			_notifyView.msg.text=msg;
			(_notifyView.icon as StarlingMovieClip).removeChildren(0, -1, true);
			_notifyView.icon.addChild(icon);
			addChild(_notifyView);

			var _notifyTimeLine:TimelineMax=new TimelineMax({onComplete: notifyComplete, onCompleteParams: [_notifyView]});
			_notifyTimeLine.append(TweenLite.to(_notifyView, 0.75, {alpha: 1, y: stageHeight, ease: Strong.easeOut}));
			_notifyTimeLine.append(TweenLite.to(_notifyView, 1.0, {alpha: 0, scaleY: 1, y: stageHeight - _notifyView.height, ease: Strong.easeInOut}), 4);
			_notifyTimeLine.play();
			Assets.current.playSound('notifier_achievement_complete');
//			cheer.start(0.1);
			cheer.populate(50);
		}

		private function notifyComplete(target:DisplayObject):void
		{
			target.removeFromParent();
			_notifyViews.push(target);
		}
	}
}
