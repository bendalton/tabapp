package com.bendalton.mytabs.controller
{
	import ca.newcommerce.youtube.data.VideoData;
	import ca.newcommerce.youtube.events.VideoFeedEvent;
	import ca.newcommerce.youtube.feeds.VideoFeed;
	import ca.newcommerce.youtube.webservice.YouTubeClient;
	
	import com.bendalton.mytabs.model.YouTubeModel;
	import com.bendalton.mytabs.view.YouTubePanel;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	
	import mx.collections.ArrayCollection;
	
	public class YouTubeController extends EventDispatcher
	{
		// YouTube ClientID: ytapi-BenDalton-TabApp-a6bkr7hh-0
		// YouTube Developer Key: AI39si4l_ZS7yhHl3IhWhab3pg69VqlhcoduBIqtqhHRul
		private var service:YouTubeClient = YouTubeClient.getInstance();
		
		public var model:YouTubeModel = YouTubeModel.getInstance();
		public var view:YouTubePanel;
		
		public function YouTubeController()
		{
			super();
		}
		
		public function requestVideos(searchString:String):void
		{
			service.addEventListener(VideoFeedEvent.VIDEO_DATA_RECEIVED, onVideosResult);
			service.getVideos(searchString);
		}
		
		private function onVideosResult(event:VideoFeedEvent):void
		{
			model.videos = parseFeed(event.feed);
			playVideo(event.feed.next());
		}
		
		private function parseFeed(feed:VideoFeed):ArrayCollection
		{
			var collection:ArrayCollection = new ArrayCollection();
			//while(var video:VideoData = feed.next())
			///{
			//	trace(video.swfUrl)
			//}
			return collection
		}
		
		private var loader:Loader = new Loader();
		private function playVideo(vid:VideoData):void
		{
			startLoading(vid.actualId)//vid.links.first().href);
		}
		private function startLoading (vidID:String):void
		{
			
			var req:URLRequest = new URLRequest("http://www.youtube.com/v/"+vidID);
			loader.contentLoaderInfo.addEventListener(Event.INIT, handlerLoaderInit);
			loader.load(req);
			logMessage ("Loading YouTube URL.."+vidID);
		}
		
		private function handlerLoaderInit (event:Event):void
		{
			logMessage ("Loaded, processing: " + loader.contentLoaderInfo.url);
			var urlVars:URLVariables = new URLVariables ();
			urlVars.decode (loader.contentLoaderInfo.url.split("?")[1]);
			logMessage ("Processed:-");
			logMessage ("\t\t video_id:" + urlVars.video_id);
			logMessage ("\t\t t param:" + urlVars.t);
			logMessage ("\t\t thumbnail-url:" + urlVars.iurl);
			var flvURL:String = constructFLVURL (urlVars.video_id, urlVars.t);
			logMessage ("YouTube FLV URL: " + flvURL);
			view.player.source = flvURL;
			logMessage ("Started Playing Video...");
			loader.unload(); 
		}
		private function constructFLVURL (video_id:String, t:String):String
		{
			var str:String = "http://www.youtube.com/get_video.php?";
			str += "video_id=" + video_id;
			str += "&t=" + t;
			return str;
		}
		private function logMessage(message:String):void
		{
			trace(message);
		}
	}
}