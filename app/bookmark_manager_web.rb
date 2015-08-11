require 'sinatra/base'
require_relative "../data_mapper_setup"
require_relative "./models/link"

class BookmarkManager < Sinatra::Base
  get '/' do
    'Hello BookmarkManager!'
  end

  get "/links" do
    @links = Link.all
    erb :index
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
