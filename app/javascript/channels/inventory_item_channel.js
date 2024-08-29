import { Turbo } from "@hotwired/turbo-rails";
import consumer from "./consumer";

// Find the first inventory item element
const inventoryItemElement = document.querySelector(".inventory-item");

if (inventoryItemElement) {
  const inventoryItemId = inventoryItemElement.dataset.id;

  const channel = consumer.subscriptions.create(
    { channel: "InventoryItemChannel", id: inventoryItemId },
    {
      connected() {
        console.log(`Connected to InventoryItemChannel for item: ${inventoryItemId}`);
      },

      disconnected() {
        console.log("Disconnected from InventoryItemChannel");
      },

      received(data) {
        console.log("Received data:", data);
        if (data.type === 'update_quantity') {
          const element = document.getElementById(`quantity_${data.id}`);
          if (element) {
            element.textContent = data.quantity;
          }
        }
      }
    }
  );
}
