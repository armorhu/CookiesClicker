package
{

	public class EmbedAssets
	{
		[Embed(source="../source/fonts/fonts.png")]
		public static const BitmapChars:Class;
		[Embed(source="../source/fonts/fonts.fnt", mimeType="application/octet-stream")]
		public static const BritannicXML:Class;

//		[Embed(source="../source/particle/cookie_rain.pex", mimeType="application/octet-stream")]
//		public static const CookiesFall_XML:Class;
//
//		[Embed(source="../source/particle/cookie_click.pex", mimeType="application/octet-stream")]
//		public static const CookiesCLICK_XML:Class;

		public function EmbedAssets()
		{
		}
	}
}
