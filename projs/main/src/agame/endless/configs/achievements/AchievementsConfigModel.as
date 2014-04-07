package agame.endless.configs.achievements
{
	import com.agame.services.csv.CSVFile;
	
	import agame.endless.configs.IConfigModel;

	public class AchievementsConfigModel implements IConfigModel
	{
		public var achievements:Vector.<AchievementsConfig>;

		public function AchievementsConfigModel()
		{
		}

		public function init(data:*):void
		{
			var csvFile:CSVFile=new CSVFile();
			csvFile.read(data).parse();
			const keyLen:int=csvFile.keys.length;
			const lineNum:int=csvFile.valueTables.length;

			achievements=new Vector.<AchievementsConfig>();
			achievements.length=lineNum;

			for (var i:int=0; i < lineNum; i++)
			{
				achievements[i]=new AchievementsConfig();

				for (var j:int=0; j < keyLen; j++)
				{
					if (achievements[i].hasOwnProperty(csvFile.keys[j]))
						achievements[i][csvFile.keys[j]]=csvFile.getValue(i, j, i);
				}
			}
			achievements.fixed=true;
			csvFile.dispose();
			csvFile=null;
		}

		/**
		 * 根据配置ID和等级查找配置。
		 * @param id
		 * @param level 从1开始
		 * @return
		 */
		public function getAchievementsConfigByID(id:int):AchievementsConfig
		{
			const len:int=achievements.length;

			for (var i:int=0; i < len; i++)
			{
				if (achievements[i].id == id)
					return achievements[i];
			}
			return null;
		}
		
		
		/**
		 * 根据配置ID和等级查找配置。
		 * @param id
		 * @param level 从1开始
		 * @return
		 */
		public function getAchievementsConfigByName(name:String):AchievementsConfig
		{
			const len:int=achievements.length;
			
			for (var i:int=0; i < len; i++)
			{
				if (achievements[i].name == name)
					return achievements[i];
			}
			return null;
		}
	}
}
