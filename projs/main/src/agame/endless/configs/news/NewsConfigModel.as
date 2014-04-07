package agame.endless.configs.news
{
	import com.agame.services.csv.CSVFile;
	
	import flash.utils.Dictionary;
	
	import agame.endless.configs.IConfigModel;

	public class NewsConfigModel implements IConfigModel
	{
		private var _file:CSVFile;
		
		public var news:Vector.<Vector.<NewsConfig>>;

		private var _idCache:Dictionary;
		
		public function NewsConfigModel()
		{
			_idCache = new Dictionary();
		}

		public function init(data:*):void
		{
			_file = new CSVFile();
			_file.read(data).parse();
			return;
		}
		
		private function generateConfigListOfID(id:int):Boolean
		{
			var startLine:int = _file.getRowIndexByIndexKey(id.toString());
			if(startLine < 0) return false;
			
			var line:int = startLine;
			var configNameIndex:int = _file.keys.indexOf('name');
			var configName:String = _file.valueTables[line][configNameIndex];
			const keyLen:int = _file.keys.length;
			const lineNum:int = _file.valueTables.length;
			
			var newConfigs:Vector.<NewsConfig> = new Vector.<NewsConfig>();
			_idCache[id] = newConfigs;
			
			while(line < lineNum)
			{
				var currentConfigName:String = _file.valueTables[line][configNameIndex];
				
				if (currentConfigName != null && currentConfigName != '' && currentConfigName != configName)
				{
					break;
				}
				
				var newConfig:NewsConfig = new NewsConfig();
				newConfigs.push(newConfig);
				
				for (var j:int = 0 ; j < keyLen ; j++)
				{
					var key:String = _file.keys[j];
					if (newConfig.hasOwnProperty(key))
					{
						newConfig[key] = _file.getValue(line , j , startLine);
					}
				}
				
				
				line++;
			}
			
			return true;
		}

		/**
		 * 根据配置ID和等级查找配置。
		 * @param id
		 * @param level 从1开始
		 * @return
		 */
		public function getNewsConfigByID(id:int , level:int = 1):NewsConfig
		{
			var configList:Vector.<NewsConfig> = getNewsConfigListByID(id);

			if (level < 1)
				level = 1;
			var line:int = level - 1;

			if (configList && configList.length > line)
				return configList[line];
			else
				return null;
		}

		/**
		 * 根据配置Name和等级查找配置。
		 * @param name
		 * @param level 从1开始
		 * @return
		 *
		 */
		public function getNewsConfigByName(name:String , level:int = 1):NewsConfig
		{
			var configList:Vector.<NewsConfig> = getNewsConfigListByName(name);

			if (level < 1)
				level = 1;
			var line:int = level - 1;

			if (configList && configList.length > line)
				return configList[line];
			else
				return null;
		}

		public function getNewsConfigListByID(id:int):Vector.<NewsConfig>
		{
			if(!(id in _idCache))
			{
				if(!generateConfigListOfID(id))
				{
					return null;
				}
			}
			
			return _idCache[id];
		}


		public function getNewsConfigListByName(name:String):Vector.<NewsConfig>
		{
			const len:int = news.length;

			for (var i:int = 0 ; i < len ; i++)
			{
				if (news[i].length > 0 && news[i][0].name == name)
					return news[i];
			}
			return null;
		}

		public function getMaxLevelByID(id:int):int
		{
			var configsList:Vector.<NewsConfig> = getNewsConfigListByID(id);
			if(configsList)
			{
				return configsList.length;
			}
			
			return 0;
		}

		public function getMaxLevelByName(name:String):int
		{
			const len:int = news.length;

			for (var i:int = 0 ; i < len ; i++)
			{
				if (news[i].length > 0 && news[i][0].name == name)
					return news[i].length;
			}
			return 0;
		}
		
		public function getIndexList():Vector.<int>
		{
			var result:Vector.<int> = new Vector.<int>();
			var idCache:Dictionary = _file.indexDict;
			for (var key:String in idCache)
				result.push(int(key));
			
			return result;
		}
	}
}
