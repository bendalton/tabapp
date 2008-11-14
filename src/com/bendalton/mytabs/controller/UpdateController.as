package com.bendalton.mytabs.controller
{
	import com.everythingflex.air.managers.UpdateManager;
	
	public class UpdateController
	{
		public function UpdateController()
		{
			updateManager.checkForUpdate();
		}
		
		private var updateManager:UpdateManager = new UpdateManager("http://bendalton.com/TabApp/version.xml");
		

	}
}