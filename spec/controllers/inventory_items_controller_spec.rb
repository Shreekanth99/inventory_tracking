# spec/controllers/inventory_items_controller_spec.rb

require 'rails_helper'

RSpec.describe InventoryItemsController, type: :controller do
  let(:inventory_item) { create(:inventory_item) }
  let(:valid_attributes) { { quantity: 20 } }
  let(:invalid_attributes) { { quantity: nil } }

  describe 'GET #view' do
    before { get :view, params: { id: inventory_item.id } }

    it 'returns a successful response' do
      expect(response).to have_http_status(:success)
    end

    it 'assigns the requested inventory item to @inventory_item' do
      expect(assigns(:inventory_item)).to eq(inventory_item)
    end

    it 'renders the default HTML view' do
      expect(response).to render_template(:view)
    end

    it 'renders Turbo Stream response when requested' do
      get :view, params: { id: inventory_item.id }, format: :turbo_stream
      expect(response.content_type).to include("text/vnd.turbo-stream.html")
    end
  end

  describe 'PATCH #update' do
    context 'with valid parameters' do
      it 'updates the requested inventory item' do
        patch :update, params: { id: inventory_item.id, inventory_item: valid_attributes }
        inventory_item.reload
        expect(inventory_item.quantity).to eq(20)
      end

      it 'broadcasts the update to InventoryItemChannel' do
        expect {
          patch :update, params: { id: inventory_item.id, inventory_item: valid_attributes }
        }.to have_broadcasted_to("inventory_item_#{inventory_item.id}")
          .with(a_hash_including(type: 'update_quantity', id: inventory_item.id, quantity: 20))
      end

      it 'redirects to the inventory item' do
        patch :update, params: { id: inventory_item.id, inventory_item: valid_attributes }
        expect(response).to redirect_to(inventory_item)
        expect(flash[:notice]).to eq('Inventory item was successfully updated.')
      end
    end

    context 'with invalid parameters' do
      it 'does not update the inventory item' do
        patch :update, params: { id: inventory_item.id, inventory_item: invalid_attributes }
        inventory_item.reload
        expect(inventory_item.quantity).not_to be_nil
      end

      it 're-renders the edit form' do
        patch :update, params: { id: inventory_item.id, inventory_item: invalid_attributes }
        expect(response).to render_template(:edit)
      end

      it 'returns validation errors' do
        patch :update, params: { id: inventory_item.id, inventory_item: invalid_attributes }, format: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("Quantity can't be blank")
      end
    end
  end
end
