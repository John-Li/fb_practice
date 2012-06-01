class PromotionCardsController < PromotionsController
  def create
    @promotion_card = PromotionCards.new(params[:promotion_card])
    if @promotion_card
      flash[:notice] = 'Successfuly added.'
      render :nothing => true
    else 
      #TO DO handle errors
      flash[:error] = 'Check fields or maybe already added'
      render :json => true
    end
  end
end