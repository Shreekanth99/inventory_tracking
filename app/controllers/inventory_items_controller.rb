class InventoryItemsController < ApplicationController

    # Action to view a specific inventory item
    def view
        @inventory_item = InventoryItem.find(params[:id])
        respond_to do |format|
            format.html         # Render the default HTML view
            format.turbo_stream # Render Turbo Stream response
        end
    end
  
    # Action to update an inventory item
    def update
        @inventory_item = InventoryItem.find(params[:id])
        Rails.logger.debug "Updating InventoryItem #{@inventory_item.id}"
      
        # Attempt to update the inventory item with the provided parameters
        if @inventory_item.update(inventory_item_params)
            Rails.logger.debug "InventoryItem #{@inventory_item.id} updated successfully"
        
            # Broadcast the update to the InventoryItemChannel
            InventoryItemChannel.broadcast_to(
                "inventory_item_#{@inventory_item.id}",
                {
                    type: 'update_quantity',
                    id: @inventory_item.id,
                    quantity: @inventory_item.quantity
                }
            )
        
        respond_to do |format|
            format.html { redirect_to @inventory_item, notice: 'Inventory item was successfully updated.' }
            format.json { render :show, status: :ok, location: @inventory_item }
        end
        else
            Rails.logger.debug "Failed to update InventoryItem #{@inventory_item.id}"
        
            respond_to do |format|
                format.html { render :edit } # Re-render the edit form with validation errors
                format.json { render json: @inventory_item.errors, status: :unprocessable_entity }
            end
        end
    end
  
    private
  
    # Strong parameters to allow only the quantity to be updated
    def inventory_item_params
        params.require(:inventory_item).permit(:quantity)
    end
end
  