package agame.endless.modules.main.view.upgrades
{
	import flash.geom.Rectangle;

	import agame.endless.modules.main.model.Game;
	import agame.endless.modules.main.model.upgrade.UpgradeData;
	import agame.endless.services.assets.Assets;

	import starling.display.Image;
	import starling.textures.Texture;

	public class UpgradeIconUtil
	{
		public function UpgradeIconUtil()
		{
		}

		private static var icons:Texture;
		private static const iconsDict:Object={};

		private static var sHeplerRect:Rectangle=new Rectangle;
		private static var sHeplerTexture:Texture;

		public static function getIconTexture(iconX:int, iconY:int):Texture
		{
			var key:String=iconX + '_' + iconY
			if (iconsDict[iconX + '_' + iconY] != undefined)
				return iconsDict[key] as Texture;

			if (icons == null)
			{
				icons=Assets.current.getLinkageTexture('icons');
				sHeplerRect.width=48, sHeplerRect.height=48;
			}

			sHeplerRect.x=iconX * 48;
			sHeplerRect.y=iconY * 48;
			sHeplerTexture=Texture.fromTexture(icons, sHeplerRect);
			iconsDict[key]=sHeplerTexture;
			return sHeplerTexture;
		}


		public static function getIcon(iconX:int, iconY:int):Image
		{
			var img:Image=new Image(getIconTexture(iconX, iconY));
			return img;
		}
	}
}
