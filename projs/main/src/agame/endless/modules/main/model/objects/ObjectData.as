package agame.endless.modules.main.model.objects
{
	import agame.endless.modules.main.model.Game;

	public class ObjectData
	{
		public var id:int;
		public var name:String;
		public var displayName:String;
		public var single:String;
		public var plural:String;
		public var actionName:String;
		public var desc:String;
		public var basePrice:Number;
		public var price:Number;
		public var cps:Object=0;
		public var totalCookies:Number=0;
		public var storedCps:Number=0;
		public var storedTotalCps:Number=0;
		public var pic:String=pic;
		public var icon:String;
		public var background:String;
		public var buyFunction:Function;
		public var drawFunction:Function;
		public var sellFunction:Function;

		public var special:String=null; //special is a function that should be triggered when the object's special is unlocked, or on load (if it's already unlocked). For example, creating a new dungeon.
		public var onSpecial:int=0; //are we on this object's special screen (dungeons etc)?
		public var specialUnlocked:int=0;
		public var specialDrawFunction:Function=null;
		public var drawSpecialButton:String=null;

		public var amount:int=0;
		public var bought:int=0;

		public var state:String='';

		public static const STATE_product:String='product';
		public static const STATE_unlocked:String='unlocked';
		public static const STATE_locked:String='locked';
		public static const STATE_enabled:String='enabled';
		public static const STATE_disabled:String='disabled';
		public static const STATE_toggledOff:String='toggledOff';



		public static var ObjectDatasN:int=1;

		public function ObjectData(name:String, commonName:String, desc:String, pic:String, icon:String, background:String, price:Number, cps:Function, drawFunction:Function, buyFunction:Function)
		{

			this.id=ObjectDatasN;
			this.name=name;
			this.displayName=this.name;
			var arr:Array=commonName.split('|');
			this.single=arr[0];
			this.plural=arr[1];
			this.actionName=arr[2];
			this.desc=desc;
			this.basePrice=price;
			this.price=this.basePrice;
			this.cps=cps;
			this.totalCookies=0;
			this.storedCps=0;
			this.storedTotalCps=0;
			this.pic=pic;
			this.icon=icon;
			this.background=background;
			this.buyFunction=buyFunction;
			this.drawFunction=drawFunction;

			this.special=null; //special is a function that should be triggered when the object's special is unlocked, or on load (if it's already unlocked). For example, creating a new dungeon.
			this.onSpecial=0; //are we on this object's special screen (dungeons etc)?
			this.specialUnlocked=0;
			this.specialDrawFunction=null;
			this.drawSpecialButton=null;

			this.amount=0;
			this.bought=0;


//			if (this.id != 0) //draw it
//			{
//				var str='<div class="row" id="row' + this.id + '"><div class="separatorBottom"></div><div class="content"><div id="rowBackground' + this.id + '" class="background" style="background:url(img/' + this.background + '.png) repeat-x;"><div class="backgroundLeft"></div><div class="backgroundRight"></div></div><div class="objects" id="rowObjects' + this.id + '"> </div></div><div class="special" id="rowSpecial' + this.id + '"></div><div class="specialButton" id="rowSpecialButton' + this.id + '"></div><div class="info" id="rowInfo' + this.id + '"><div class="infoContent" id="rowInfoContent' + this.id + '"></div><div><a onclick="ObjectDatasById[' + this.id + '].sell();">Sell 1</a></div></div></div>';
//				l('rows').innerHTML=l('rows').innerHTML + str;
//			}

			Game.Objects[this.name]=this;
			Game.ObjectsById[this.id]=this;
			ObjectDatasN++;
		}

		public function getPrice():int
		{
			var price:Number=this.basePrice * Math.pow(Game.priceIncrease, this.amount);
			if (Game.Has('Season savings'))
				price*=0.99;
			if (Game.Has('Santa\'s dominion'))
				price*=0.99;
			return Math.ceil(price);
		}

		public function buy():void
		{
			var price:Number=this.getPrice();
			if (Game.cookies >= price)
			{
				Game.Spend(price);
				this.amount++;
				this.bought++;
				price=this.getPrice();
				this.price=price;
				if (this.buyFunction)
					this.buyFunction();
				if (this.drawFunction)
					this.drawFunction();
				Game.storeToRebuild=1;
				Game.recalculateGains=1;
//				if (this.amount == 1 && this.id != 0)
//					l('row' + this.id).className='row enabled';
				Game.BuildingsOwned++;
			}
		}

		public function sell():void
		{
			var price:Number=this.getPrice();
			price=Math.floor(price * 0.5);
			if (this.amount > 0)
			{
				//Game.Earn(price);
				Game.cookies+=price;
				this.amount--;
				price=this.getPrice();
				this.price=price;
				if (this.sellFunction)
					this.sellFunction();
				if (this.drawFunction)
					this.drawFunction();
				Game.storeToRebuild=1;
				Game.recalculateGains=1;
				Game.BuildingsOwned--;
			}
		}

		public function setSpecial(what:int):void //change whether we're on the special overlay for this object or not
		{
			if (what == 1)
				this.onSpecial=1;
			else
				this.onSpecial=0;
			if (this.id != 0)
			{
				if (this.onSpecial)
				{
//					l('rowSpecial' + this.id).style.display='block';
					if (this.specialDrawFunction)
						this.specialDrawFunction();
				}
				else
				{
//					l('rowSpecial' + this.id).style.display='none';
					if (this.drawFunction)
						this.drawFunction();
				}
			}
		}

		public function unlockSpecial():void
		{
			if (this.specialUnlocked == 0)
			{
				this.specialUnlocked=1;
				this.setSpecial(0);
				if (this.special)
					this.special();
				this.refresh();
			}
		}

		public function refresh():void
		{
//			this.price=this.getPrice();
//			if (this.amount == 0 && this.id != 0)
//				l('row' + this.id).className='row';
//			else if (this.amount > 0 && this.id != 0)
//				l('row' + this.id).className='row enabled';
//			if (this.drawFunction && !this.onSpecial)
//				this.drawFunction();
			//else if (this.specialDrawFunction && this.onSpecial) this.specialDrawFunction();
		}
	}
}
