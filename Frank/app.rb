class Franks < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end
  get '/' do
    erb :index
  end
  
  post '/' do 
    
  end

end
