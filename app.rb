# in app.rb

require 'sinatra/base'
require './lib/bookmark'

class BookmarkManager < Sinatra::Base
  enable :sessions, :method_override

  get '/' do
    'Hello World'
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :'bookmarks/index'
  end

  delete '/bookmarks/:id' do
    # let's print out the form params
    p params
  end

  get '/bookmarks/new' do
    erb :'bookmarks/new'
  end

  post '/bookmarks/new' do
    url = params['url']
    title = params['title']
    Bookmark.create(url: url, title: title)
    url
  end

  run! if app_file == $0
end
