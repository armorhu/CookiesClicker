package agame.endless.modules.main.view.upgrades
{
	import agame.endless.modules.main.model.upgrade.UpgradeData;
	import agame.endless.services.assets.Assets;
	import agame.endless.services.feathers.itemRender.CustomItemRender;

	import starling.display.Image;
	import starling.extension.starlingide.display.movieclip.StarlingMovieClip;

	public class UpgradeItemRender extends CustomItemRender
	{
		private var view:StarlingMovieClip;
		private var icon:Image;

		public function UpgradeItemRender()
		{
			super();
		}

		override protected function initialize():void
		{
			if (!view)
			{
				view=Assets.current.getLinkageInstance('endless.ui.UpgradeItemUI') as StarlingMovieClip;
				addChild(view);
				setSize(view.width, view.height);
			}
		}

		override protected function commitData():void
		{
			var model:UpgradeData=data as UpgradeData;
			if (icon == null)
			{
				icon=new Image(UpgradeIconUtil.getIconTexture(model.iconX, model.iconY));
				addChild(icon);
				icon.x=icon.y=int((view.width - icon.width) / 2);
			}
			else
			{
				icon.texture=UpgradeIconUtil.getIconTexture(model.iconX, model.iconY);
			}
		}
	}
}
