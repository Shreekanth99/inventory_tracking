
require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  let!(:inventory_items) { create_list(:inventory_item, 5) }

  describe 'GET #index' do
    before { get :index }

    it 'returns a successful response' do
      expect(response).to have_http_status(:success)
    end

    it 'assigns all inventory items to @inventory_items' do
      expect(assigns(:inventory_items)).to match_array(inventory_items)
    end

    it 'renders the index view' do
      expect(response).to render_template(:index)
    end
  end
end
