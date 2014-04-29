package agame.endless.services.dialog
{
	import com.gamua.flox.utils.setTimeout;
	
	import flash.geom.Rectangle;
	import flash.utils.clearInterval;
	
	import starling.core.Starling;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.display.Stage;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	/**
	 * 面板管理器
	 * @author hufan
	 */
	public class DialogManager
	{
		private var _layer:Sprite;
		private var _dialogs:Vector.<DialogItem>;
		private var stageWidth:Number;
		private var stageHeight:Number;
		private var stage:Stage;

		private static var ins:DialogManager;

		public static function gi():DialogManager
		{
			return ins;
		}

		public function DialogManager(layer:Sprite)
		{
			if (ins == null)
				ins=this;
			else
				throw new Error('this class must be singleton!');
			_layer=layer;
			stage=Starling.current.stage;
			stageWidth=Starling.current.stage.stageWidth;
			stageHeight=Starling.current.stage.stageHeight;
			Starling.current.stage.addEventListener(TouchEvent.TOUCH, touchStageHandler);
			_dialogs=new Vector.<DialogItem>;
		}

		private function touchStageHandler(evt:TouchEvent):void
		{
			// TODO Auto Generated method stub
			if (_dialogs == null || _dialogs.length == 0)
				return;
			var dialogItem:DialogItem=_dialogs[_dialogs.length - 1];
			if (!dialogItem.blankClose)
				return;
			var touch:Touch=evt.getTouch(stage, TouchPhase.ENDED);
			if (touch == null)
				return;
			var bounds:Rectangle;
			if (dialogItem.mask && dialogItem.mask.parent == dialogItem.dialog)
			{
				dialogItem.dialog.removeChild(dialogItem.mask);
				bounds=dialogItem.dialog.getBounds(stage);
				dialogItem.dialog.addChildAt(dialogItem.mask, 0);
			}
			else
			{
				bounds=dialogItem.dialog.getBounds(stage);
			}
			if (!bounds.contains(touch.globalX, touch.globalY))
			{
				removeDialogItem(dialogItem, true, false);
			}
		}

		/**
		 *
		 * @param dialog
		 * @param okCall
		 * @param cancelCall
		 * @param triggeredHandler
		 * @param modal
		 * @param blankClose
		 */
		public function showDialog(dialog:Sprite, okCall:Function=null, cancelCall:Function=null, triggeredHandler:Function=null, modal:Boolean=true, blankClose:Boolean=true):void
		{
			dialog.x=stageWidth >> 1;
			dialog.y=stageHeight >> 1;

			removeDialog(dialog);

			var item:DialogItem=new DialogItem();
			item.oriScaleX=dialog.scaleX;
			item.oriScaleY=dialog.scaleY;
			item.dialog=dialog;
			item.okCall=okCall;
			item.cancelCall=cancelCall;
			item.blankClose=false;
			if (blankClose)
				item.intervalID=setTimeout(item.setBlankClose, 100);
			else
				item.intervalID=-1;
			item.clickHandler=triggeredHandler;
			if (modal)
			{
				item.mask=new Quad(stageWidth * 2, stageHeight * 2, 0x0);
				item.mask.x=-stageWidth;
				item.mask.y=-stageHeight;
				item.mask.alpha=0.5;
				_layer.addChild(item.mask);
			}
			dialog.addEventListener(Event.TRIGGERED, triggeredDialog);
			_layer.addChild(dialog);
			_dialogs.push(item);
		}

		public function removeDialog(dialog:Sprite, cancelCallBack:Boolean=false):void
		{
			// TODO Auto Generated method stub
			var item:DialogItem=getDialogItem(dialog);
			removeDialogItem(item, cancelCallBack, false);
		}

		private function getDialogItem(dialog:Sprite):DialogItem
		{
			const len:int=_dialogs.length;
			for (var i:int=0; i < len; i++)
				if (dialog == _dialogs[i].dialog)
					return _dialogs[i];
			return null;
		}

		private function removeDialogItem(item:DialogItem, cancelCallBack:Boolean, okCallBack:Boolean):void
		{
			if (item)
			{
				var index:int=_dialogs.indexOf(item);
				if (index == -1)
					return;
				_dialogs.splice(index, 1);
				if (cancelCallBack && item.cancelCall != null)
					item.cancelCall();
				if (okCallBack && item.okCall != null)
					item.okCall();
				if (item.mask)
					item.mask.removeFromParent(true);
				item.dialog.removeEventListener(Event.TRIGGERED, triggeredDialog);
				if (item.intervalID >= 0)
				{
					clearInterval(item.intervalID);
					item.intervalID=-1;
				}
				item.removeFromParent();
//				return;
//				TweenLite.killTweensOf(item.dialog);
//				TweenLite.to(item.dialog, 0.5, {scaleX: 0, scaleY: 0, ease: Bounce.easeIn, onComplete: item.removeFromParent});
			}
		}

		private function triggeredDialog(evt:Event):void
		{
			// TODO Auto Generated method stub
			var targetName:String=evt.target['name'];
			var item:DialogItem=_dialogs[_dialogs.length - 1];
			if (item.clickHandler != null)
				item.clickHandler(targetName);
			if (targetName == 'btnOK' || targetName == 'btnCancel' || targetName == 'btnClose')
			{
				if (targetName == 'btnOK')
				{
					removeDialogItem(item, false, true);
				}
				else
				{
					removeDialogItem(item, true, false);
				}
			}
		}
	}
}
