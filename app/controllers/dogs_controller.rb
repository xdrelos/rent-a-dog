class DogsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    unless params[:query].empty?
      @pagy, @dogs = pagy(Dog.global_search(params[:query]).order(:palmares), items: 10)
    else
      @pagy, @dogs = pagy(Dog.all.order(:palmares), items: 10)
    end
  end

  def show
    @dog = Dog.find(params[:id])
    @renting = Renting.new
  end
end
