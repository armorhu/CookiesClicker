package agame.endless.configs.objects
{
	import com.agame.services.csv.CSVFile;
	
	import agame.endless.configs.IConfigModel;

	public class ObjectsConfigModel implements IConfigModel
	{
		public var objects:Vector.<ObjectsConfig>;

		public function ObjectsConfigModel()
		{
		}

		public function init(data:*):void
		{
			var csvFile:CSVFile=new CSVFile();
			csvFile.read(data).parse();
			const keyLen:int=csvFile.keys.length;
			const lineNum:int=csvFile.valueTables.length;

			objects=new Vector.<ObjectsConfig>();
			objects.length=lineNum;

			for (var i:int=0; i < lineNum; i++)
			{
				objects[i]=new ObjectsConfig();

				for (var j:int=0; j < keyLen; j++)
				{
					if (objects[i].hasOwnProperty(csvFile.keys[j]))
						objects[i][csvFile.keys[j]]=csvFile.getValue(i, j, i);
				}
			}
			objects.fixed=true;
			csvFile.dispose();
			csvFile=null;
		}

		/**
		 * 根据配置ID和等级查找配置。
		 * @param id
		 * @param level 从1开始
		 * @return
		 */
		public function getObjectsConfigByID(id:int):ObjectsConfig
		{
			const len:int=objects.length;

			for (var i:int=0; i < len; i++)
			{
				if (objects[i].id == id)
					return objects[i];
			}
			return null;
		}
		
		
		/**
		 * 根据配置ID和等级查找配置。
		 * @param id
		 * @param level 从1开始
		 * @return
		 */
		public function getObjectsConfigByName(name:String):ObjectsConfig
		{
			const len:int=objects.length;
			
			for (var i:int=0; i < len; i++)
			{
				if (objects[i].name == name)
					return objects[i];
			}
			return null;
		}
	}
}
