package com.bendalton.mytabs
{
	import com.adobe.crypto.MD5;
	import com.adobe.serialization.json.JSON;
	import com.bendalton.mytabs.model.Tab;
	
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class UltimateGuitarService extends EventDispatcher
	{
		
			
		public function UltimateGuitarService()
		{
			super();
			
		}
		
		
		private var passwordMD5:String;
		private var _password:String
		public function set password(value:String):void
		{
			_password = value;
			passwordMD5 = MD5.hash(value);
		}
		
		public function get password():String
		{
			return _password;
		}
		
		public var username:String;
		
		[Bindable]
		public var authenticated:Boolean = false;
		public function login(user:String = null, pass:String = null):void
		{
			if(user) this.username = user;		
			if(pass) this.password = pass;
			if(!password || !passwordMD5 || !username)
				throw new Error('Login information must be set before login()');
				
			var connection:HTTPService = new HTTPService();
			connection.url = "http://ultimate-guitar.com/forum/login.php";
			connection.request = {vb_login_md5password:passwordMD5,
									vb_login_md5passwordUTF:passwordMD5,
									vb_login_username:username,
									'do':'login',
									'forceredirect':1,
									cookieuser:1};
			connection.method = "POST";
			connection.resultFormat = HTTPService.RESULT_FORMAT_TEXT;
			connection.addEventListener(ResultEvent.RESULT, onLoginResult);
			connection.addEventListener(ErrorEvent.ERROR, onLoginError);
			connection.send();
		}
		
		private function onLoginError(event:ErrorEvent):void
		{
			throw new Error('Error accessing Ultimate Guitar for authentication');
		}
		
		private function onLoginResult(event:ResultEvent):void
		{
			if(String(event.result).indexOf('invalid') != -1)
			{
				dispatchEvent(new ErrorEvent('loginFailure',false, false,"Invalid Username or Password"));
			}
			else
			{
				authenticated = true;
				dispatchEvent(new Event('loginSuccess'));
			}
		}
		
		public function logout():void
		{
			//http://ultimate-guitar.com/forum/login.php?do=logout&u=618101
			var connection:HTTPService = new HTTPService();
			connection.url = "http://ultimate-guitar.com/forum/login.php?do=logout";
			connection.addEventListener(Event.COMPLETE,onLogout);
			connection.send();
		}
		
		private function onLogout(event:Event):void
		{
			this.authenticated = false;
			dispatchEvent(new Event('logout'));
		}
		
		public var tabs:ArrayCollection = new ArrayCollection();	
		public function requestTabs():void
		{
			tabs = new ArrayCollection();
			currentPage = 1;
			totalTabs = 0;
			getPageOfTabs(1);
		}
		
		private function getPageOfTabs(page:int):void
		{
			trace("Getting Tabs for Page "+page);
			var url:String = "http://my.ultimate-guitar.com/ajax.favorites.php?type=tab&category=0&npage="+page;
			var service:HTTPService = new HTTPService();
			service.url = url;
			service.resultFormat = HTTPService.RESULT_FORMAT_TEXT;
			service.addEventListener(ResultEvent.RESULT, onTabResult);
			service.send();

		}
		
		private var totalTabs:int;
		private var currentPage:int = 1;
		private function onTabResult(event:ResultEvent):void
		{
			var regex:RegExp = /'/gi; //' odd thing giong on here... 
			var resultString:String = String(event.result).substring(109,String(event.result).length - 24).replace(regex,"\"");
			var result:Object = JSON.decode(resultString);
			for each (var tab:Object in result.favorites)
			{
				tabs.addItem(parseTab(tab));
			}
			var totalTabs:int = int(result.favorites_cnt);
			if(totalTabs > tabs.length)
			{
				trace("Page "+currentPage+":"+tabs.length+"/"+totalTabs);
				currentPage++;
				getPageOfTabs(currentPage);	
			}
			else
			{
				dispatchEvent(new Event('tabs'));
			}
		}
		
		private function parseTab(tab:Object):Tab
		{
			var resultTab:Tab = new Tab();
			for(var key:String in tab)
			{
				resultTab[key] = tab[key];
			}
			return resultTab;
		}
	}
}