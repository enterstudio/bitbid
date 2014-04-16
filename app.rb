# my_app.rb
require 'sinatra/base'

class App < Sinatra::Base
  # ... app code here ...

  get "/" do
    "Hello :)"
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
