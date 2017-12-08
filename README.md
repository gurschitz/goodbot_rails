# Goodbot Rails

This is one of the example applications for my bachelor thesis. 

#### Ruby version

The ruby version used is `2.4.1` - make sure that you install it before running this project. 
Check https://www.ruby-lang.org/en/documentation/installation/ for more information.

Please also make sure that bundler gem is installed. 

#### Setup

In order to set everything up on your local machine in development, be sure to do the following first:

  * Follow the app setup Guide at Facebook: https://developers.facebook.com/docs/messenger-platform/getting-started/app-setup
	* Create a file `./config/secrets.yml` from the `./config/secrets.yml.example` file and input all the parameters specific to your facebook application and page. 
	* In the file `./config/environments/development.rb` you should set a host for the default url options using https and that tunnels to the port `3000` on your computer. 
	The url has to be configured like this: `Rails.application.routes.default_url_options[:host] = '<YOUR_PUBLIC_URL>'` - it is already predefined for localhost by default. 
	Check https://ngrok.io for an excellent and free tool for setting up a tunnel to your computer. 
	
#### How to run
To start the Rails server:  
* cd into the cloned path `cd /path/to/goodbot_rails`.
* Run `bundle install`.
* To start Sidekiq, you need run `sidekiq -C config/sidekiq.yml -e development`.
* After that, you can simply type `rails server` to start the server in development mode. 


#### Questions?
If anything is unclear or doesn't work, please feel free to write me an email to `hi@geraldurschitz.com`.