class DogsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :set_dog, only: [:show, :edit, :update, :destroy]
  skip_after_action :verify_authorized, only: :my_dogs

  def index
    if params[:query] && !params[:query].empty?
      @pagy, @dogs = pagy(policy_scope(Dog).where.not(user: current_user).global_search(params[:query]).order(:palmares), items: 10)
    else
      @pagy, @dogs = pagy(policy_scope(Dog).all.where.not(user: current_user).order(:palmares), items: 10)
    end
    @markers = []
    @dogs.each do |dog|
      if dog.geocoded?
        @markers <<
        {
          lat: dog.latitude,
          lng: dog.longitude,
          image_url: helpers.asset_url('logo.png')
        }
      end
    end
    # doesnt work for all records geocoded bugged?
    # @markers = @dogs.geocoded.map do |dog|
    #   {
    #     lat: dog.latitude,
    #     lng: dog.longitude,
    #     image_url: helpers.asset_url('logo.png')
    #   }
    # end

  end

  def show
    @renting = Renting.new
    # for renting policy create? to work
    @renting.dog = @dog
    @review = Review.new
    # for review policy create? to work
    @review.dog = @dog
    authorize @dog

    @markers = [
      {
        lat: @dog.latitude,
        lng: @dog.longitude,
        image_url: helpers.asset_url('logo.png')
      }
    ]
    @pagy, @reviews = pagy(@dog.reviews.order('created_at DESC'), items: 5)
  end

  def my_dogs
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
    if @dog.rentings.blank?
      @dog.destroy
      redirect_to dogs_path
    else
      flash[:alert] = "You cannot delete this dog, rentings are attached."
      redirect_to @dog
    end
  end

  private

  def set_dog
    @dog = Dog.find(params[:id])
  end

  def dog_params
    params.require(:dog).permit(:name, :breed_id, :description, :city, :age, :palmares, :price_per_hour, :profile_picture, pictures: [])
  end


end
