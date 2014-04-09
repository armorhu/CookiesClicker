package agame.endless.modules.main.model.objects
{
	import com.agame.services.csv.CSVFile;

	import agame.endless.configs.lang.Lang;
	import agame.endless.configs.objects.ObjectsConfig;
	import agame.endless.modules.main.model.Game;
	import agame.endless.modules.main.model.MainModel;

	public class ObjectData extends ObjectsConfig
	{
		public var price:Number;
		public var cps:Object=0;
		public var totalCookies:Number=0;
		public var storedCps:Number=0;
		public var storedTotalCps:Number=0;
		public var buyFunction:Function;
		public var drawSetting:Object;
		public var sellFunction:Function;

		public var special:String=null; //special is a function that should be triggered when the object's special is unlocked, or on load (if it's already unlocked). For example, creating a new dungeon.
		public var onSpecial:int=0; //are we on this object's special screen (dungeons etc)?
		public var specialUnlocked:int=0;
		public var specialDrawFunction:Function=null;
		public var drawSpecialButton:String=null;

		public var amount:int=0;
		public var bought:int=0;

		public var dirty:Boolean=true;
		public var lock:Boolean;
		public var canBuy:Boolean;
		public var toggledOff:Boolean;

		public static var ObjectDatasN:int=0;

		public static var csvFile:CSVFile;
		private static var sHeplerKeys:Array;

		public function ObjectData(cps:Function, drawSetting:Object, buyFunction:Function)
		{
			sHeplerKeys=csvFile.keys;
			var len:int=sHeplerKeys.length;
			for (var i:int=0; i < len; i++)
				this[sHeplerKeys[i]]=csvFile.getValue(ObjectDatasN, i, ObjectDatasN);

			this.id=ObjectDatasN;
			this.cps=cps;
			this.buyFunction=buyFunction;
			this.drawSetting=drawSetting;
			this.price=basePrice;

			this.displayName=Lang(this.displayName);
			this.desc=Lang(this.desc);

			Game.Objects[this.name]=this;
			Game.ObjectsById.length=this.id + 1;
			Game.ObjectsById[this.id]=this;
			ObjectDatasN++;
		}

		public function setLock(value:Boolean):void
		{
			if (lock == value)
				return;
			lock=value;
			dirty=true;
		}

		public function setCanbuy(value:Boolean):void
		{
			if (canBuy == value)
				return;
			canBuy=value;
			dirty=true;
		}

		public function setToggleOff(value:Boolean):void
		{
			if (toggledOff == value)
				return;
			toggledOff=value;
			dirty=true;
		}

		public function getPrice():Number
		{
			var price:Number=this.basePrice * Math.pow(Game.priceIncrease, this.amount);
			if (Game.Has('Season savings'))
				price*=0.99;
			if (Game.Has('Santa\'s dominion'))
				price*=0.99;
			return Math.ceil(price);
		}

		public function buy():void
		{
			if (Game.cookies >= price)
			{
				Game.Spend(price);
				this.amount++;
				this.bought++;
				this.price=this.getPrice();
				if (this.buyFunction)
					this.buyFunction();
				if (this.drawFunction)
					this.drawFunction();
				Game.storeToRebuild=1;
				Game.recalculateGains=1;
				Game.BuildingsOwned++;
				dirty=true;
			}
		}

		private function drawFunction():void
		{
			// TODO Auto Generated method stub
			Game.dispatchEventWith(MainModel.DRAW_OBJECT, false, id);
		}

		public function sell():void
		{
			var price:Number=this.getPrice();
			price=Math.floor(price * 0.5);
			if (this.amount > 0)
			{
				//Game.Earn(price);
				Game.cookies+=price;
				this.amount--;
				this.price=this.getPrice();
				if (this.sellFunction)
					this.sellFunction();
				if (this.drawFunction)
					this.drawFunction();
				Game.storeToRebuild=1;
				Game.recalculateGains=1;
				Game.BuildingsOwned--;
				dirty=true;
			}
		}

		public function setSpecial(what:int):void //change whether we're on the special overlay for this object or not
		{
			if (what == 1)
				this.onSpecial=1;
			else
				this.onSpecial=0;
			if (this.id != 0)
			{
				if (this.onSpecial)
				{
//					l('rowSpecial' + this.id).style.display='block';
					if (this.specialDrawFunction)
						this.specialDrawFunction();
				}
				else
				{
//					l('rowSpecial' + this.id).style.display='none';
					if (this.drawFunction)
						this.drawFunction();
				}
			}
		}

		public function unlockSpecial():void
		{
			if (this.specialUnlocked == 0)
			{
				this.specialUnlocked=1;
				this.setSpecial(0);
				if (this.special)
					this.special();
			}
		}
	}
}
