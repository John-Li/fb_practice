class HomeController < ApplicationController
  def index
    @promotion = Promotion.first
    @promotion = Promotion.new unless @promotion
    if @promotion
      respond_to do |format|
        format.html
        format.json do
          images = @promotion.images
          render :json => images.as_json(:only => :file) and return
        end
      end
    end
  end
end
