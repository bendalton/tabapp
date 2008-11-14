package com.bendalton.mytabs.model
{
	import mx.collections.ArrayCollection;
	
	public class ViewerModel
	{
		
		private static var instance:ViewerModel;
		
		public function ViewerModel()
		{
			if(instance)
				throw new Error("Singleton!");	
		}
		
		public static function getInstance():ViewerModel
		{
			if(!instance) instance = new ViewerModel();
			return instance;
		}
		
		[Bindable]
		public var tabCollection:ArrayCollection;
		
		[Bindable]
		public var currentLocation:String = "assets/instructions.html";
		
		[Bindable]
		public var currentState:String = "";
		
		[Bindable]
		public var authenticated:Boolean = false;

	}
}