class RentingsController < ApplicationController
  before_action :set_renting, only: [:edit, :update, :destroy]

  def create
    @dog = Dog.find(params[:dog_id])
    @renting = Renting.new(renting_params)
    @renting.dog = @dog
    @renting.user = current_user
    @renting.status = "Pending"
    if @renting.save
      flash[:notice] = "Renting created successfully."
      redirect_to dog_path(@dog)
    else
      render "dogs/show"
    end
  end

  def my_rentings

  end

  def edit
    @dog = @renting.dog
  end

  def update
    if params[:renting][:status]
      params.require(:renting).permit(:status)
      if params[:renting][:status] == "Accept"
        flash[:notice] = "Renting successfully accepted."
        @renting.status = "Accepted"
        @renting.save
        redirect_to rentings_my_rentings_path
      elsif params[:renting][:status] == "Decline"
        flash[:notice] = "Renting successfully declined."
        @renting.status = "Declined"
        @renting.save
        redirect_to rentings_my_rentings_path
      else
        render :my_rentings
      end

    else

      @renting.update(renting_params)
      @dog = @renting.dog
      if @renting.save
        flash[:notice] = "Renting updated successfully."
        redirect_to rentings_my_rentings_path
      else
        render 'edit'
      end
    end
  end

  def destroy
    @renting.destroy
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
