package agame.endless.configs.lang
{
	import agame.endless.configs.AppConfig;

	public function Lang(tid:String):String
	{
		var result:String=LangConfigModel.texts[tid];
		if (!result)
			result=tid;
		return result;
	}
}
