class DogsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :set_dog, only: [:show, :edit, :update, :destroy]

  def index
    if params[:query] && !params[:query].empty?
      @pagy, @dogs = pagy(policy_scope(Dog).global_search(params[:query]).order(:palmares), items: 10)
    else
      @pagy, @dogs = pagy(policy_scope(Dog).all.order(:palmares), items: 10)
    end
  end

  def show
    @renting = Renting.new
    authorize @dog
  end


  def new
    #dog (@dog=Dog.new) ensuite aller dans view creer la page new
    #enuiste créer formulaire dans partiel _form.html.erb faire un render dans la view new
    # ensuite créer page new
     @dog = Dog.new
     authorize @dog
  end

  def create
    @dog = Dog.new(dog_params)
    authorize @dog
    @dog.user = current_user
    if @dog.save
      flash[:notice] = "Dog created successfully."
      redirect_to dog_path(@dog)
    else
      render "new"
    end
  end

  def edit
    authorize @dog
  end

  def update
    @dog.update(dog_params)
    authorize @dog
    if @dog.save
      flash[:notice] = "Dog edited successfully."
      redirect_to @dog
    else
      render 'edit'
    end
  end

  def destroy
    authorize @dog
    @dog.destroy
    redirect_to dogs_path
  end

  private

  def set_dog
    @dog = Dog.find(params[:id])
  end

  def dog_params
    params.require(:dog).permit(:name, :breed, :description, :city, :age, :palmares, :price_per_hour, :profile_picture, pictures: [])
  end


end
