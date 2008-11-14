/**
* ...
* @author Martin Legris
* @version 0.1
*/

package ca.newcommerce.youtube.events
{
	import flash.events.Event;

	public class YouTubeEvent extends Event
	{
		public static const RAW_URL_DATA_RECEIVED:String = "raw_url_data_received";
		public static const LOGIN_SUCCESSFULL:String = "login_successfull";
		public static const RATING_SUCCESSFULL:String = "rating_successfull";
		
		protected var _requestId:Number = -1;
		protected var _requestWrapper:Object;
		
		public function YouTubeEvent(type:String, requestWrapper:Object)
		{
			super(type);
			_requestId = requestWrapper.id;
			_requestWrapper = requestWrapper;
		}
		
		public function get requestId():Number
		{
			return _requestId;
		}
		
		public function get requestWrapper():Object
		{
			return _requestWrapper;
		}
	}
}