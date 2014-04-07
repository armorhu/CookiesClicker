package agame.endless.configs.texts
{
	import com.agame.services.csv.CSVFile;
	
	import agame.endless.configs.IConfigModel;

	public class TextsConfigModel implements IConfigModel
	{
		public var texts:Vector.<TextsConfig>;

		public function TextsConfigModel()
		{
		}

		public function init(data:*):void
		{
			var csvFile:CSVFile=new CSVFile();
			csvFile.read(data).parse();
			const keyLen:int=csvFile.keys.length;
			const lineNum:int=csvFile.valueTables.length;

			texts=new Vector.<TextsConfig>();
			texts.length=lineNum;

			for (var i:int=0; i < lineNum; i++)
			{
				texts[i]=new TextsConfig();

				for (var j:int=0; j < keyLen; j++)
				{
					if (texts[i].hasOwnProperty(csvFile.keys[j]))
						texts[i][csvFile.keys[j]]=csvFile.getValue(i, j, i);
				}
			}
			texts.fixed=true;
			csvFile.dispose();
			csvFile=null;
		}

		/**
		 * 根据配置ID和等级查找配置。
		 * @param id
		 * @param level 从1开始
		 * @return
		 */
		public function getTextsConfigByID(id:int):TextsConfig
		{
			const len:int=texts.length;

			for (var i:int=0; i < len; i++)
			{
				if (texts[i].id == id)
					return texts[i];
			}
			return null;
		}
		
		
		/**
		 * 根据配置ID和等级查找配置。
		 * @param id
		 * @param level 从1开始
		 * @return
		 */
		public function getTextsConfigByName(name:String):TextsConfig
		{
			const len:int=texts.length;
			
			for (var i:int=0; i < len; i++)
			{
				if (texts[i].name == name)
					return texts[i];
			}
			return null;
		}
	}
}
