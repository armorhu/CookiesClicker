package csv.data
{
	import com.agame.utils.formatTID;

	import flash.text.TextField;

	public class TextData
	{
		public function TextData()
		{
		}

		public static var texts:Object={};

		public static var result_text:String='TID,EN\n' + 'String,String\n';

		private static var tf:TextField=new TextField;

		public static function formatAndPush(key:String, content:String):String
		{
			var tid:String='TID_' + formatTID(key, true).toUpperCase();
//			trace(tid);
			if (texts[tid] != undefined)
				throw new Error(tid + ' is already exsit!');
			content=content.replace(/"/g, "'");
			tf.htmlText=content;
			content=tf.text;
			texts[tid]=content;
			result_text=result_text + tid + ',"' + content + '"\n';
			return tid;
		}
	}
}
