require 'yaml/store'
require 'sinatra'


'Hellooo!'
Choices = {
  "N1" => 'Nathan',
  "N2" => 'Nathan',
  "N3" => 'Nathan',
  "N4" => 'Nathan',
  "N5" => 'Nathan',
}
get '/' do
  @title = "Who is my favourite person?"
  erb :index
end


post '/cast' do
  @title ="Thanks for your vote, Bae!"
  @store = YAML::Store.new 'votes.yml'
  params[:votes].each do |vote, value|
    @store.transaction do
      @store['votes'] ||= {}
      @store['votes'][vote] ||=0
      @store['votes'][vote] += 1
    end
  end
  @votes = Choices.select { |vote, value| params[:votes].values.include? vote }
  erb :cast
end

get '/results' do
  @title = "Results:"
  @store = YAML::Store.new 'votes.yml'
  @votes = @store.transaction { @store['votes'] }
  erb :results
end
