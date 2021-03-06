package com.bendalton.mytabs.controller
{
	import com.bendalton.mytabs.UltimateGuitarService;
	import com.bendalton.mytabs.model.Tab;
	import com.bendalton.mytabs.model.ViewerModel;
	import com.bendalton.mytabs.view.Viewer;
	
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.Sort;
	import mx.collections.SortField;
	import mx.events.DynamicEvent;
	import mx.events.ListEvent;

	public class ViewerController extends EventDispatcher
	{

		public function ViewerController(view:Viewer = null, model:ViewerModel = null, service:UltimateGuitarService = null)
		{
			super();
			view = view;
			model = model;
			service = service;
		}
		
		public var view:Viewer;
		public var model:ViewerModel;	
		public var service:UltimateGuitarService;
		
		public function initView():void
		{
			checkReqs();
			if(!model.authenticated)
				getAuth();
			else
				getTabs();
		}
		
		private function getAuth():void
		{
			service.addEventListener('loginSuccess',onLoginSuccess);
			view.dispatchEvent(new Event('needLogin'));
		}

		
		private function onLoginSuccess(event:Event):void
		{
			model.currentState = "";
			getTabs();
		}
		
		private function onLoginFailure(event:ErrorEvent):void
		{
			trace(event.text);
		}
		
		
		private function checkReqs():void
		{
			if(!view || !model || !service)
				throw new Error('ViewerController must contain a reference to the model, view, and service.');
		}
		
		private function getTabs():void
		{
			service.requestTabs();
			service.addEventListener('tabs',onTabResult);
		}
		
		private function onTabResult(event:Event):void
		{
			model.tabCollection = service.tabs
			var sort:Sort = new Sort();
			sort.fields = [new SortField('name_art'),new SortField('name')];
			model.tabCollection.sort = sort;
			model.tabCollection.refresh();
			trace('tabs!');
		}
		
		public function onTabClick(tab:Tab):void
		{
			view.youTube.controller.requestVideos(tab.name+" "+tab.name_art);
			model.currentLocation = "http://www.ultimate-guitar.com/print.php?what=tab&id="+tab.id as String;
		}
		
	}
}