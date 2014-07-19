#Registers the plugin, to be displayed in the plugin list.
#First parameter is the name of the plugin's class ColoredDivTag.
#Second parameter is the tag you are giving it, could be anything, seen in the plugins list.
#Third parameter are the attributes you will see in the plugin list.
#The ':settings_partial' has to point to the setting's template (_colored_div_tag_settings.html.erb   becomes just colored_div_tag_settings)
#There's also a validator option (to validate strings given in the settings) which is ':validator', check the 'different ways.txt' under '2nd Way' there will be an 'ExamplePluginValidator'
plugin = Canvas::Plugin.register('certificate', '', {
  :name => lambda{ t :name, "Certificate Creation" },
  :description => lambda{ t :description, "Helps fill out a PDF form to create a generic certification of completion." },
  :website => 'http://USMS.com',
  :author => 'Hovaness Bartamian',
  :author_website => 'http://USMS.com',
  :version => '1.0',
  :settings_partial => 'plugin/certificate_settings',
})
