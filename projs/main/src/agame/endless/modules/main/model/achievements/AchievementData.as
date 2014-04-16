package agame.endless.modules.main.model.achievements
{
	import com.agame.services.csv.CSVFile;

	import agame.endless.configs.achievements.AchievementsConfig;
	import agame.endless.modules.main.model.Game;

	public class AchievementData extends AchievementsConfig
	{
		public var won:int=0;
		public var disabled:int=0;


		public static var AchievementsN:int=0;

		public static var csvFile:CSVFile;
		private static var sHeplerKeys:Array;

		public function AchievementData()
		{
			super();
			sHeplerKeys=csvFile.keys;
			var len:int=sHeplerKeys.length;
			for (var i:int=0; i < len; i++)
				this[sHeplerKeys[i]]=csvFile.getValue(AchievementsN, i, AchievementsN);
			this.id=AchievementsN;

			AchievementsN++;
			Game.Achievements[this.name]=this;
			Game.AchievementsById[this.id]=this;
		}
	}
}
