package agame.endless.modules.main.view.curser
{
	import com.greensock.TimelineMax;

	import agame.endless.modules.main.model.Game;
	import agame.endless.services.assets.Assets;

	import starling.animation.IAnimatable;
	import starling.display.Image;
	import starling.display.QuadBatch;

	/**
	 * 光标数据
	 * @author hufan
	 */
	public class CurserCanvas extends QuadBatch implements IAnimatable
	{
		private var curserImg:Image;
		private var nextCurser:int=0;
		private var curserTimeline:TimelineMax;
		private var _curserStyles:Vector.<Curser>;
		private var _raidus:Number=0;

		public function CurserCanvas(radius:Number)
		{
			this._raidus=radius;
			curserImg=Assets.current.getLinkageInstance('cursor') as Image;
			_curserStyles=new Vector.<Curser>;
		}

		public function advanceTime(time:Number):void
		{
			// TODO Auto Generated method stub
			this.rotation-=Math.PI * time / 20;
			if (Game.T % 10 == 0)
			{
				var len:int=_curserStyles.length;
				reset();
				for (var i:int=0; i < len; i++)
				{
					curserImg.x=_curserStyles[i].x;
					curserImg.y=_curserStyles[i].y;
					curserImg.rotation=_curserStyles[i].r;
					curserImg.scaleX=curserImg.scaleY=_curserStyles[i].s;
					addImage(curserImg);
				}
			}
//}
//			if (len && Game.T % Game.fps == 0)
//			{
//				if (nextCurser >= len - 1)
//					nextCurser=0;
//				else
//					nextCurser++;
//
//				var target:Object=_curserStyles[nextCurser];
//				var r:Number=target.r;
//				var radius:Number=-10;
//				var offsetX:Number=Math.floor(Math.sin(-r) * radius);
//				var offsetY:Number=Math.floor(Math.cos(-r) * radius);
//
//				if (curserTimeline)
//				{
//					curserTimeline.kill();
//					curserTimeline.clear();
//					curserTimeline.stop();
//					curserTimeline=null;
//				}
//
//				curserTimeline=new TimelineMax();
//				curserTimeline.autoRemoveChildren=true;
//				curserTimeline.append(TweenLite.to(target, 0.25, {x: offsetX + target.x, y: offsetY + target.y, s: 0.75}));
//				curserTimeline.append(TweenLite.to(target, 0.25, {x: target.x, y: target.y, s: 1}));
//				curserTimeline.play();
//			}
		}

		public function updateCurserAmount(amount:int):void
		{
			var radius:int=int(_raidus / 2) - 20;
			var len:int=0;
			var c:Curser;
			while (true)
			{
				len=_curserStyles.length;
				if (len < amount)
				{
					var n:Number=Math.floor(len / 50);
					var a:Number=((len + 0.5 * n) % 50) / 50;
					var r:Number=-(a) * Math.PI * 2 - Math.PI / 2;
					var x:Number=Math.floor(Math.sin(-r) * (radius + n * 20));
					var y:Number=Math.floor(Math.cos(-r) * (radius + n * 20));

					c=new Curser;
					c.r=r;
					c.x=x;
					c.y=y;
					c.s=1;
					c.time=10;
					_curserStyles.push(c);
				}
				else if (len > amount)
				{
					_curserStyles.pop();
				}
				else
					break;
			}
		}

	}
}
