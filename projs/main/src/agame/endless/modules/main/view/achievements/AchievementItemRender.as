package agame.endless.modules.main.view.achievements
{
	import agame.endless.modules.main.model.achievements.AchievementData;
	import agame.endless.modules.main.view.upgrades.UpgradeIconUtil;
	import agame.endless.services.assets.Assets;
	import agame.endless.services.feathers.itemRender.CustomItemRender;

	import starling.display.Image;
	import starling.extension.starlingide.display.movieclip.StarlingMovieClip;
	import starling.textures.Texture;

	public class AchievementItemRender extends CustomItemRender
	{
		private var icon:Image;
		private var view:StarlingMovieClip;

		public function AchievementItemRender()
		{
			super();
		}

		override protected function initialize():void
		{
			if (!view)
			{
				view=Assets.current.getLinkageInstance('endless.ui.AchievementItemUI') as StarlingMovieClip;
				addChild(view);
				setSize(view.width, view.height);
			}
		}

		override protected function commitData():void
		{
			var model:AchievementData=data as AchievementData;
			if (icon == null)
			{
				icon=new Image(texture);
				addChild(icon);
				icon.x=icon.y=int((view.width - icon.width) / 2);
			}
			else
			{
				icon.texture=texture;
			}
			trace('commit data');
		}

		private function get texture():Texture
		{
			var model:AchievementData=data as AchievementData;
			if (model.won)
				return UpgradeIconUtil.getIconTexture(model.iconX, model.iconY);
			else
				return UpgradeIconUtil.getIconTexture(0, 7);
		}
	}
}
