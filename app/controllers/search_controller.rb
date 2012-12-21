class SearchController < ApplicationController
  def logger
    @@logger ||= Logger.new(File.join(Rails.root, "log/search.log"))
  end

  def search
    page = params[:page]
    page ||= 1
     
    logger.info "#{request.rempte_ip}: #{params[:query]} (Page: #{page})"

    @search_result = IndexedGif.search(params[:query])
    @results = @search_result.page(page).per(5)
  end

  def query_redirect
    if params[:query].nil? or params[:query].blank?
      flash[:notice] = "You need to type in what you want to look for!"
      redirect_to root_path
    else
      redirect_to search_path(params[:query])
    end


  end

end
