package agame.endless.modules.main.model.prefs
{

	public class AppPrefs
	{
		public var particles:int=1; //particle effects : falling cookies etc
		public var numbers:int=1; //numbers that pop up when clicking the cookie
		public var autosave:int=1; //save the game every minute or so
		public var autoupdate:int=1; //send an AJAX request to the server every 30 minutes (crashes the game when playing offline)
		public var milk:int=1; //display milk
		public var fancy:int=1; //CSS shadow effects (might be heavy on some browsers)
		public var warn:int=0; //warn before closing the window
		public var cursors:int=1; //display cursors

		public function AppPrefs()
		{
		}
	}
}
