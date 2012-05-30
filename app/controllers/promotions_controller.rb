class PromotionsController < ApplicationController
  def index
    @promotions = Promotion.all
  end

  def show
    @promotion = Promotion.find_by_id(params[:id])
    return redirect_to promotions_path if @promotion.nil?
  end

  def new
    @promotion = Promotion.new
  end

  def create
    @promotion = Promotion.new(params[:promotion])
    if @promotion.save
      flash[:notice] = 'Successfuly created'
      redirect_to new_promotion_image_path(@promotion)
      return
    else
      #Check fields for valid
      flash[:error] = 'Something go wrong'
      redirect_to promotions_path
      return
    end
  end

  def destroy
    @promotion = Promotion.find(params[:id])
    if @promotion.destroy
      flash[:notice] = 'Successfuly created'
      redirect_to promotions_path
      return
    else
      flash[:error] = 'Something go wrong'
      redirect_to promotions_path
      return
    end
  end
end