class RentingsController < ApplicationController
  before_action :set_renting, only: [:edit, :update, :validate, :destroy]
  skip_after_action :verify_authorized, only: [:my_rentings]

  def create
    @dog = Dog.find(params[:dog_id])
    @renting = Renting.new(renting_params)
    @renting.dog = @dog
    @renting.user = current_user
    @renting.status = "Pending"
    if @renting.number_of_hours
     @renting.total_price = @dog.price_per_hour * @renting.number_of_hours
    end
    authorize @renting
    if @renting.save
      flash[:notice] = "Renting created successfully."
      redirect_to rentings_my_rentings_path
    else
      @review = Review.new
      @review.dog = @dog
      @pagy, @reviews = pagy(@dog.reviews.order('created_at DESC'), items: 5)
      render "dogs/show"
    end
  end

  def my_rentings
  end

  def edit
    @dog = @renting.dog
    authorize @renting
  end

  def update
    @renting.update(renting_params)
    authorize @renting
    @renting.total_price = @renting.dog.price_per_hour * @renting.number_of_hours
    @dog = @renting.dog
    if @renting.save
      flash[:notice] = "Renting updated successfully."
      redirect_to rentings_my_rentings_path
    else
      render 'edit'
    end
  end

  def validate
    params.require(:renting).permit(:status)
    authorize @renting
    if params[:renting][:status] == "Accept"
      @renting.status = "Accepted"
      if @renting.save
        flash[:notice] = "Renting successfully accepted."
        redirect_to rentings_my_rentings_path
      else
        flash[:alert] = "Couldn't validate the renting."
        render :my_rentings
      end
    elsif params[:renting][:status] == "Decline"
      @renting.status = "Declined"
      if @renting.save
        flash[:notice] = "Renting successfully declined."
        redirect_to rentings_my_rentings_path
      else
        flash[:alert] = "Couldn't validate the renting."
        render :my_rentings
      end
    else
      flash[:alert] = "Couldn't validate the renting."
      render :my_rentings
    end
  end

  def destroy
    @renting.destroy
    authorize @renting
    flash[:notice] = "Renting successfully cancelled."
    redirect_to rentings_my_rentings_path
  end

  private

  def set_renting
    @renting = Renting.find(params[:id])
  end

  def renting_params
    params.require(:renting).permit(:date, :number_of_hours)
  end
end
