class InventoryItemChannel < ApplicationCable::Channel
  def subscribed
    # Stream from a specific channel for a specific inventory item
    stream_for "inventory_item_#{params[:id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
