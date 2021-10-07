class ReviewsController < ApplicationController
  def create
    @dog = Dog.find(params[:dog_id])
    @review = Review.new(review_params)
    @review.dog = @dog
    @review.user = current_user
    authorize @review
    respond_to do |format|
      if @review.save
        @pagy, @reviews = pagy(@dog.reviews.order('created_at DESC'), items: 5)

        @review = Review.new
        format.html do
          flash[:notice] = "Review added successfully."
          redirect_to dog_path(@dog, anchor: "review-#{@review.id}")
        end
        format.json {
          render json: { form: render_to_string(partial: "form", formats: [:html]), inserted_item: render_to_string(partial: "dogs/review", formats: [:html]), pagination: view_context.pagy_bootstrap_nav(@pagy) }

        }# Follow the classic Rails flow and look for a create.json view
      else
        format.html do
          @markers = [
                  {
                    lat: @dog.latitude,
                    lng: @dog.longitude,
                    image_url: helpers.asset_url('logo.png')
                  }
                ]
          @renting = Renting.new
          render 'dogs/show'
        end
        format.json {
          render json: { form: render_to_string(partial: "form", formats: [:html]) }
        }# Follow the classic Rails flow and look for a create.json view
      end
    end
    # if @review.save
    #   flash[:notice] = "Review sent."
    #   redirect_to dog_path(@dog, anchor: "review-#{@review.id}")
    # else
    #   @markers = [
    #     {
    #       lat: @dog.latitude,
    #       lng: @dog.longitude,
    #       image_url: helpers.asset_url('logo.png')
    #     }
    #   ]
    #   @renting = Renting.new
    #   render 'dogs/show'
    # end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content)
  end
end
