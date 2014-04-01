package agame.endless.model.upgrade
{

	public class Upgrade
	{
		public var id:int;
		public var name:String;
		public var desc:String;
		public var basePrice:Number;
		public var buyFunction:Function;
		
		/**
		 *是否购买 
		 */		
		public var bought:Boolean;
		
		/**
		 *是否解锁 
		 */		
		public var unlocked:Boolean;

		public function Upgrade()
		{
		}
	}
}
