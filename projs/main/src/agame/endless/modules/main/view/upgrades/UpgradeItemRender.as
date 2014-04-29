package agame.endless.modules.main.view.upgrades
{
	import com.agame.utils.Beautify;
	import com.greensock.TweenLite;
	import com.greensock.easing.Strong;

	import agame.endless.modules.main.model.Game;
	import agame.endless.modules.main.model.upgrade.UpgradeData;
	import agame.endless.modules.main.view.IconUtil;
	import agame.endless.services.assets.Assets;
	import agame.endless.services.button.ButtonUtils;
	import agame.endless.services.dialog.DialogManager;
	import agame.endless.services.feathers.itemRender.CustomItemRender;

	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.extension.starlingide.display.movieclip.StarlingMovieClip;
	import starling.extension.starlingide.display.textfield.StarlingTextField;

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
				icon=new Image(IconUtil.getIconTexture(model.iconX, model.iconY));
				addChildAt(icon, 0);
				icon.x=icon.y=int((view.width - icon.width) / 2);
			}
			else
			{
				icon.texture=IconUtil.getIconTexture(model.iconX, model.iconY);
			}

			view.disableMask.visible=model.price > Game.cookies;
		}

		override protected function itemClicked():void
		{
			showDetail(data as UpgradeData);
		}

		private static var detailDialog:StarlingMovieClip;
		private static var upgradeIcon:Image;
		private static var content:StarlingMovieClip;

		public static function showDetail(upgradeData:UpgradeData):void
		{
			if (detailDialog == null)
			{
				detailDialog=Assets.current.getLinkageInstance('endless.ui.UpgradeInfoPopup') as StarlingMovieClip;
				content=detailDialog.content;
				upgradeIcon=content.icon.getChildAt(0) as Image;

				ButtonUtils.buildButton(detailDialog.btnOK);
				ButtonUtils.buildButton(detailDialog.btnCancel);
			}
			var canBuy:Boolean=upgradeData.price <= Game.cookies;

			content.unflatten();
			upgradeIcon.texture=IconUtil.getIconTexture(upgradeData.iconX, upgradeData.iconY);
			content.upgradeName.text=upgradeData.displayName;
			content.upgradePrice.text=Beautify(upgradeData.price);
			(content.upgradePrice as StarlingTextField).color=canBuy ? 0x00ff00 : 0xff0000;
			content.effect.text=upgradeData.effect;
			content.tips.text=upgradeData.tips;
			DialogManager.gi().showDialog(detailDialog, upgradeData.buy, null, null, false, true)
			detailDialog.scaleX=detailDialog.scaleY=1;
			content.flatten();
			detailDialog.y=Starling.current.stage.stageHeight - 160;
			TweenLite.from(detailDialog, 0.5, {scaleX: 0, scaleY: 0, ease: Strong.easeOut});

			(detailDialog.btnOK as DisplayObject).touchable=canBuy;
			(detailDialog.btnOK as DisplayObject).alpha=canBuy ? 1 : 0.5;
		}

	}
}
