package com.bendalton.mytabs.model
{
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class YouTubeModel
	{
		private static var instance:YouTubeModel;
		public function YouTubeModel()
		{
			if(instance)
				throw new Error('Singleton!');
		}
		
		public static function getInstance():YouTubeModel
		{
			if(!instance) instance = new YouTubeModel();
			return instance;
		}
		
		public var videos:ArrayCollection;

	}
}