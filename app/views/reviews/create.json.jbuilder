if @review.persisted?
  json.form json.partial!('reviews/form.html.erb', dog: @dog, review: Review.new)
  json.inserted_item json.partial!('dogs/review.html.erb', review: @review)
else
  json.form json.partial!('reviews/form.html.erb', dog: @dog, review: @review)
end
