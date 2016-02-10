require 'sinatra'
require 'data_mapper'

class Photo
  include DataMapper::Resource
  has n,     :comments

  property :id, Serial
  property :url, Text
end

class Comment
  include DataMapper::Resource
  belongs_to :photo

  property :id, Serial
  property :description, Text
end

configure do
  DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/events.db")
  DataMapper.auto_upgrade!
end

get '/photo/:id' do
  @photo = Photo.get(params[:id])
  erb :photo
end


post '/photo/:id/create/comment' do
  photo = Photo.get(params[:id])
  photo.comments.create(:description => params[:description])

  redirect "/photo/#{photo.id}"
end

get '/' do
  p = Photo.get(3)
  p p.comments
end