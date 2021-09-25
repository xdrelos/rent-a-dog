class DogsController < ApplicationController
  def index
    @pagy, @dogs = pagy(Dog.all.order(:palmares), items: 10)
  end

  def show
  end
end
