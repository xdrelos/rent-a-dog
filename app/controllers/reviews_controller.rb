class ReviewsController < ApplicationController
  def create
    @dog = Dog.find(params[:dog_id])
    @review = Review.new(review_params)
    @review.dog = @dog
    @review.user = current_user
    authorize @review
    p @review.valid?
    p @review.errors
    if @review.save
      flash[:notice] = "Review sent."
      redirect_to dog_path(@dog)
    else
      @renting = Renting.new
      render 'dogs/show'
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content)
  end
end
