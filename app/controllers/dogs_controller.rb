class DogsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @pagy, @dogs = pagy(Dog.all.order(:palmares), items: 10)
  end

  def show
  end

  def new
    #dog (@dog=Dog.new) ensuite aller dans view creer la page new
    #enuiste créer formulaire dans partiel _form.html.erb faire un render dans la view new
    # ensuite créer page new
     @dog = Dog.new
  end

  def create
    @dog = Dog.new(dog_params)
    @dog.user = current_user
    if @dog.save
      flash[:notice]="dog created succesfully"
      redirect_to dog_path(@dog)
    else
      render "new"
    end
  end

  private
  def dog_params
    params.require(:dog).permit(:name, :breed, :description, :city, :age, :palmares, :price_per_hour, :profile_picture, :pictures)
  end


end
