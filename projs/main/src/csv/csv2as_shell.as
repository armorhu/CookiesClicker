package csv
{
	import flash.display.Sprite;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;

	import agame.endless.configs.lang.LangPattern;
	import agame.endless.data.AchementModels;
	import agame.endless.data.NewTickerModel;
	import agame.endless.data.ObjectModels;
	import agame.endless.data.TextData;
	import agame.endless.data.UpgradeModels;

	public class csv2as_shell extends Sprite
	{
		public function csv2as_shell()
		{
//			genCSV();
			genCharset();
//			genConfigModel();
		}

		private function genCSV():void
		{
			customText();
			var o:ObjectModels=new ObjectModels;
			writeAsFile('config/objects.csv', o.setup());

			var u:UpgradeModels=new UpgradeModels;
			writeAsFile('config/upgrades.csv', u.setup());

			var a:AchementModels=new AchementModels;
			writeAsFile('config/achievements.csv', a.setup());

			var n:NewTickerModel=new NewTickerModel;
			writeAsFile('config/news.csv', n.setup());
			writeAsFile('config/texts_auto.csv', TextData.result_text);
		}

		private function genCharset():void
		{
			//从texts.csv里生产 charset.
			var texts:String=readFile(File.applicationDirectory.resolvePath('config/texts.csv').nativePath);
			var len:int=texts.length;
			var charSet:String=''
			for (var i:int=0; i < len; i++)
			{
				if (texts.charAt(i) == ' ' || texts.charAt(i) == '\n' || texts.charAt(i) == '\r')
					continue;
				if (charSet.indexOf(texts.charAt(i)) == -1)
					charSet=charSet + texts.charAt(i);
			}
			writeAsFile('charset.txt', charSet, false);
		}

		private function customText():void
		{
			TextData.formatAndPush('Cookies', LangPattern.Number + ' Cookies');
			TextData.formatAndPush('Cps', '+' + LangPattern.Number + ' Cookies per secend!');
		}

		public function readFile(path:String):String
		{
			trace('readFile:', path);
			var file:File=new File(path);
			if (file.exists == false || file.isDirectory == true)
				return '';
			var fs:FileStream=new FileStream;
			fs.open(file, FileMode.READ);
			var result:String=fs.readUTFBytes(fs.bytesAvailable);
			fs.close();
			return result;
		}

		public function writeAsFile(resolvePath:String, data:String, chaset:Boolean=true):void
		{
			trace('writeFile:', resolvePath);
			var file:File=new File(File.applicationDirectory.resolvePath(resolvePath).nativePath);
			var fs:FileStream=new FileStream;
			fs.open(file, FileMode.WRITE);
			fs.writeUTFBytes(data);
			fs.close();
		}

		public function genConfigModel():void
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
