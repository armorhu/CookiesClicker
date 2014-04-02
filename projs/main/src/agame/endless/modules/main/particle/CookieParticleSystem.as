package agame.endless.modules.main.particle
{
	import flash.net.drm.AddToDeviceGroupSetting;

	import agame.endless.Game;
	import agame.endless.services.frame.Enterframe;
	import agame.endless.services.frame.IEnterframe;

	import starling.display.Sprite;
	import starling.extension.starlingide.display.movieclip.StarlingMovieClip;

	public class CookieParticleSystem implements IEnterframe
	{
		public var particles:Vector.<AppParticle>; //粒子
		public var leftBackgroundWidth:Number=0;

		private var _buttomParticle:Sprite; //底部的粒子容器
		private var _upParticle:Sprite; //顶部的粒子容器

		public function CookieParticleSystem(cookieCenter:StarlingMovieClip)
		{
			leftBackgroundWidth=cookieCenter.width;
			_buttomParticle=cookieCenter.particleContainer;
			_upParticle=cookieCenter.particleCotnainer2;
			initliaze();
		}

		private function initliaze():void
		{
			particles=new Vector.<AppParticle>();
			particles.length=50;
			particles.fixed=true;
			for (var i:int=0; i < particles.length; i++)
				particles[i]=new AppParticle;
			Enterframe.current.add(this);
		}

		public function particlesUpdate():void
		{
			var len:int=particles.length;
			for (var i:int=0; i < len; i++)
			{
				var me:AppParticle=particles[i];
				if (me.life != -1)
				{
					if (!me.text)
						me.yd+=0.2 + Math.random() * 0.1;
					me.x+=me.xd;
					me.y+=me.yd;
					me.life++;
					if (me.life >= Game.fps * me.dur)
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
		 *
		 */
		public function particleAdd(x:Number=0, y:Number=0, xd:Number=0, yd:Number=0, size:int=0, dur:Number=0, z:Number=0, pic:String=null, text:String=null):void
		{
			//particleAdd(pos X,pos Y,speed X,speed Y,size (multiplier),duration (seconds),layer,picture,text);
			//pick the first free (or the oldest) particle to replace it
			if (1 || Game.prefs.particles)
			{
				var highest:int=0;
				var highestI:int=0;
				for (var i:int=0; i < particles.length; i++)
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
					x=Math.floor(Math.random() * leftBackgroundWidth);
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
				me.r=Math.floor(Math.random() * 360);
//				me.textureName='smallCookies.png' + int(Math.random() * 8);
				me.text=text || '';
			}
		}

		public function particlesDraw():void
		{
			var len:int=particles.length;
			_upParticle.removeChildren();
			_buttomParticle.removeChildren();
			for (var i:int=0; i < len; i++)
			{
				var me:AppParticle=particles[i];
				if (me.life != -1)
				{
					var opacity:Number=1 - (me.life / (Game.fps * me.dur));
					me.alpha=opacity;
					if (me.z == 0)
						_buttomParticle.addChild(me);
					else
						_upParticle.addChild(me);
				}
			}
		}

		public function enterframe():void
		{
			// TODO Auto Generated method stub
			particlesUpdate();
			particlesDraw();
		}

	}
}
