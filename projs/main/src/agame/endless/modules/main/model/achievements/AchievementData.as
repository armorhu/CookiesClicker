package agame.endless.modules.main.model.achievements
{
	import agame.endless.configs.achievements.AchievementsConfig;

	public class AchievementData extends AchievementsConfig
	{
		public var won:int=0;
		public var disabled:int=0;

		public function AchievementData()
		{
			super();
		}
	}
}
