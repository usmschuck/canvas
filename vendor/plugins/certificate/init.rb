ActionView::Base.send :include, Certificate #Makes the plug avaliable to all ActionViews (.erb files)

#Happens when the plugin is loaded, lists the requirements for the plugin, could also do more...
Rails.configuration.to_prepare do
  require_dependency 'certificate_register.rb' 	#Registers the plug to display it in the list of plugins.
	require_dependency 'certificate.rb'		#The plugin it self.
end
