package agame.endless.modules.main.model.upgrade
{
	import com.agame.services.csv.CSVFile;

	import agame.endless.configs.lang.Lang;
	import agame.endless.configs.upgrades.UpgradesConfig;
	import agame.endless.modules.main.model.Game;


	public class UpgradeData extends UpgradesConfig
	{
		public var buyFunction:Function;

		public var bought:int;
		public var unlocked:int;

		public var effect:String;
		public var tips:String;

		public var clickFunction:Function;
		public var debug:int;

		public static var csvFile:CSVFile;
		public static var UpgradesN:int=0;
		private static var sHeplerKeys:Array;

		public var price:Number;

		//0=show, 3=hide (1-2 : I have no idea)
		public function UpgradeData()
		{
			sHeplerKeys=csvFile.keys;
			var len:int=sHeplerKeys.length;
			for (var i:int=0; i < len; i++)
				this[sHeplerKeys[i]]=csvFile.getValue(UpgradesN, i, UpgradesN);
			this.id=UpgradesN;
			this.price=basePrice;

			this.displayName=Lang(this.displayName);
			this.desc=Lang(this.desc);

			var start:int=this.desc.lastIndexOf('<');
			var end:int=this.desc.lastIndexOf('>');
			if (start != -1 && end != -1)
			{
				this.effect=this.desc.substr(0, start);
				this.tips='“' + this.desc.substring(start + 1, end) + '”';
			}
			else
			{
				this.effect=this.desc;
				this.tips='';
			}
			Game.Upgrades[name]=this;
			Game.UpgradesById[id]=this;

			UpgradesN++;
		}

		public function getPrice():Number
		{
			var price:Number=this.basePrice;
			if (Game.Has('Toy workshop'))
				price*=0.95;
			if (Game.Has('Santa\'s dominion'))
				price*=0.98;
			return Math.ceil(price);
		}

		public function buy():void
		{
			var cancelPurchase:Boolean=false;
			if (this.clickFunction)
				cancelPurchase=!this.clickFunction();
			if (!cancelPurchase)
			{
				var price:Number=this.getPrice();
				if (Game.cookies >= price && !this.bought)
				{
					Game.Spend(price);
					this.bought=1;
					if (this.buyFunction)
						this.buyFunction();
					Game.upgradeUpgradesDataInStore(this);
					Game.recalculateGains=1;
					if (this.hide != 3)
						Game.UpgradesOwned++;
				}
			}
		}

		public function earn():void //just win the upgrades without spending anything
		{
			Game.Upgrades[this.name].unlocked=1;
			this.bought=1;
			if (this.buyFunction)
				this.buyFunction();
			Game.upgradeUpgradesDataInStore(this);
			Game.recalculateGains=1;
			if (this.hide != 3)
				Game.UpgradesOwned++;
		}

		public function toggle():void //cheating only
		{
			if (!this.bought)
			{
				this.bought=1;
				if (this.buyFunction)
					this.buyFunction();
				Game.upgradeUpgradesDataInStore(this);
				Game.recalculateGains=1;
				if (this.hide != 3)
					Game.UpgradesOwned++;
			}
			else
			{
				this.bought=0;
				Game.upgradeUpgradesDataInStore(this);
				Game.recalculateGains=1;
				if (this.hide != 3)
					Game.UpgradesOwned--;
			}
			Game.UpdateMenu();
		}

	}
}
