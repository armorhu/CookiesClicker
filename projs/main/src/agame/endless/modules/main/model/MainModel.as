package agame.endless.modules.main.model
{
	import com.agame.utils.Beautify;

	import flash.utils.getTimer;

	import agame.endless.modules.main.model.achievements.AchievementsDataModel;
	import agame.endless.modules.main.model.newsticker.NewsTicker;
	import agame.endless.modules.main.model.objects.ObjectData;
	import agame.endless.modules.main.model.objects.ObjectDataModel;
	import agame.endless.modules.main.model.prefs.AppPrefs;
	import agame.endless.modules.main.model.upgrade.UpgradeData;
	import agame.endless.modules.main.model.upgrade.UpgradeDataModel;
	import agame.endless.services.frame.IEnterframe;

	import starling.events.EventDispatcher;


	public class MainModel extends EventDispatcher implements IEnterframe
	{
		public var T:int=0;
		public var startTime:int;


		//cookies 经济
		public var cookiesEarned:Number=100000; //all cookies earned during gameplay
		public var cookies:Number=100000; //cookies
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
		public var SpecialGrandmaUnlock:int;
		public var globalCpsMult:Number;

		//objects
		public var Objects:Object={};
		public var ObjectsById:Vector.<ObjectData>;
		public var storeToRebuild:int;
		public var BuildingsOwned:int;
		public var CurrentBuildingIDs:Vector.<int>;


		//upgrades
		public var Upgrades:Object={};
		public var UpgradesById:Vector.<UpgradeData>;
		public var UpgradesOwned:int=0;
		public var upgradesToRebuild:int;
		public var UpgradesInStore:Vector.<UpgradeData>;

		//acheivements
		public var Achievements:Object={};
		public var cpsAchievs:Array=[];
		public var moneyAchievs:Array=[];

		//season
		public var season:String;


		//ticker.
		public var Ticker:String='';
		public var TickerAge:int=0;
		public var TickerN:int=0;


		public var elderWrath:int=0;
		public var elderWrathD:int=0;
		public var pledges:int=0;
		public var pledgeT:int=0;
		public var researchT:int=0;
		public var nextResearch:int=0;
		public var baseResearchTime:int=0;
		public var cookiesSucked:int=0; //cookies sucked by wrinklers
		public var cpsSucked:int=0; //percent of CpS being sucked by wrinklers
		public var wrinklersPopped:int=0;
		public var santaLevel:int=0;
		public var reindeerClicked:int=0;
		public var seasonT:int=0;
		public var seasonUses:int=0;

		public var santaLevels:Array;
		public var santaDrops:Array;

		public function MainModel()
		{
		}

		public function initliaze():void
		{
			trace('初始化游戏数据....');
			fps=60;
			prefs=new AppPrefs;

			ObjectsById=new Vector.<ObjectData>;
			ObjectDataModel.setup();
			CurrentBuildingIDs=new Vector.<int>;

			UpgradesById=new Vector.<UpgradeData>;
			UpgradesInStore=new Vector.<UpgradeData>;
			UpgradeDataModel.setup();

			AchievementsDataModel.setup();

			NewsTicker.setup();

			UpgradesById.fixed=true;
			ObjectsById.fixed=true;

			santaLevels=['Festive test tube', 'Festive ornament', 'Festive wreath', 'Festive tree', 'Festive present', 'Festive elf fetus', 'Elf toddler', 'Elfling', 'Young elf', 'Bulky elf', 'Nick', 'Santa Claus', 'Elder Santa', 'True Santa', 'Final Claus'];
			santaDrops=['Increased merriness', 'Improved jolliness', 'A lump of coal', 'An itchy sweater', 'Reindeer baking grounds', 'Weighted sleighs', 'Ho ho ho-flavored frosting', 'Season savings', 'Toy workshop', 'Naughty list', 'Santa\'s bottomless bag', 'Santa\'s helpers', 'Santa\'s legacy', 'Santa\'s milk and cookies'];

			recalculateGains=1;
			storeToRebuild=1;
			upgradesToRebuild=1;

			startTime=getTimer();
		}

		public function buyUpgrade(upgradeName:String):Boolean
		{
			var result:Boolean=false;
			return result;
		}

		public function Win(achivementName:String):void
		{
		}

		public function HasAchiev(what:String):int
		{
			return (Achievements[what] ? Achievements[what].won : 0);
		}

		public function Earn(howmuch:Number):void
		{
			cookies+=howmuch;
			cookiesEarned+=howmuch;
			RefreshBuildings();
		}

		public function Spend(howmuch:Number):void
		{
			cookies-=howmuch;
			RefreshBuildings();
		}

		public function Dissolve(howmuch:Number):void
		{
			cookies-=howmuch;
			cookiesEarned-=howmuch;
			RefreshBuildings();
		}

		public function CalculateGains():void
		{
			cookiesPs=0;
			var mult:Number=1;

			for (var j:int=0; j < UpgradeData.UpgradesN; j++)
			{
				var me:UpgradeData=UpgradesById[j];
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
			for (var k:int=0; k < ObjectData.ObjectDatasN; k++)
			{
				var me2:ObjectData=ObjectsById[k] as ObjectData;
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
			var len:int=cpsAchievs.length / 2
			for (var i:int=0; i < len; i++)
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
			computedMouseCpsText='+' + Beautify(computedMouseCps, 1);
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
			add=add * (BuildingsOwned - Objects['Cursor'].amount);
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
			return;
			upgradesToRebuild=0;
			UpgradesInStore.splice(0, UpgradesInStore.length);
			var len:int=UpgradesById.length;
			for (var i:int=0; i < len; i++)
			{
				if (!UpgradesById[i].bought && UpgradesById[i].unlocked)
					UpgradesInStore.push(UpgradesById[i]);
			}
			UpgradesInStore.sort(function(a:UpgradeData, b:UpgradeData):Number
			{
				return a.basePrice - b.basePrice;
			});
			dispatchEventWith(REBUILD_UPGRADES);
		}


		public function NewDrawFunction(pic:Object, xVariance:Number, yVariance:Number, w:Number, shift:Number=0, heightOffset:Number=0):Object
		{
			return {pic: pic, xVariance: xVariance, yVariance: yVariance, w: w, shift: shift, heightOffset: heightOffset};
		}

		public function RefreshBuildings():void
		{
			storeToRebuild=1;
		}

		public function RebuildStore():void //redraw the store from scratch
		{
			RefreshBuildings();
			var str:String='';
			var lastLocked:int=0;
			CurrentBuildingIDs.splice(0, CurrentBuildingIDs.length);
			for (var i:int=0; i < ObjectData.ObjectDatasN; i++)
			{
				var me:ObjectData=ObjectsById[i];
				if (i > 0 && me.amount > 0)
					CurrentBuildingIDs.push(i);
				var price:Number=me.price;
				if (cookiesEarned >= price)
				{
					me.lock=false;
					lastLocked=0;
				}
				else
				{
					me.lock=true;
					lastLocked++;
				}
				me.disable=cookies < price;
				me.toggledOff=lastLocked > 2;
			}
			storeToRebuild=0;
			dispatchEventWith(REBUILD_STORED);
		}

		public var timePlayed:int;

		public function enterframe():void
		{
			if (autoclickerDetected > 0)
				autoclickerDetected--;

			//handle cookies
			if (recalculateGains)
				CalculateGains();
			Earn(cookiesPs / fps); //add cookies per second

			if (frenzy > 0)
			{
				frenzy--;
				if (frenzy < 1)
					recalculateGains=1;
			}
			if (clickFrenzy > 0)
			{
				clickFrenzy--;
				if (clickFrenzy < 1)
					recalculateGains=1;
			}
			if (T % (fps) == 0 && Math.random() < 1 / 500000)
				Win('Just plain lucky'); //1 chance in 500,000 every second achievement

			if (T % (fps * 5) == 0) //check some achievements and upgrades
			{
				if (isNaN(cookies))
				{
					cookies=0;
					cookiesEarned=0;
					recalculateGains=1;
				}
				timePlayed=getTimer() - startTime;
				if (cookiesEarned >= 1000000 && !Has('Heavenly chip secret'))
				{
					if (timePlayed <= 1000 * 60 * 35)
						Win('Speed baking I');
					if (timePlayed <= 1000 * 60 * 25)
						Win('Speed baking II');
					if (timePlayed <= 1000 * 60 * 15)
						Win('Speed baking III');
				}

				if (cookiesEarned >= 9999999)
					Unlock(['Oatmeal raisin cookies', 'Peanut butter cookies', 'Plain cookies', 'Sugar cookies']);
				if (cookiesEarned >= 99999999)
					Unlock(['Coconut cookies', 'White chocolate cookies', 'Macadamia nut cookies']);
				if (cookiesEarned >= 999999999)
					Unlock(['Double-chip cookies', 'White chocolate macadamia nut cookies', 'All-chocolate cookies']);
				if (cookiesEarned >= 9999999999)
					Unlock(['Dark chocolate-coated cookies', 'White chocolate-coated cookies']);
				if (cookiesEarned >= 99999999999)
					Unlock(['Eclipse cookies', 'Zebra cookies']);
				if (cookiesEarned >= 999999999999)
					Unlock(['Snickerdoodles', 'Stroopwafels', 'Macaroons']);
				if (cookiesEarned >= 999999999999 && Has('Snickerdoodles') && Has('Stroopwafels') && Has('Macaroons'))
				{
					Unlock('Empire biscuits');
					if (Has('Empire biscuits'))
						Unlock('British tea biscuits');
					if (Has('British tea biscuits'))
						Unlock('Chocolate british tea biscuits');
					if (Has('Chocolate british tea biscuits'))
						Unlock('Round british tea biscuits');
					if (Has('Round british tea biscuits'))
						Unlock('Round chocolate british tea biscuits');
					if (Has('Round chocolate british tea biscuits'))
						Unlock('Round british tea biscuits with heart motif');
					if (Has('Round british tea biscuits with heart motif'))
						Unlock('Round chocolate british tea biscuits with heart motif');
				}
				if (cookiesEarned >= 9999999999999)
				{
					Unlock(['Madeleines', 'Palmiers', 'Palets', 'Sabl&eacute;s']);

					if (prestige['Heavenly chips'] >= 1)
						Unlock('Caramoas');
					if (prestige['Heavenly chips'] >= 2)
						Unlock('Sagalongs');
					if (prestige['Heavenly chips'] >= 3)
						Unlock('Shortfoils');
					if (prestige['Heavenly chips'] >= 4)
						Unlock('Win mints');

					if (prestige['Heavenly chips'] >= 10)
						Unlock('Fig gluttons');
					if (prestige['Heavenly chips'] >= 100)
						Unlock('Loreols');
					if (prestige['Heavenly chips'] >= 500)
						Unlock('Jaffa cakes');
					if (prestige['Heavenly chips'] >= 2000)
						Unlock('Grease\'s cups');

					if (prestige['Heavenly chips'] >= 5000)
						Unlock('Season switcher');
				}
				if (cookiesEarned >= 99999999999999)
				{
					Unlock(['Gingerbread men', 'Gingerbread trees']);
					if (season == 'valentines')
					{
						Unlock('Pure heart biscuits');
						if (Has('Pure heart biscuits'))
							Unlock('Ardent heart biscuits');
						if (Has('Ardent heart biscuits'))
							Unlock('Sour heart biscuits');
						if (Has('Sour heart biscuits'))
							Unlock('Weeping heart biscuits');
						if (Has('Weeping heart biscuits'))
							Unlock('Golden heart biscuits');
						if (Has('Golden heart biscuits'))
							Unlock('Eternal heart biscuits');
					}
				}
				if (Has('Eternal heart biscuits'))
					Win('Lovely cookies');

				if (prestige['Heavenly chips'] > 0)
				{
					Unlock('Heavenly chip secret');
					if (Has('Heavenly chip secret'))
						Unlock('Heavenly cookie stand');
					if (Has('Heavenly cookie stand'))
						Unlock('Heavenly bakery');
					if (Has('Heavenly bakery'))
						Unlock('Heavenly confectionery');
					if (Has('Heavenly confectionery'))
						Unlock('Heavenly key');

					if (Has('Heavenly key'))
						Win('Wholesome');
				}

				var len:int=moneyAchievs.length / 2;
				for (var index:int=0; index < len; index++)
				{
					if (cookiesEarned >= moneyAchievs[index * 2 + 1])
						Win(moneyAchievs[index * 2]);
				}
				var oneOfEach:int=1;
				var mathematician:int=1;
				var base10:int=1;
				var centennial:int=1;
				var bicentennial:int=1;
				for (var i:int=0; i < ObjectData.ObjectDatasN; i++)
				{
					if (ObjectsById[i].hasOwnProperty('EachFrame'))
						ObjectsById[i].EachFrame();
					ObjectsById[i].totalCookies+=ObjectsById[i].storedTotalCps / fps;
					if (!HasAchiev('One with everything'))
					{
						if (ObjectsById[i].amount == 0)
							oneOfEach=0;
					}
					if (!HasAchiev('Mathematician'))
					{
						if (ObjectsById[i].amount < Math.min(128, Math.pow(2, (ObjectsById.length - ObjectsById[i].id) - 1)))
							mathematician=0;
					}
					if (!HasAchiev('Base 10'))
					{
						if (ObjectsById[i].amount < (ObjectsById.length - ObjectsById[i].id) * 10)
							base10=0;
					}
					if (!HasAchiev('Centennial'))
					{
						if (ObjectsById[i].amount < 100)
							centennial=0;
					}
					if (!HasAchiev('Bicentennial'))
					{
						if (ObjectsById[i].amount < 200)
							bicentennial=0;
					}
				}
				if (oneOfEach == 1)
					Win('One with everything');
				if (mathematician == 1)
					Win('Mathematician');
				if (base10 == 1)
					Win('Base 10');
				if (centennial == 1)
					Win('Centennial');
				if (bicentennial == 1)
					Win('Bicentennial');
				if (cookiesEarned >= 1000000 && cookieClicks <= 15)
					Win('Neverclick');
				if (cookiesEarned >= 1000000 && cookieClicks <= 0)
					Win('True Neverclick');
				if (handmadeCookies >= 1000)
				{
					Win('Clicktastic');
					Unlock('Plastic mouse');
				}
				if (handmadeCookies >= 100000)
				{
					Win('Clickathlon');
					Unlock('Iron mouse');
				}
				if (handmadeCookies >= 10000000)
				{
					Win('Clickolympics');
					Unlock('Titanium mouse');
				}
				if (handmadeCookies >= 1000000000)
				{
					Win('Clickorama');
					Unlock('Adamantium mouse');
				}
				if (handmadeCookies >= 100000000000)
				{
					Win('Clickasmic');
					Unlock('Unobtainium mouse');
				}
				if (cookiesEarned < cookies)
					Win('Cheated cookies taste awful');

				if (Has('Skull cookies') && Has('Ghost cookies') && Has('Bat cookies') && Has('Slime cookies') && Has('Pumpkin cookies') && Has('Eyeball cookies') && Has('Spider cookies'))
					Win('Spooky cookies');
				if (wrinklersPopped >= 1)
					Win('Itchscratcher');
				if (wrinklersPopped >= 50)
					Win('Wrinklesquisher');
				if (wrinklersPopped >= 200)
					Win('Moistburster');

				if (cookiesEarned >= 25 && season == 'christmas')
					Unlock('A festive hat');
				if (Has('Christmas tree biscuits') && Has('Snowflake biscuits') && Has('Snowman biscuits') && Has('Holly biscuits') && Has('Candy cane biscuits') && Has('Bell biscuits') && Has('Present biscuits'))
					Win('Let it snow');

				if (reindeerClicked >= 1)
					Win('Oh deer');
				if (reindeerClicked >= 50)
					Win('Sleigh of hand');
				if (reindeerClicked >= 200)
					Win('Reindeer sleigher');

				if (BuildingsOwned >= 100)
					Win('Builder');
				if (BuildingsOwned >= 400)
					Win('Architect');
				if (BuildingsOwned >= 800)
					Win('Engineer');
				if (BuildingsOwned >= 1500)
					Win('Lord of Constructs');
				if (UpgradesOwned >= 20)
					Win('Enhancer');
				if (UpgradesOwned >= 50)
					Win('Augmenter');
				if (UpgradesOwned >= 100)
					Win('Upgrader');
				if (UpgradesOwned >= 150)
					Win('Lord of Progress');

				if (UpgradesOwned == 0 && cookiesEarned >= 1000000000)
					Win('Hardcore');

				if (prestige['Heavenly chips'] >= 1 && Has('Bingo center/Research facility'))
					Unlock('Persistent memory');

				var grandmas:int=0;
				if (Has('Farmer grandmas'))
					grandmas++;
				if (Has('Worker grandmas'))
					grandmas++;
				if (Has('Miner grandmas'))
					grandmas++;
				if (Has('Cosmic grandmas'))
					grandmas++;
				if (Has('Transmuted grandmas'))
					grandmas++;
				if (Has('Altered grandmas'))
					grandmas++;
				if (Has('Grandmas\' grandmas'))
					grandmas++;
				if (Has('Antigrandmas'))
					grandmas++;
				if (Has('Rainbow grandmas'))
					grandmas++;
				if (!HasAchiev('Elder') && grandmas >= 7)
					Win('Elder');
				if (Objects['Grandma'].amount >= 6 && !Has('Bingo center/Research facility') && HasAchiev('Elder'))
					Unlock('Bingo center/Research facility');
				if (pledges > 0)
					Win('Elder nap');
				if (pledges >= 5)
					Win('Elder slumber');
				if (pledges >= 10)
					Unlock('Sacrificial rolling pins');
			}


			cookiesd+=(cookies - cookiesd) * 0.3;

			if (storeToRebuild)
				RebuildStore();
			if (upgradesToRebuild)
				RebuildUpgrades();

			TickerAge--;
			if (TickerAge <= 0 || Ticker == '')
				NewsTicker.getTicker();
			T++;
		}

		public static const NEWTICKER_CHANGED:String='NEWTICKER_CHANGED';
		public static const REBUILD_STORED:String='Rebuild_Stored';
		public static const REBUILD_UPGRADES:String='Rebuild_Upgrades';
		public static const POP_UP:String='pop_up';
		public static const DRAW_OBJECT:String='draw_object';

		private static const Events:Array=[NEWTICKER_CHANGED, REBUILD_STORED, REBUILD_UPGRADES, DRAW_OBJECT];
		public var computedMouseCpsText:String;

		public function addEvents(handler:Function):void
		{
			var len:int=Events.length;
			for (var i:int=0; i < len; i++)
				addEventListener(Events[i], handler);
		}

		public function removeEvents(handler:Function):void
		{
			var len:int=Events.length;
			for (var i:int=0; i < len; i++)
				removeEventListener(Events[i], handler);
		}

		public function UpdateMenu():void
		{
		}

		public function SetResearch(what:String, time:int=0):void
		{
			if (Game.Upgrades[what])
			{
				Game.researchT=Game.baseResearchTime;
				if (Game.Has('Persistent memory'))
					Game.researchT=Math.ceil(Game.baseResearchTime / 10);
				if (Game.Has('Ultrascience'))
					Game.researchT=Game.fps * 5;
				Game.nextResearch=Game.Upgrades[what].id;
				Game.Popup('Research has begun.');
			}
		}

		public function Popup(msg:String):void
		{
			dispatchEventWith(POP_UP, msg);
		}

		public function confirm(msg:String):Boolean
		{
			return false;
		}

		public function CollectWrinklers():void
		{
		}
	}
}
