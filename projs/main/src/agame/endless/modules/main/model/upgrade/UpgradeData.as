package agame.endless.modules.main.model.upgrade
{
	import agame.endless.configs.upgrades.UpgradesConfig;
	import agame.endless.modules.main.model.Game;


	public class UpgradeData extends UpgradesConfig
	{
		public var icon:Array;
		public var buyFunction:Function;

		public var bought:int;
		public var unlocked:int;
		public var basePrice:Number;

		public var clickFunction:Function;
		public var debug:int;

		public static var UpgradesN:int=0;

		public function UpgradeData()
		{
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
					Game.upgradesToRebuild=1;
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
			Game.upgradesToRebuild=1;
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
				Game.upgradesToRebuild=1;
				Game.recalculateGains=1;
				if (this.hide != 3)
					Game.UpgradesOwned++;
			}
			else
			{
				this.bought=0;
				Game.upgradesToRebuild=1;
				Game.recalculateGains=1;
				if (this.hide != 3)
					Game.UpgradesOwned--;
			}
			Game.UpdateMenu();
		}

	}
}
