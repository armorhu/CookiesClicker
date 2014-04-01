package csv
{
	import com.agame.services.csv.CSVFile;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;

	public class Csv2asCommand
	{


		public static const ImportTagStart:String='	/**自动生成的import代码--start**/';

		public static const ImportTagEnd:String='	/**自动生成的import代码--end**/';

		public static const PropertyTagStart:String='		/**自动生成的属性代码--start**/';

		public static const PropertyTagEnd:String='		/**自动生成的属性代码--end**/';

		public static const ModelLogicTagStart:String='		/**自动生产的logic代码--start**/';

		public static const ModelLogicTagEnd:String='		/**自动生产的logic代码--end**/';

		public function Csv2asCommand(asPath:String)
		{
			asFolder=new File(asPath);
		}
		public var csvPath:String='';

		public var configPackage:String='';

		public var asFolder:File;

		public var fs:FileStream;

		/**
		 *二维配置
		 */
		public var template2ConfigModel:String;

		/**
		 *配置model模版。一维配置。
		 */
		public var templateConfigModel:String;

		/**
		 *配置模版
		 */
		public var templateConfigStr:String;

		/**
		 *配置定义
		 */
		public var templateDefs:String;

		/**
		 *管理类
		 */
		public var configModelStr:String;

		public var configModelPath:String;

		public var appConfig_ImportContent:String='';

		public var appConfig_PropertyContent:String='';

		public var appConfig_ModelLogicContent:String='';


		public function csv2as(configName:String, model2:Boolean, defs:String=''):void
		{
			if (configName == null || configName == '')
				return;
			var configClass:String=templateConfigStr;
			var modelClass:String=model2 ? template2ConfigModel : templateConfigModel;

			var data:String=readFile(File.applicationDirectory.resolvePath(csvPath + configName).nativePath);
			var csvFile:CSVFile=new CSVFile();
			csvFile.read(data).parse();

			if (model2 && (csvFile.keys.indexOf('ID') == -1 || csvFile.keys.indexOf('Name') == -1))
			{
				trace('csv2as', configName, model2, 'failed!!!!!');
				return;
			}
			var name:String=configName.replace('.csv', '');
			var className:String=toUperCaseHead(name);
			var propertyName:String=toLowerCaseHead(name);




			//defs
			var importDefs:String='';
			if (defs.length > 0)
			{
				var defsArr:Array=defs.split('|');
				var nameIndex:int=csvFile.keys.indexOf('Name');
				len=defsArr.length;
				var rows:int=csvFile.valueTables.length;
				for (i=0; i < len; i++)
				{
					var defsName:String=defsArr[i];
					var defsIndex:int=csvFile.keys.indexOf(defsName);
					var defsType:String=csvFile.formatTypeString(csvFile.types[defsIndex]);
					if (defsIndex == -1)
					{
						trace('error:' + defsName + '在' + configName + '.csv里没有找到');
						continue;
					}
					var defsClass:String=templateDefs;
					var insertIndex2:int=defsClass.indexOf('		public function TemplateDefs()');
					var insertStr:String='';
					for (var j:int=0; j < rows; j++)
					{
						var namesValue:String=csvFile.valueTables[j][nameIndex];
						if (namesValue == '' || namesValue == null)
							continue;
						namesValue = namesValue.replace(/ /g,'_');
						var defsValue:String=csvFile.getValue(j, defsIndex, j);
						if (defsType == 'String')
							defsValue='"' + defsValue + '"';
						insertStr=insertStr + '		public static const ' + namesValue + ':' + defsType + ' = ' + defsValue + ';\n';
					}
					defsClass=defsClass.substr(0, insertIndex2) + insertStr + defsClass.substr(insertIndex2);
					defsClass=defsClass.replace(/template/g, propertyName);
					defsClass=defsClass.replace(/Template/g, className + defsName);
					importDefs=importDefs + 'var ' + (className + defsName + 'Defs').toLocaleLowerCase() + ':' + className + defsName + 'Defs;\n';
					writeAsFile(propertyName + '/' + className + defsName + 'Defs.as', defsClass);
				}
			}

			var propertys:String='';
			var len:int=csvFile.keys.length;

			for (var i:int=0; i < len; i++)
				propertys=propertys + propertyString(csvFile.keys[i], csvFile.types[i]) + '\n';
			configClass=configClass.replace(/template/g, propertyName);
			configClass=configClass.replace(/Template/g, className);

			var insertIndex:int=configClass.indexOf('		public function ');
			configClass=configClass.substr(0, insertIndex) + propertys + configClass.substr(insertIndex);

			configClass=configClass.replace('com.tencent.morefun.qqnb.model.config', configPackage);
			if (importDefs.length > 0)
			{
				var importIndex:int=configClass.indexOf('//导入定义类。');
				configClass=configClass.substr(0, importIndex) + importDefs + configClass.substr(importIndex);
			}

			writeAsFile(propertyName + '/' + className + 'Config.as', configClass);

			modelClass=modelClass.replace(/template/g, propertyName);

			if (model2)
				modelClass=modelClass.replace(/Template2/g, className);
			modelClass=modelClass.replace(/Template/g, className);
			modelClass=modelClass.replace('com.tencent.morefun.qqnb.model.config', configPackage);
			writeAsFile(propertyName + '/' + className + 'ConfigModel.as', modelClass);

			var importStr:String='	import ' + configPackage + '.' + propertyName + '.' + className + 'ConfigModel';
			appConfig_ImportContent=appConfig_ImportContent + importStr + ';\n';

			appConfig_PropertyContent=appConfig_PropertyContent + propertyString(propertyName + 'ConfigModel', className + 'ConfigModel') + '\n';
			appConfig_ModelLogicContent=appConfig_ModelLogicContent + //
				'			' + propertyName + 'ConfigModel = new ' + className + 'ConfigModel;\n' + //
				'			bindle("' + csvPath + configName + '",' + propertyName + 'ConfigModel' + ');\n';
		}

		public function propertyString(propertyName:String, propertyClass:String):String
		{
			return '		public var ' + propertyName + ':' + propertyClass + ';';
		}

		public function start():void
		{
			fs=new FileStream();
			var csv2asConfigContent:String=readFile(File.applicationDirectory.resolvePath(csvPath + 'csv2as.txt').nativePath);
			if(csv2asConfigContent == '')
				return;
			while (csv2asConfigContent.indexOf("\r") != -1)
				csv2asConfigContent=csv2asConfigContent.replace("\r", "");
			var csv2asList:Array=csv2asConfigContent.split('\n');
			if (csv2asList.length > 0)
			{
				trace('Csv2asCommand start.......')
				trace(asFolder.nativePath);
				templateConfigStr=readFile(File.applicationDirectory.nativePath.replace(File.applicationDirectory.name, 'src/agame/endless/configs/template/TemplateConfig.as'));
				templateConfigModel=readFile(File.applicationDirectory.nativePath.replace(File.applicationDirectory.name, 'src/agame/endless/configs/template/TemplateConfigModel.as'));
				template2ConfigModel=readFile(File.applicationDirectory.nativePath.replace(File.applicationDirectory.name, 'src/agame/endless/configs/template/Template2ConfigModel.as'));
				templateDefs=readFile(File.applicationDirectory.nativePath.replace(File.applicationDirectory.name, 'src/agame/endless/configs/template/TemplateDefs.as'));
				configModelStr=readFile(asFolder.resolvePath(configModelPath).nativePath);
				for (var i:int=0; i < csv2asList.length; i++)
				{
					var csv2asConfig:Array=String(csv2asList[i]).split(',');
					var defs:String=csv2asConfig.length > 2 ? csv2asConfig[2] : "";
					csv2as(csv2asConfig[0], csv2asConfig[1] == 'true', defs);
				}
				configModelStr=insertString( //
					configModelStr, //
					appConfig_ImportContent, //
					ImportTagStart, ImportTagEnd);
				configModelStr=insertString( //
					configModelStr, // 
					appConfig_PropertyContent, //
					PropertyTagStart, PropertyTagEnd //
					);
				configModelStr=insertString(configModelStr, // 
					appConfig_ModelLogicContent, //
					ModelLogicTagStart, ModelLogicTagEnd //
					);
				writeAsFile(configModelPath, configModelStr);
				trace('Csv2asCommand end.......')
			}
		}

		public function insertString(source:String, target:String, startTag:String, endTag:String):String
		{
			var start:int=source.indexOf(startTag) + startTag.length;
			var end:int=source.indexOf(endTag);
			return source.substring(0, start) + '\n' + target + source.substring(end);
		}

		public function toLowerCaseHead(result:String):String
		{
			return result.substr(0, 1).toLowerCase() + result.substr(1, result.length - 1);
		}

		public function toUperCaseHead(result:String):String
		{
			return result.substr(0, 1).toUpperCase() + result.substr(1, result.length - 1);
		}

		public function readFile(path:String):String
		{
			trace('readFile:', path);
			var file:File=new File(path);
			if (file.exists == false || file.isDirectory == true)
				return '';
			fs.open(file, FileMode.READ);
			var result:String=fs.readUTFBytes(fs.bytesAvailable);
			fs.close();
			return result;
		}

		public function writeAsFile(resolvePath:String, data:String):void
		{
			trace('writeFile:', resolvePath);
			var file:File=asFolder.resolvePath(resolvePath);
			fs.open(file, FileMode.WRITE);
			fs.writeUTFBytes(data);
			fs.close();
		}
	}
}
