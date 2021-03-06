package agame.endless.modules.main.view.particle
{
	import agame.endless.modules.main.model.Game;
	import agame.endless.services.assets.Assets;

	import starling.animation.IAnimatable;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.QuadBatch;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class CookieParticleSystem implements IAnimatable
	{
		public var particles:Vector.<AppParticle>; //粒子
		public var particleWidth:int=0;
		public var particleStart:int=0;

		private var _cookies:Image;

		public function CookieParticleSystem(particleStart:Number, particleWidth:Number)
		{
			this.particleStart=particleStart;
			this.particleWidth=particleWidth;
			initliaze();

			Starling.juggler.add(this);
		}

		private function initliaze():void
		{
			particles=new Vector.<AppParticle>();
			particles.length=particleLen;
			particles.fixed=true;
			for (var i:int=0; i < particleLen; i++)
				particles[i]=new AppParticle;
			//饼干粒子
			_cookies=Assets.current.getLinkageInstance('SmallCookie') as Image;
		}

		public function particlesUpdate(time:Number):void
		{
			for (var i:int=0; i < particleLen; i++)
			{
				var me:AppParticle=particles[i];
				if (me.life != -1)
				{
					if (!me.text)
						me.yd+=(0.2 + Math.random() * 0.1) * Game.fps * time;
					me.x+=me.xd * Game.fps * time;
					me.y+=me.yd * Game.fps * time;
					me.life+=time;
					if (me.life >= me.dur)
					{
						me.life=-1;
					}
				}
			}
		}

		/**
		 *
		 * @param x pos x
		 * @param y pos y
		 * @param xd speed x
		 * @param yd speed y
		 * @param size multiplier
		 * @param dur
		 * @param z
		 * @param pic
		 * @param text
		 */
		private const particleLen:int=10;
		private var highest:int=0;
		private var highestI:int=0;

		public function particleAdd(x:Number=0, y:Number=0, xd:Number=0, yd:Number=0, size:int=0, dur:Number=0, z:Number=0, pic:String=null, text:Boolean=false):void
		{
			//particleAdd(pos X,pos Y,speed X,speed Y,size (multiplier),duration (seconds),layer,picture,text);
			//pick the first free (or the oldest) particle to replace it
			for (var i:int=0; i < particleLen; i++)
			{
				if (particles[i].life == -1)
				{
					highestI=i;
					break;
				}
				if (particles[i].life > highest)
				{
					highest=particles[i].life;
					highestI=i;
				}
			}
			var auto:int=0;
			if (x)
				auto=1;
			i=highestI;
			x=x || -64;
			if (!auto)
				x=Math.floor(Math.random() * particleWidth) + particleStart;
			y=y || -64;
			var me:AppParticle=particles[i];
			me.life=0;
			me.x=x;
			me.y=y;
			me.xd=xd || 0;
			me.yd=yd || 0;
			me.size=size || 1;
			me.z=z || 0;
			me.dur=dur || 2;
			me.r=Math.random() * Math.PI * 2;
			me.text=text;
		}

		private var arrangedCharsText:String;
		private var arrangedChars:Object

		public function particlesDraw(_buttomCanvas:QuadBatch, _textCanvas:QuadBatch):void
		{
			if (arrangedCharsText != Game.computedMouseCpsText)
			{
				arrangedCharsText=Game.computedMouseCpsText;
				arrangedChars=Assets.current.particleBmFont.arrangeChars(512, 128, arrangedCharsText, 32, HAlign.LEFT, //
					VAlign.CENTER, //
					true, //
					false);
			}

			for (var i:int=0; i < particleLen; i++)
			{
				var me:AppParticle=particles[i];
				if (me.life != -1)
				{
					var opacity:Number=1 - (me.life / me.dur);
					if (me.text && arrangedChars)
					{
						Assets.current.particleBmFont.fillQuadBatch(me.x, me.y - 64, opacity, 0, _textCanvas, //
							0xffffff, //
							arrangedChars);

					}
					else
					{
						_cookies.alpha=opacity;
						_cookies.x=me.x;
						_cookies.y=me.y;
						_cookies.rotation=me.r;
						if (me.z == 0)
							_buttomCanvas.addImage(_cookies);
					}
				}
			}
		}

		public function advanceTime(time:Number):void
		{
			// TODO Auto Generated method stub
			particlesUpdate(time);
		}

	}
}
