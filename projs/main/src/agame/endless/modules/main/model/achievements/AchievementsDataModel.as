package agame.endless.modules.main.model.achievements
{
	import com.agame.services.csv.CSVFile;

	import flash.utils.ByteArray;

	import agame.endless.services.assets.Assets;

	public class AchievementsDataModel
	{
		public function AchievementsDataModel()
		{
		}

		public static function setup():void
		{
			AchievementData.csvFile=new CSVFile();
			var ba:ByteArray=Assets.current.getByteArray('achievements');
			AchievementData.csvFile.read(ba.readUTFBytes(ba.bytesAvailable)).parse();

			var len:int=AchievementData.csvFile.valueTables.length;
			for (var i:int=0; i < len; i++)
				new AchievementData();

			Assets.current.removeByteArray('achievements');
			AchievementData.csvFile.dispose();

			trace('setup achievements complete,total=' + AchievementData.AchievementsN);
		}
	}
}
