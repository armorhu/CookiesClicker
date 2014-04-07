package agame.endless.configs.lang
{
	import com.agame.services.csv.CSVFile;

	public class LangConfigModel
	{
		public static var texts:Object={};
		public static var lang:String='';

		public function LangConfigModel()
		{
		}

		public static function init(data:*, $lang:String):void
		{
			lang=$lang;
			var csvFile:CSVFile=new CSVFile();
			csvFile.read(data).parse();
			var len:int=csvFile.valueTables.length;
			var langIndex:int=csvFile.keys.indexOf(lang);
			for (var i:int=0; i < len; i++)
				texts[csvFile.valueTables[i][0]]=csvFile.getValue(i, langIndex, i);
			csvFile.dispose();
			csvFile=null;
		}
	}
}
