class TweetsController < ApplicationController
  def index
    page = (params[:page] || 1).to_i
    per_page = (params[:per_page] || 10).to_i
    
    tweets = Tweet.order(created_at: :desc)
                  .limit(per_page)
                  .offset((page - 1) * per_page)
    total_count = Tweet.count
    
    render json: {
      tweets: tweets,
      pagination: {
        current_page: page,
        total_pages: (total_count.to_f / per_page).ceil,
        total_count: total_count
      }
    }
  end
end
