package csv
{
	import com.amgame.utils.FileUtil;

	import flash.display.Sprite;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;

	import agame.endless.data.AchementModels;
	import agame.endless.data.ObjectModels;
	import agame.endless.data.UpgradeModels;

	public class csv2as_shell extends Sprite
	{
		public function csv2as_shell()
		{

			var o:ObjectModels=new ObjectModels;
			writeAsFile('config/objects.csv', o.setup());

			var u:UpgradeModels=new UpgradeModels;
			writeAsFile('config/upgrades.csv', u.setup());

			var a:AchementModels=new AchementModels;
			writeAsFile('config/achievements.csv', a.setup());

			start();
		}

		public function writeAsFile(resolvePath:String, data:String):void
		{
			trace('writeFile:', resolvePath);
			var file:File=new File(File.applicationDirectory.resolvePath(resolvePath).nativePath);
			var fs:FileStream=new FileStream;
			fs.open(file, FileMode.WRITE);
			fs.writeUTFBytes(data);
			fs.close();
		}

		public function start():void
		{
			//主程序的csv
			trace('===========主文件的csv=================')
			var csv2as:Csv2asCommand=new Csv2asCommand(File.applicationDirectory.nativePath.replace(File.applicationDirectory.name, 'src/agame/endless/configs'));
			csv2as.configPackage='agame.endless.configs';
			csv2as.csvPath='config/';
			csv2as.configModelPath='AppConfigModel.as';
			csv2as.start();

			//模块的csv
			var modules:File=File.applicationDirectory.resolvePath('config/modules');
			if (modules.exists && modules.isDirectory)
			{
				var files:Array=modules.getDirectoryListing();
				var len:int=files.length;
				var moduleFolder:File;
				for (var i:int=0; i < len; i++)
				{
					moduleFolder=files[i] as File;
					if (moduleFolder.isDirectory && !moduleFolder.isHidden)
						moduleCsv(moduleFolder.name);
				}
			}
		}

		private function moduleCsv(moduleName:String):void
		{
			trace('===========module csv ' + moduleName);
			var ModuleName:String=moduleName.substr(0, 1).toUpperCase() + moduleName.substr(1, moduleName.length);
			var csv2as:Csv2asCommand=new Csv2asCommand(File.applicationDirectory.nativePath.replace(File.applicationDirectory.name, moduleName + '/src/com/tencent/morefun/qqnb/modules/mountainTop/configs'));
			csv2as.configPackage='com.tencent.morefun.qqnb.modules.' + moduleName + '.configs';
			csv2as.csvPath='config/modules/' + moduleName + '/';
			csv2as.configModelPath=ModuleName + 'ConfigModel.as';
			csv2as.start();
		}
	}
}
