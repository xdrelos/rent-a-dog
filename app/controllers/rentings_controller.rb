class RentingsController < ApplicationController
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

  private

  def renting_params
    params.require(:renting).permit(:date, :number_of_hours)
  end
end
