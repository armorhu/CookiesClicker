package agame.endless.services.utils
{
	import agame.endless.services.assets.Assets;

	public function useEmbedFont(textfield:Object, autoScale:Boolean=true):void
	{
		textfield.fontName=Assets.FontName;
		textfield.autoScale=autoScale;
	}
}
