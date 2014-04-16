package agame.endless.configs.upgrades
{

	public class UpgradesConfig
	{
		public var id:int;
		public var name:String;
		public var displayName:String;
		public var desc:String;
		public var type:String;
		public var basePrice:int;
		public var tierObject:String;
		public var power:int;
		public var order:int;
		public var hide:int;
		public var season:String;
		public var iconX:int;
		public var iconY:int;
		public function UpgradesConfig()
		{
		}

		public function importClass():void
		{
			var upgradesnamedefs:UpgradesnameDefs;
//导入定义类。
			
		}
	}
}
