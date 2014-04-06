package
{

	public class EmbedFont
	{
		[Embed(source="../source/fonts/fonts_png.png")]
		public static const BitmapChars:Class;
		[Embed(source="../source/fonts/fonts_fnt.fnt", mimeType="application/octet-stream")]
		public static const BritannicXML:Class;

		public function EmbedFont()
		{
		}
	}
}
