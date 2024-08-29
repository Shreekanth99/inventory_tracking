class InventoryItem < ApplicationRecord
    validates :quantity, numericality: { greater_than_or_equal_to: 0 }

    after_update_commit do
        Rails.logger.debug "Broadcasting update for InventoryItem #{self.id}"
        broadcast_update_to "inventory_item_channel", target: "inventory_item_#{id}"
    end  
end
  