class StaticPagesController < ApplicationController
  require 'flickr'
  def home
    set_flickr

    if params[:search].present?
      set_user
      @images = get_photos
    end
    
    rescue Flickr::FailedResponse
    flash.now[:alert] = 'Can not found user id!'
  end

  private
  def set_flickr
    @flickr = Flickr.new(ENV['FLICKR-KEY'], ENV['FLICKR-SECRET'])
  end

  def set_user
    @user_id = search_params[:user_id]
    @page = search_params[:page].present? ? search_params[:page].to_i : 1
    @per_page = search_params[:per_page].present? ? search_params[:per_page].to_i : 10
    @number_photos = @flickr.photos.search(user_id: @user_id).count
    @number_pages = @number_photos / @per_page + 1
  end

  def get_photos
    @flickr.photos.search(user_id: @user_id, page: @page, per_page: @per_page)
  end

  def search_params
    params.require(:search).permit(:user_id, :page, :per_page)
  end
end
