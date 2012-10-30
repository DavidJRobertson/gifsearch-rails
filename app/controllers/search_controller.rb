class SearchController < ApplicationController
  def search

    page = params[:page]
    page ||= 1

    @search_result = PgSearch.multisearch(params[:query])

    @results = @search_result.page(page).per(5)



  end
end
