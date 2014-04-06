package agame.endless.modules.main.view.upgrades
{
	import flash.geom.Rectangle;

	import agame.endless.modules.main.model.Game;
	import agame.endless.modules.main.model.upgrade.UpgradeData;
	import agame.endless.services.assets.Assets;

	import starling.textures.Texture;

	public class UpgradeIconUtil
	{
		public function UpgradeIconUtil()
		{
		}

		private static var icons:Texture;
		private static const iconsDict:Object={};

		private static var sHelperUpgrade:UpgradeData;
		private static var sHeplerRect:Rectangle=new Rectangle;
		private static var sHeplerTexture:Texture;

		public static function getIconTexture(upgradeName:String):Texture
		{
			if (iconsDict[upgradeName] != undefined)
				return iconsDict[upgradeName] as Texture;

			if (icons == null)
			{
				icons=Assets.current.getLinkageTexture('icons');
				sHeplerRect.width=48, sHeplerRect.height=48;
			}
			sHelperUpgrade=Game.Upgrades[upgradeName] as UpgradeData;
			sHeplerRect.x=sHelperUpgrade.icon[0] * 48;
			sHeplerRect.y=sHelperUpgrade.icon[1] * 48;
			sHeplerTexture=Texture.fromTexture(icons, sHeplerRect);
			iconsDict[upgradeName]=sHeplerTexture;
			return sHeplerTexture;
		}
	}
}
