class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do #home page
    erb :index
  end

  get '/recipes/new' do #create new recipe - get
  	erb :new
  end

  post '/recipes' do #create new recipe - post
  	@recipe = Recipe.create(:name => params[:name], :ingredients => params[:ingredients], :cook_time => params[:cook_time])
  	redirect to "/recipes/#{@recipe.id}"
  end

  get '/recipes/:id' do #show single recipe
    @recipe = Recipe.find(params[:id])
    erb :show
  end

  get '/recipes' do #show all recipes
    @recipes = Recipe.all
  	erb :index
  end

  get '/recipes/:id/edit' do #update a recipe - get
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do #update a recipe - patch
    @recipe = Recipe.find(params[:id])
    @recipe.update(:name => params[:name],:ingredients => params[:ingredients],:cook_time => params[:cook_time])
    redirect to "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id/delete' do
    @recipe = Recipe.find(params[:id])
    @recipe.delete
    redirect to "/recipes"
  end

end
