package agame.endless.work.init
{
	import agame.endless.EndlessApplication;
	import agame.endless.enm.EnmModuleName;
	import agame.endless.work.EndlessWork;

	/**
	 * 启动模块
	 * @author hufan
	 */
	public class LaunchModuleWork extends EndlessWork
	{
		public function LaunchModuleWork(app:EndlessApplication)
		{
			super(app);
		}

		override public function start():void
		{
			//启动主模块
			app.loadModule(EnmModuleName.Main);
			workComplete();
		}
	}
}
