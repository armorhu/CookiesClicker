package agame.endless.modules.main
{
	import com.agame.framework.module.Module;

	public class ModuleMain extends Module
	{
		protected var _controller:MainController;

		public function ModuleMain(name:String)
		{
			super(name);
		}

		override protected function initController():void
		{
			_controller=new MainController(this);
		}
	}
}
