package agame.endless.configs.upgrades
{
	import com.agame.services.csv.CSVFile;
	
	import agame.endless.configs.IConfigModel;

	public class UpgradesConfigModel implements IConfigModel
	{
		public var upgrades:Vector.<UpgradesConfig>;

		public function UpgradesConfigModel()
		{
		}

		public function init(data:*):void
		{
			var csvFile:CSVFile=new CSVFile();
			csvFile.read(data).parse();
			const keyLen:int=csvFile.keys.length;
			const lineNum:int=csvFile.valueTables.length;

			upgrades=new Vector.<UpgradesConfig>();
			upgrades.length=lineNum;

			for (var i:int=0; i < lineNum; i++)
			{
				upgrades[i]=new UpgradesConfig();

				for (var j:int=0; j < keyLen; j++)
				{
					if (upgrades[i].hasOwnProperty(csvFile.keys[j]))
						upgrades[i][csvFile.keys[j]]=csvFile.getValue(i, j, i);
				}
			}
			upgrades.fixed=true;
			csvFile.dispose();
			csvFile=null;
		}

		/**
		 * 根据配置ID和等级查找配置。
		 * @param id
		 * @param level 从1开始
		 * @return
		 */
		public function getUpgradesConfigByID(id:int):UpgradesConfig
		{
			const len:int=upgrades.length;

			for (var i:int=0; i < len; i++)
			{
				if (upgrades[i].ID == id)
					return upgrades[i];
			}
			return null;
		}
		
		
		/**
		 * 根据配置ID和等级查找配置。
		 * @param id
		 * @param level 从1开始
		 * @return
		 */
		public function getUpgradesConfigByName(name:String):UpgradesConfig
		{
			const len:int=upgrades.length;
			
			for (var i:int=0; i < len; i++)
			{
				if (upgrades[i].Name == name)
					return upgrades[i];
			}
			return null;
		}
	}
}
