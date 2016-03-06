class HomeController < ApplicationController
  def index
    @adventures = Collection.all
  end

  def show
    @adventure = Collection.find(params['id'])
  end

  def about
  end
end
