class DashboardController < ApplicationController
  # Action to display the dashboard with a list of inventory items
    def index 
      @inventory_items = InventoryItem.all
    end
end
