package agame.endless.modules.main
{
	import com.agame.framework.module.Module;
	import com.agame.utils.Beautify;

	import flash.media.SoundTransform;
	import flash.utils.getTimer;

	import agame.endless.appStage;
	import agame.endless.configs.lang.Lang;
	import agame.endless.configs.lang.LangPattern;
	import agame.endless.configs.texts.TextsTIDDefs;
	import agame.endless.modules.main.model.Game;
	import agame.endless.modules.main.model.MainModel;
	import agame.endless.modules.main.model.buildings.BuildingData;
	import agame.endless.modules.main.model.objects.ObjectData;
	import agame.endless.modules.main.view.MainView;
	import agame.endless.services.assets.Assets;
	import agame.endless.services.frame.Enterframe;
	import agame.endless.services.frame.IEnterframe;

	import starling.events.Event;
	import starling.events.EventDispatcher;

	public class MainController extends EventDispatcher implements IEnterframe
	{
		protected var _module:Module;
		protected var _view:MainView;

		public function MainController(module:Module)
		{
			this._module=module;
			super();
			initliaze();
		}

		private var _transform:SoundTransform=new SoundTransform

		protected function initliaze():void
		{
			initModel();
			initView();
			Enterframe.current.add(this);

			_transform.volume=0.25;
			Assets.current.playSound('ingame_loop', 0, int.MAX_VALUE, _transform);
		}

		protected function initView():void
		{
			_view=new MainView();
			_module.container.addChild(_view);
			_view.addEventListener(MainView.CLICK_COOKIE, viewEventHandler);
		}

		protected function disposeView():void
		{
		}

		protected function initModel():void
		{
			Game=new MainModel;
			Game.initliaze();
			Game.addEvents(modelEventHandler);


			_buildings=new Vector.<BuildingData>;
			var buildingData:BuildingData;
			for (var i:int=1; i < ObjectData.ObjectDatasN; i++)
			{
				buildingData=new BuildingData();
				buildingData.id=Game.ObjectsById[i].id;
				_buildings.push(buildingData);
			}
		}

		protected function disposeModel():void
		{
		}



		/**
		 * 视图层事件。
		 * @param evt
		 */
		private function viewEventHandler(evt:Event):void
		{
			if (evt.type == MainView.CLICK_COOKIE)
				clickCookie();
		}

		private function clickCookie():void
		{
			var time:int=getTimer();
			Assets.current.playSound('cookies_click');
			if (time - Game.lastClick < 100)
			{
				Game.autoclickerDetected+=Game.fps;
				if (Game.autoclickerDetected >= Game.fps * 5)
					Game.Win('Uncanny clicker');
			}
			Game.Earn(Game.computedMouseCps);
			Game.handmadeCookies+=Game.computedMouseCps;
			_view.particleAdd();
			_view.particleAdd(appStage.mouseX, appStage.mouseY, Math.random() * 4 - 2, Math.random() * -2 - 2, Math.random() * 0.5 + 0.2, 1, 2);
			_view.particleAdd(appStage.mouseX + Math.random() * 8 - 4, appStage.mouseY - 8 + Math.random() * 8 - 4, 0, -2, 1, 4, 2, '', Game.computedMouseCpsText);
			Game.cookieClicks++;
			Game.lastClick=time;
		}

		private function modelEventHandler(evt:Event):void
		{
			if (evt.type == MainModel.NEWTICKER_CHANGED)
				_view.content.newsTickerLabel.text=Game.Ticker;
			else if (evt.type == MainModel.REBUILD_STORED)
				rebuildStored();
			else if (evt.type == MainModel.REBUILD_UPGRADES)
				rebuildUpgrades();
			else if (evt.type == MainModel.DRAW_OBJECT)
			{
				if (_drityObjects == null)
					_drityObjects=new Object;
				_drityObjects[evt.data]=true;
			}
		}

		private function rebuildStored():void
		{
			for (var i:int=0; i < ObjectData.ObjectDatasN; i++)
				if (!(Game.ObjectsById[i] as ObjectData).toggledOff)
					_view.setStoreItem(Game.ObjectsById[i]);
		}

		private function rebuildUpgrades():void
		{
			trace('rebuildUpgrades', Game.UpgradesInStore.length);
			_view.resetUpgradesItem(Game.UpgradesInStore);
		}

		public function enterframe():void
		{
			// TODO Auto Generated method stub
			Game.enterframe();
			if (Game.cookies && Game.T % Math.ceil(Game.fps / Math.min(10, Game.cookiesPs)) == 0)
				_view.particleAdd(); //cookie shower

			_view.enterframe();

			if (Game.T % 10 == 0)
			{
				drawDirtyObjects();

//				var unit=(Math.round(Game.cookiesd)==1?' cookie':' cookies');
//				if (Math.round(Game.cookiesd).toString().length>11 && !Game.mobile) unit='<br>cookies';
//				var str=Beautify(Math.round(Game.cookiesd))+unit+'<div style="font-size:50%;"'+(Game.cpsSucked>0?' class="warning"':'')+'>per second : '+Beautify(Game.cookiesPs*(1-Game.cpsSucked),1)+'</div>';//display cookie amount

				_view.cookies.text=Lang(TextsTIDDefs.TID_COOKIES).replace(LangPattern.Number, Beautify(Math.round(Game.cookiesd)));
				_view.cps.text=Lang(TextsTIDDefs.TID_CPS).replace(LangPattern.Number, Beautify(Game.cookiesPs, 1));
			}
		}



		private function drawDirtyObjects():void
		{
			if (_drityObjects)
				for (var key:String in _drityObjects)
					drawObject(int(key));
			_drityObjects=null;
		}

		private var _drityObjects:Object;
		private var _buildings:Vector.<BuildingData>;

		public function drawObject(id:int):void
		{
			//pic : either 0 (the default picture will be used), a filename (will be used as override), or a function to determine a filename
			//xVariance : the pictures will have a random horizontal shift by this many pixels
			//yVariance : the pictures will have a random vertical shift by this many pixels
			//w : how many pixels between each picture (or row of pictures)
			//shift : if >1, arrange the pictures in rows containing this many pictures
			//heightOffset : the pictures will be displayed at this height, +32 pixels
			var objectData:ObjectData=Game.ObjectsById[id];
			if (id == 0)
			{
				//draw function for cursors
				_view.updateCurserAmount(objectData.amount);
			}
			else
			{
				//建筑数据
				var buildingData:BuildingData=_buildings[id - 1];
				if (objectData.amount == 0)
					_view.setBuildingItem(buildingData, 0, true);
				else
				{
					buildingData.bg=objectData.background;
					if (objectData.drawSetting.pic is Function)
						buildingData.pic=objectData.drawSetting.pic();
					else
						buildingData.pic=objectData.pic;

					var shift:int=objectData.drawSetting.shift;
					var heightOffset:int=objectData.drawSetting.heightOffset;
					var xVariance:int=objectData.drawSetting.xVariance;
					var yVariance:int=objectData.drawSetting.yVariance;
					var w:int=objectData.drawSetting.w;
					shift=shift || 1;
					heightOffset=heightOffset || 0;
					buildingData.bgW=0;
					buildingData.points.splice(0, buildingData.points.length);
					var str:String='';
					var offX:Number=0;
					var offY:Number=0;
					var x:Number, y:Number;
					for (var i:int=0; i < objectData.amount; i++)
					{
						if (shift != 1)
						{
							x=Math.floor(i / shift) * w + ((i % shift) / shift) * w + Math.floor((Math.random() - 0.5) * xVariance) + offX;
							y=32 + heightOffset + Math.floor((Math.random() - 0.5) * yVariance) + ((-shift / 2) * 32 / 2 + (i % shift) * 32 / 2) + offY;
						}
						else
						{
							x=i * w + Math.floor((Math.random() - 0.5) * xVariance) + offX;
							y=32 + heightOffset + Math.floor((Math.random() - 0.5) * yVariance) + offY;
						}
						buildingData.bgW=Math.max(buildingData.bgW, x + 64);
						buildingData.points.push({x: x, y: y});
					}
					buildingData.bgW+=offX;
					_view.setBuildingItem(buildingData, Game.CurrentBuildingIDs.indexOf(buildingData.id));
				}
			}
		}

	}
}
