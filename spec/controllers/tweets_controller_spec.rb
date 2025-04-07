require 'rails_helper'

RSpec.describe TweetsController do
  describe 'GET #index' do
    it 'returns a list of tweets' do
      get :index

      expect(response).to be_successful
      expect(response.body).to include('[]')
    end

    it 'returns a list of tweets by username' do
      user = create(:user, username: 'test_user')
      create(:tweet, user: user)
      get :index, params: { username: 'test_user' }

      expect(response).to be_successful
      expect(response.body).to include(user.id.to_s)
      expect(response.body).to include(user.tweets.first.id.to_s)
      expect(response.body).to include(user.tweets.first.body)
    end

    it 'and not return tweets for a non-existent username' do
      get :index, params: { username: 'non_existent_user' }

      expect(response).to be_successful
      expect(response.body).to include('[]')
    end

    it 'and not return tweets for a other user' do
      user = create(:user, username: 'test_user')
      create(:tweet, user: user)
      user2 = create(:user, username: 'other_user')
      create(:tweet, user: user2)
      get :index, params: { username: 'test_user' }

      expect(response).to be_successful
      expect(response.body).to include(user.id.to_s)
      expect(response.body).to include(user.tweets.first.body)
      expect(response.body).not_to include(user2.tweets.first.body)
    end
  end
end
