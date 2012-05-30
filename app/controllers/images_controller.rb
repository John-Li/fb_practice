class ImagesController < PromotionsController
  def index
    @images = Image.all
    render :json => @images.collect { |p| p.to_jq_upload }.to_json
  end

  def new
    @image = Image.new
    @promotion = Promotion.find_by_id(params[:promotion_id])
  end

  def create
    @image = Image.new(:file_name => params[:image][:file].original_filename,
    :content_type => params[:image][:file].content_type,
    :file_size => params[:image][:file].tempfile.size,
    :promotion_id => params[:image][:promotion_id])
    @image.file = params[:image][:file]
    if @image.save

      respond_to do |format|
        format.html {  
          render :json => [@image.to_jq_upload].to_json, 
          :content_type => 'text/html',
          :layout => false
        }
        format.json {  
          render :json => [@image.to_jq_upload].to_json     
        }
      end
    else 
      render :json => [{:error => "custom_failure"}], :status => 304
    end
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    render :json => true
  end
end