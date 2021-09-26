class DogsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @pagy, @dogs = pagy(Dog.all.order(:palmares), items: 10)
  end

  def show
    @dog = Dog.find(params[:id])
    @renting = Renting.new
  end
end
