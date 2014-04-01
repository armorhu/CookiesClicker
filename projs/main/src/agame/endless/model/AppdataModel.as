package agame.endless.model
{
	import agame.endless.model.cookie.CookieDataModel;
	import agame.endless.model.upgrade.UpgradeDataModel;

	public class AppdataModel
	{
		public var cookieDataModel:CookieDataModel;
		public var upgradeDataModel:UpgradeDataModel;


		public var recalculateGains:Boolean;

		public function AppdataModel()
		{
		}

		public function buyUpgrade(upgradeName:String):Boolean
		{
			var result:Boolean=false;
			if (!upgradeDataModel.has(upgradeName))
			{
				var price:Number=upgradeDataModel.getPrice(upgradeName);
				if (cookieDataModel.cookies >= price)
				{
					cookieDataModel.spend(price);
					upgradeDataModel.setBought(upgradeName);
					recalculateGains=true;
				}
			}

			return result;
		}
	}
}
