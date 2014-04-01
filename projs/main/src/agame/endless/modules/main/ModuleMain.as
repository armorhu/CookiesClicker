package agame.endless.modules.main
{
	import com.agame.framework.module.Module;

	public class ModuleMain extends Module
	{
		protected var _controller:MainController;

		public function ModuleMain()
		{
			super();
		}

		override protected function initliaze():void
		{
			_controller=new MainController(this);
		}
	}
}
