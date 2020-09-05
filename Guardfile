#defines the matching rules for the gaurd

guard :minitest, spring: "bin/rails test", all_on_start: false  do
  # with Minitest::Unit
  watch(%r{^test/(.*)\/?test_(.*)\.rb$})
  watch(%r{^test/test_helper\.rb$})      { 'test' }
  watch('config/routes.rb'){interfac_test}
  watch(%r{app/views/layouts/*}){interfac_test}
  watch(%r{^app/models/(.*?)\.rb$}) do |matches|
    "test/models/#{matches[1]}_test.rb"
  end
  
 watch(%r{^app/controllers/application_controller\.rb$}) do |matches|
   resource_tests(matches[1])
 end 
 
 watch(%r{^app/views/([^/]*?)/.*\.html\.erb$}) do   |matches|
   ["test/controllers/#{matches[1]}_controller_test.rb"] +
   integration_tests(matches[1])
 end 
 
  watch(%r{^app/helpers/(.*?)_helper\.rb$}) do |matches|
    integration_tests(matches[1])
  end
  
  watch('app/views/layouts/application.html.erb') do
    'test/integration/site_layout_test.rb'
  end
 
  watch('app/helpers/sessions_helpers.rb') do
    'integration_tests'<< 'test/helpers/sesssions_helper_test.rb'
  end
  
  watch('app/controllers/sessions_controller.rb') do
    ['test/controllers/session_controller_test.rb',
    'test/integration/users_login_test.rb'
    ]
  end
  
 watch('app/controllers/account_activations_controller.rb') do
    ['test/controllers/session_controller_test.rb',
    'test/integration/users_signupn_test.rb'
    ]
  end
  
  watch(%r{app/views/users/*}) do
    resource_tests('users') +
    ['test/integration/microposts_interface_test.rb']
  end
  
end 


#returns integration test corresponding to the given resource
def intergation_test(resource= :all)
  if resource == :all
    Dir["test/integration/*"]
  else 
    Dir["test/integration/#{resource}_*.rb"]
  end 
end
 
 #returns all test that hit the interface 
def interface_tests
  integration_tests << "test/controllers"
end 

#returns the controller tests corresponding to the given resource.
def controler_test(resource)
  "test/controllers/#{resource}_controller_test.rb"
end 

#Returns all test for the given resource 
def resource_tests(resource)
  intergration_tests << controler_test(resource)
end