package agame.endless.model.upgrade
{

	public class UpgradeDataModel
	{
		public function UpgradeDataModel()
		{
		}

		public function has(name:String):Boolean
		{
			return getUpgradeByName(name) ? getUpgradeByName(name).bought : false;
		}

		public function setBought(name:String):void
		{
			var upgrade:Upgrade=getUpgradeByName(name);
			upgrade.bought=true;
			if (upgrade.buyFunction)
				upgrade.buyFunction();
			upgradesToRebuild=true;
		}

		public function getPrice(name:String):Number
		{
			var upgrade:Upgrade=getUpgradeByName(name);
			var price:Number=upgrade.basePrice;
			if (has('Toy workshop'))
				price*=0.95;
			if (has('Santa\'s dominion'))
				price*=0.98;
			return Math.ceil(price);
		}


		private var _upgradeByName:Object={};
		private var _upgradeByID:Object={};
		private var _upgradeSID:int=1;

		private function newUpgrade(name:String, desc:String, price:Number, buyFunction:Function):void
		{
			var upgrade:Upgrade=new Upgrade();
			upgrade.id=_upgradeSID++;
			upgrade.name=name;
			upgrade.basePrice=price;
			upgrade.desc=desc;
			upgrade.buyFunction=buyFunction;

			_upgradeByName[upgrade.name]=upgrade;
			_upgradeByID[upgrade.id]=upgrade;
		}

		public function getUpgradeByName(name:String):Upgrade
		{
			return _upgradeByName[name];
		}



		/**
		 * 重新计算你能买的科技。并排序
		 */
		public var upgradesToRebuild:Boolean=false;
		public var upgradesInStores:Vector.<Upgrade>;

		public function rebuild():void
		{
			this.upgradesToRebuild=false;
			upgradesInStores=new Vector.<Upgrade>;
			for (var name:String in _upgradeByName)
			{
				var me:Upgrade=this._upgradeByName[name];
				if (!me.bought)
				{
					if (me.unlocked)
						upgradesInStores.push(me);
				}
			}

			var sortMap:Function=function(a:Upgrade, b:Upgrade):Number
			{
				if (a.basePrice > b.basePrice)
					return 1;
				else if (a.basePrice < b.basePrice)
					return -1;
				else
					return 0;
			}
			upgradesInStores.sort(sortMap);
		}
	}
}
