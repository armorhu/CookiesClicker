package agame.endless.modules.main.view.particle
{
	import agame.endless.modules.main.model.Game;
	import agame.endless.services.assets.Assets;
	import agame.endless.services.frame.IEnterframe;

	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.QuadBatch;
	import starling.extension.starlingide.display.movieclip.StarlingMovieClip;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class CookieParticleSystem implements IEnterframe
	{
		public var particles:Vector.<AppParticle>; //粒子
		public var particleWidth:int=0;
		public var particleStart:int=0;

		private var _buttomCanvas:QuadBatch;
		private var _upCanvas:QuadBatch;
		private var _textCanvas:QuadBatch;
		private var _particleFont:ParticleBitmapFont;
		private var _cookies:Image;

		public function CookieParticleSystem(cookieCenter:StarlingMovieClip)
		{
			particleWidth=cookieCenter.cookiesLabel.width;
			particleStart=cookieCenter.cookiesLabel.x;

			_buttomCanvas=new QuadBatch();
			_upCanvas=new QuadBatch();
			_textCanvas=new QuadBatch();
			_particleFont=new ParticleBitmapFont();

			cookieCenter.particleContainer.addChild(_buttomCanvas);
			cookieCenter.particleCotnainer2.addChild(_upCanvas);
			cookieCenter.particleCotnainer2.addChild(_textCanvas);
			(cookieCenter.particleContainer as DisplayObject).touchable=false;
			(cookieCenter.particleCotnainer2 as DisplayObject).touchable=false;

			initliaze();
		}

		private function initliaze():void
		{
			particles=new Vector.<AppParticle>();
			particles.length=50;
			particles.fixed=true;
			for (var i:int=0; i < particles.length; i++)
				particles[i]=new AppParticle;
			//饼干粒子
			_cookies=Assets.current.main.getLinkageInstance('SmallCookie') as Image;
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
				me.text=text || null;
			}
		}

		public function particlesDraw():void
		{
			var len:int=particles.length;
			_buttomCanvas.reset();
			_upCanvas.reset();
			_textCanvas.reset();
			for (var i:int=0; i < len; i++)
			{
				var me:AppParticle=particles[i];
				if (me.life != -1)
				{
					var opacity:Number=1 - (me.life / (Game.fps * me.dur));
					if (me.text == null)
					{
						_cookies.alpha=opacity;
						_cookies.x=me.x;
						_cookies.y=me.y;
						_cookies.rotation=me.r;
						if (me.z == 0)
							_buttomCanvas.addImage(_cookies);
						else
							_upCanvas.addImage(_cookies);
					}
					else
					{
						_particleFont.fillQuadBatch(me.x, me.y, opacity, 0, _textCanvas, //
							64, //
							32, //
							me.text, 24, //
							0xffffff, HAlign.CENTER, //
							VAlign.CENTER, //
							false, //
							false);
					}

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
