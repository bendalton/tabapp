/**
* ...
* @author Martin Legris ( http://blog.martinlegris.com )
* @version 0.1
*/

package ca.newcommerce.youtube
{
	import ca.newcommerce.youtube.data.AuthorData;	
	import ca.newcommerce.youtube.data.CategoryData;	
	import ca.newcommerce.youtube.data.GeneratorData;
	import ca.newcommerce.youtube.data.LinkData;
	import ca.newcommerce.youtube.data.MediaContentData;	
	import ca.newcommerce.youtube.data.MediaGroupData;
	import ca.newcommerce.youtube.data.RatingData;
	import ca.newcommerce.youtube.data.ThumbnailData;	
	import ca.newcommerce.youtube.data.VideoData;
	import ca.newcommerce.youtube.events.CommentFeedEvent;
	import ca.newcommerce.youtube.events.ContactFeedEvent;
	import ca.newcommerce.youtube.events.PlaylistFeedEvent;
	import ca.newcommerce.youtube.events.ProfileEvent;
	import ca.newcommerce.youtube.events.ResponseFeedEvent;
	import ca.newcommerce.youtube.events.StandardVideoFeedEvent;
	import ca.newcommerce.youtube.events.SubscriptionFeedEvent;
	import ca.newcommerce.youtube.events.VideoFeedEvent;
	import ca.newcommerce.youtube.events.YouTubeEvent;
	import ca.newcommerce.youtube.webservice.YouTubeClient;
	
	import ca.newcommerce.youtube.feeds.VideoFeed;
	import ca.newcommerce.youtube.iterators.LinkIterator;
	import ca.newcommerce.youtube.iterators.ThumbnailIterator;
	import ca.newcommerce.youtube.iterators.CategoryIterator;
	import ca.newcommerce.youtube.iterators.MediaContentIterator;
	import ca.newcommerce.youtube.iterators.AuthorIterator;
	
	import com.adobe.serialization.json.JSON;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLLoaderDataFormat;	
	import flash.events.NetStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.ProgressEvent;	

	public class Test extends MovieClip 
	{		
		protected var _ws:YouTubeClient;
		
		public function Test()
		{			
			_ws = YouTubeClient.getInstance();
			
			initEvents();
			
			startTest();
		}		
		
		protected function initEvents():void
		{
			_ws.addEventListener(CommentFeedEvent.COMMENT_DATA_RECEIVED, doCommentFeedReady);
			_ws.addEventListener(ContactFeedEvent.USER_DATA_RECEIVED, doContactsReady);
			_ws.addEventListener(PlaylistFeedEvent.PLAYLIST_DATA_RECEIVED, doPlaylistFeedReady);
			_ws.addEventListener(ResponseFeedEvent.RESPONSES_DATA_RECEIVED, doResponseFeedReady);
			_ws.addEventListener(StandardVideoFeedEvent.STANDARD_VIDEO_DATA_RECEIVED, doStandardVideoFeedReady);
			_ws.addEventListener(VideoFeedEvent.RELATED_VIDEOS_DATA_RECEIVED, doRelatedVideosReady);
			_ws.addEventListener(VideoFeedEvent.USER_FAVORITES_DATA_RECEIVED, doFavoritesReady);
			_ws.addEventListener(VideoFeedEvent.VIDEO_FEED_READY, doVideoFeedReady);
			_ws.addEventListener(VideoFeedEvent.VIDEO_PLAYLIST_DATA_RECEIVED, doPlaylistReady);
			_ws.addEventListener(VideoFeedEvent.VIDEO_DATA_RECEIVED, doVideosReady);
			_ws.addEventListener(ProfileEvent.PROFILE_DATA_RECEIVED, doProfileReady);
			_ws.addEventListener(SubscriptionFeedEvent.SUBSCRIPTION_DATA_RECEIVED, doSubscriptionsReady);
			
			_ws.addEventListener(YouTubeEvent.LOGIN_SUCCESSFULL, doLoggedIn);
			_ws.addEventListener(YouTubeEvent.RATING_SUCCESSFULL, doRating);
		}
		
		protected function startTest():void
		{
			//_ws.getUserProfile("rocketboom");
			//_ws.getUserSubscriptions("mememolly");
			//_ws.getVideoResponses("UwOA8H5Vaak");
			//_ws.getUserContacts("mememolly");
			//_ws.getUserSubscriptions("mememolly");
			//_ws.getVideoComments("24Ryj1ywoqw");	
			//_ws.getUserPlaylists("mememolly");
			//_ws.getVideoComments("KDxLxIJ0oWI");
			//_ws.getStandardFeed(YouTubeClient.STD_RECENTLY_FEATURED, YouTubeClient.TIME_WEEK, 1, 10);
			//_ws.getStandardFeed(YouTubeClient.STD_TOP_RATED, YouTubeClient.TIME_MONTH, 1, 10);
			//_ws.getStandardFeed(YouTubeClient.STD_MOST_DISCUSSED, YouTubeClient.TIME_TODAY);
			//_ws.getStandardFeed(YouTubeClient.STD_MOST_RESPONSED, YouTubeClient.TIME_ALL);
			
			// this call get you all videos that match "martial arts" query, and have the keywords "violent" and "boxing", but not the keyword "blood", ordered by viewCount, and include restricted material.
			//_ws.getVideos("martial arts", "", null, null, ["violent", "boxing"], ["blood"], YouTubeClient.ORDER_BY_VIEWCOUNT, YouTubeClient.RACY_INCLUDE, 1, 10);
			_ws.login("username", "password");
		}
		
		protected function doLoggedIn(evt:YouTubeEvent):void
		{
			_ws.rate("cOa1kHEiIpg", 5);
			//_ws.favorite("66w7a1U1f-M");
			//_ws.unfavorite("66w7a1U1f-M");
			_ws.getVideo("JKf7pPj6T7M");
		}
		
		protected function doRating(evt:YouTubeEvent):void
		{
			
		}
		
		protected function doVideosReady(evt:VideoFeedEvent):void
		{
			DataTracer.traceVideos(evt.feed);
		}
		
		protected function doSubscriptionsReady(evt:SubscriptionFeedEvent):void
		{
			DataTracer.traceSubscriptions(evt.feed);
		}
		
		protected function doCommentFeedReady(evt:CommentFeedEvent):void
		{
			DataTracer.traceComments(evt.feed);
		}
		
		protected function doContactsReady(evt:ContactFeedEvent):void
		{
			DataTracer.traceContacts(evt.feed);
		}
		
		protected function doPlaylistFeedReady(evt:PlaylistFeedEvent):void
		{
			DataTracer.tracePlaylists(evt.feed);
		}
		
		protected function doResponseFeedReady(evt:ResponseFeedEvent):void
		{
			DataTracer.traceVideos(evt.feed);
		}
		
		protected function doStandardVideoFeedReady(evt:StandardVideoFeedEvent):void
		{
			DataTracer.traceVideos(evt.feed);
		}
		
		protected function doRelatedVideosReady(evt:VideoFeedEvent):void
		{
			DataTracer.traceVideos(evt.feed);
		}
		
		protected function doFavoritesReady(evt:VideoFeedEvent):void
		{
			DataTracer.traceVideos(evt.feed);
		}
		
		protected function doVideoFeedReady(evt:VideoFeedEvent):void
		{
			DataTracer.traceVideos(evt.feed);
		}
		
		protected function doPlaylistReady(evt:VideoFeedEvent):void
		{
			DataTracer.traceVideos(evt.feed);
		}
		
		protected function doProfileReady(evt:ProfileEvent):void
		{
			DataTracer.traceProfile(evt.profile);			
		}	
	}
}