# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# db/seeds.rb

# Define a list of inventory items with their attributes
inventory_items = [
  { id: 1, quantity: 10 },
  { id: 2, quantity: 20 },
  { id: 3, quantity: 30 },
  # Add more items as needed
]

# Iterate over each item and create or update the inventory item record
inventory_items.each do |item_data|
  InventoryItem.find_or_initialize_by(id: item_data[:id]).tap do |item|
    item.quantity = item_data[:quantity]
    item.save!
    Rails.logger.debug "Seeded InventoryItem #{item.id} with quantity #{item.quantity}"
  end
end
