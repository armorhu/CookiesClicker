package agame.endless.model
{
	import agame.endless.Game;
	import agame.endless.model.achievements.AchievementsDataModel;
	import agame.endless.model.objects.ObjectData;
	import agame.endless.model.objects.ObjectDataModel;
	import agame.endless.model.prefs.AppPrefs;
	import agame.endless.model.upgrade.UpgradeData;
	import agame.endless.model.upgrade.UpgradeDataModel;


	public class AppdataModel
	{
		//cookies 经济
		public var cookiesEarned:Number=0; //all cookies earned during gameplay
		public var cookies:Number=0; //cookies
		public var cookiesd:Number=0; //cookies display
		public var cookiesPs:Number=1; //cookies per second (to recalculate with every new purchase)
		public var cookiesReset:Number=0; //cookies lost to resetting
		public var frenzy:Number=0; //as long as >0, cookie production is multiplied by frenzyPower
		public var frenzyMax:Number=0; //how high was our initial burst
		public var frenzyPower:Number=1;
		public var clickFrenzy:Number=0; //as long as >0, mouse clicks get 777x more cookies
		public var clickFrenzyMax:Number=0; //how high was our initial burst
		public var cookieClicks:Number=0; //+1 for each click on the cookie
		public var goldenClicks:Number=0; //+1 for each golden cookie clicked (all time)
		public var goldenClicksLocal:Number=0; //+1 for each golden cookie clicked (this game only)
		public var missedGoldenClicks:Number=0; //+1 for each golden cookie missed
		public var handmadeCookies:Number=0; //all the cookies made from clicking the cookie
		public var milkProgress:Number=0; //you gain a little bit for each achievement. Each increment of 1 is a different milk displayed.
		public var milkH:Number=milkProgress / 2; //milk height, between 0 and 1 (although should never go above 0.5)
		public var milkHd:Number=0; //milk height display
		public var milkType:Number=-1; //custom milk : 0:Number=plain, 1:Number=chocolate...
		public var backgroundType:Number=-1; //custom background : 0:Number=blue, 1:Number=red...
		public var prestige:Object={}; //cool stuff that carries over beyond resets
		public var resets:Number=0; //reset counter
		public var lastClick:int; //上一次点击时间。
		public var autoclickerDetected:int; //按键精灵检测器。
		public var computedMouseCps:int; //经过计算的鼠标点击的cps
		public var prefs:AppPrefs; //控制台。
		public var recalculateGains:int;
		public var fps:int=60;
		public var priceIncrease:Number=1.15;
		public var santaLevel:int=0;
		public var SpecialGrandmaUnlock:int;
		public var globalCpsMult:Number;

		public var Objects:Object={};
		public var ObjectDatasById:Object={};
		public var storeToRebuild:int;
		public var BuildingsOwned:int;


		public var Upgrades:Object={};
		public var UpgradesOwned:int=0;
		public var upgradesToRebuild:int;
		public var UpgradesInStore:Vector.<UpgradeData>;

		public var Acheivements:Object={};
		public var cpsAchievs:Array=[];

		public function AppdataModel()
		{
		}

		public function initliaze():void
		{
			trace('初始化游戏数据....');
			fps=60;
			prefs=new AppPrefs;
			ObjectDataModel.setup();
			UpgradeDataModel.setup();
			AchievementsDataModel.setup();
		}

		public function buyUpgrade(upgradeName:String):Boolean
		{
			var result:Boolean=false;
			return result;
		}


		public function Win(achivementName:String):void
		{
		}

		public function Earn(howmuch:Number):void
		{
			cookies+=howmuch;
			cookiesEarned+=howmuch;
		}

		public function Spend(howmuch:Number):void
		{
			cookies-=howmuch;
		}

		public function Dissolve(howmuch:Number):void
		{
			cookies-=howmuch;
			cookiesEarned-=howmuch;
		}

		public function CalculateGains():void
		{
			cookiesPs=0;
			var mult:Number=1;
			for (var name:String in Upgrades)
			{
				var me:UpgradeData=Upgrades[name];
				if (me.bought > 0)
				{
					if (me.type == 'cookie' && Has(me.name))
						mult+=me.power * 0.01;
				}
			}
			mult+=Has('Specialized chocolate chips') * 0.01;
			mult+=Has('Designer cocoa beans') * 0.02;
			mult+=Has('Underworld ovens') * 0.03;
			mult+=Has('Exotic nuts') * 0.04;
			mult+=Has('Arcane sugar') * 0.05;

			if (Has('Increased merriness'))
				mult+=0.15;
			if (Has('Improved jolliness'))
				mult+=0.15;
			if (Has('A lump of coal'))
				mult+=0.01;
			if (Has('An itchy sweater'))
				mult+=0.01;
			if (Has('Santa\'s dominion'))
				mult+=0.5;

			if (Has('Santa\'s legacy'))
				mult+=(santaLevel + 1) * 0.1;

			if (!prestige.ready)
				CalculatePrestige();
			var heavenlyMult:Number=0;
			if (Has('Heavenly chip secret'))
				heavenlyMult+=0.05;
			if (Has('Heavenly cookie stand'))
				heavenlyMult+=0.20;
			if (Has('Heavenly bakery'))
				heavenlyMult+=0.25;
			if (Has('Heavenly confectionery'))
				heavenlyMult+=0.25;
			if (Has('Heavenly key'))
				heavenlyMult+=0.25;
			mult+=parseFloat(prestige['Heavenly chips']) * 0.02 * heavenlyMult;

			var storedCps:Number;
			for (name in Objects)
			{
				var me2:ObjectData=Objects[name] as ObjectData;
				cookiesPs+=me2.amount
				me2.storedCps=(me2.cps is Function ? me2.cps() : Number(me2.cps));
				me2.storedTotalCps=me2.amount * me2.storedCps;
				cookiesPs+=me2.storedTotalCps;
			}

			var milkMult:Number=Has('Santa\'s milk and cookies') ? 1.05 : 1;
			if (Has('Kitten helpers'))
				mult*=(1 + milkProgress * 0.05 * milkMult);
			if (Has('Kitten workers'))
				mult*=(1 + milkProgress * 0.1 * milkMult);
			if (Has('Kitten engineers'))
				mult*=(1 + milkProgress * 0.2 * milkMult);
			if (Has('Kitten overseers'))
				mult*=(1 + milkProgress * 0.2 * milkMult);

			var rawCookiesPs:Number=cookiesPs * mult;
			for (var i:int=0; i < cpsAchievs.length / 2; i++)
			{
				if (rawCookiesPs >= cpsAchievs[i * 2 + 1])
					Win(cpsAchievs[i * 2]);
			}

			if (frenzy > 0)
				mult*=frenzyPower;

//			var sucked:Number=1;
//			for (var name:String in wrinklers)
//			{
//				if (wrinklers[name].phase == 2)
//					sucked-=1 / 20;
//			}
//			cpsSucked=(1 - sucked);

			if (Has('Elder Covenant'))
				mult*=0.95;

			globalCpsMult=mult;
			cookiesPs*=globalCpsMult;

			computedMouseCps=mouseCps();

			recalculateGains=0;
		}

		public function mouseCps():Number
		{
			var add:Number=0;
			if (Has('Thousand fingers'))
				add+=0.1;
			if (Has('Million fingers'))
				add+=0.5;
			if (Has('Billion fingers'))
				add+=2;
			if (Has('Trillion fingers'))
				add+=10;
			if (Has('Quadrillion fingers'))
				add+=20;
			if (Has('Quintillion fingers'))
				add+=100;
			if (Has('Sextillion fingers'))
				add+=200;
			var num:Number=0;
			for (var i:String in Objects)
			{
				num+=Objects[i].amount;
			}
			num-=Objects['Cursor'].amount;
			add=add * num;
			if (Has('Plastic mouse'))
				add+=cookiesPs * 0.01;
			if (Has('Iron mouse'))
				add+=cookiesPs * 0.01;
			if (Has('Titanium mouse'))
				add+=cookiesPs * 0.01;
			if (Has('Adamantium mouse'))
				add+=cookiesPs * 0.01;
			if (Has('Unobtainium mouse'))
				add+=cookiesPs * 0.01;
			var mult:Number=1;
			if (Has('Santa\'s helpers'))
				mult*=1.1;
			if (clickFrenzy > 0)
				mult*=777;
			return mult * ComputeCps(1, Has('Reinforced index finger'), Has('Carpal tunnel prevention cream') + Has('Ambidextrous'), add);
		}

		public function HowMuchPrestige(cookies:int):Number
		{
			var prestige:Number=cookies / 1000000000000;
			//prestige=Math.max(0,Math.floor(Math.pow(prestige,0.5)));//old version
			prestige=Math.max(0, Math.floor((-1 + Math.pow(1 + 8 * prestige, 0.5)) / 2)); //geometric progression
			return prestige;
		}

		public function CalculatePrestige():void
		{
			var prestigeNum:Number=HowMuchPrestige(cookiesReset);
			prestige=[];
			prestige['Heavenly chips']=prestigeNum;
			prestige.ready=1;
		}

		public function ComputeCps(base:Number, add:Number, mult:Number, bonus:Number=0):Number
		{
			return ((base + add) * (Math.pow(2, mult)) + bonus);
		}

		public function Unlock(what:Object):void
		{
			if (what is String)
			{
				if (Upgrades[what])
				{
					if (Upgrades[what].unlocked == 0)
					{
						Upgrades[what].unlocked=1;
						upgradesToRebuild=1;
						recalculateGains=1;
					}
				}
			}
			else
			{
				for (var i:String in what)
				{
					Unlock(what[i]);
				}
			}
		}

		public function Lock(what):void
		{
			if (what is String)
			{
				if (Upgrades[what])
				{
					Upgrades[what].unlocked=0;
					Upgrades[what].bought=0;
					upgradesToRebuild=1;
					if (Upgrades[what].bought == 1)
						UpgradesOwned--;
					recalculateGains=1;
				}
			}
			else
			{
				for (var i:String in what)
				{
					Lock(what[i]);
				}
			}
		}

		public function Has(what:String):int
		{
			return (Upgrades[what] ? Upgrades[what].bought : 0);
		}

		public function HasUnlocked(what:String):int
		{
			return (Upgrades[what] ? Upgrades[what].unlocked : 0);
		}

		public function RebuildUpgrades():void //recalculate the upgrades you can buy
		{
			upgradesToRebuild=0;
			UpgradesInStore=new Vector.<UpgradeData>;
			for (var i:String in Upgrades)
			{
				var me:UpgradeData=Upgrades[i];
				if (!me.bought)
				{
					if (me.unlocked)
						UpgradesInStore.push(me);
				}
			}

			UpgradesInStore.sort(function(a:UpgradeData, b:UpgradeData):Number
			{
				if (a.basePrice > b.basePrice)
					return 1;
				else if (a.basePrice < b.basePrice)
					return -1;
				else
					return 0;
			});
		}


		public function NewDrawFunction(pic:Object, xVariance:Number, yVariance:Number, w:Number, shift:Number=0, heightOffset:Number=0):Function
		{
			//pic : either 0 (the default picture will be used), a filename (will be used as override), or a function to determine a filename
			//xVariance : the pictures will have a random horizontal shift by this many pixels
			//yVariance : the pictures will have a random vertical shift by this many pixels
			//w : how many pixels between each picture (or row of pictures)
			//shift : if >1, arrange the pictures in rows containing this many pictures
			//heightOffset : the pictures will be displayed at this height, +32 pixels
			return function():void
			{
				if (pic == 0 && typeof(pic) != 'function')
					pic=this.pic;
				shift=shift || 1;
				heightOffset=heightOffset || 0;
				var bgW:Number=0;
				var str:String='';
				var offX:Number=0;
				var offY:Number=0;

				if (this.drawSpecialButton && this.specialUnlocked)
				{
//					l('rowSpecialButton' + this.id).style.display='block';
//					l('rowSpecialButton' + this.id).innerHTML=this.drawSpecialButton();
//					str+='<div style="width:128px;height:128px;">' + this.drawSpecialButton() + '</div>';
//					l('rowInfo' + this.id).style.paddingLeft=(8 + 128) + 'px';
//					offX+=128;
				}

				for (var i:int=0; i < this.amount; i++)
				{
					if (shift != 1)
					{
						var x:Number=Math.floor(i / shift) * w + ((i % shift) / shift) * w + Math.floor((Math.random() - 0.5) * xVariance) + offX;
						var y:Number=32 + heightOffset + Math.floor((Math.random() - 0.5) * yVariance) + ((-shift / 2) * 32 / 2 + (i % shift) * 32 / 2) + offY;
					}
					else
					{
						x=i * w + Math.floor((Math.random() - 0.5) * xVariance) + offX;
						y=32 + heightOffset + Math.floor((Math.random() - 0.5) * yVariance) + offY;
					}
					var usedPic:String=(typeof(pic) == 'function' ? pic() : pic as String);
					str+='<div class="object" style="background:url(img/' + usedPic + '.png);left:' + x + 'px;top:' + y + 'px;z-index:' + Math.floor(1000 + y) + ';"></div>';
					bgW=Math.max(bgW, x + 64);
				}
				bgW+=offX;
//				l('rowObjects' + this.id).innerHTML=str;
//				l('rowBackground' + this.id).style.width=bgW + 'px';
			}
		}
	}
}
