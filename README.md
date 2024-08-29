# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby version

- System dependencies

- Configuration

- Database creation

- Database initialization

- How to run the test suite

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions

- ...
  <!-- Real-Time Inventory Tracker -->
- This project is a Basic Real-Time Inventory Tracking System built with Rails 7. The application enables users to monitor inventory updates in real-time using Turbo Streams, Stimulus, and ActionCable.

<!-- Setup Instructions -->

<!-- 1. Clone the Repository -->

- To get started, clone the repository and navigate into the project directory:
  git clone https://github.com/Shreekanth99/inventory_tracking
  cd inventory-tracker

<!-- 2. Install Dependencies -->

Ensure you have Ruby 3.0+ and Rails 7 installed. Then, install the required gems by running:
bundle install

<!-- 3. Set Up the Database -->

Create and migrate the database with the following commands:
rails db:create
rails db:migrate
Optionally, you can seed the database with initial data:
rails db:seed

<!-- 4. Start the Rails Server -->

Launch the Rails server on your local machine:
rails server
Open your browser and navigate to http://localhost:3000 to view the application.

<!-- Real-Time Features -->

The real-time inventory updates are implemented using Turbo Streams and ActionCable, which are part of the Hotwire framework. Here's a brief overview of the implementation:

Turbo Streams: When an inventory item is updated, a Turbo Stream broadcasts the change to all connected clients. This ensures that all users see the updated inventory data without needing to refresh their pages.

Stimulus: Used for managing the interactivity of the inventory update forms and handling user actions like submitting forms or clicking buttons.

ActionCable: Handles WebSocket connections to broadcast real-time updates. When an inventory item’s quantity changes, ActionCable broadcasts the update, which is then captured by Turbo Streams to dynamically update the DOM.

<!-- Assumptions and Design Decisions -->

Data Consistency: It is assumed that inventory updates should be visible to all users in real-time, which is crucial for maintaining accurate and up-to-date inventory records.

User Interface: The layout is designed to be responsive and user-friendly, with real-time updates reflected instantly in the UI. The inventory items are displayed in a card layout within a table-like structure for better readability.

Scalability: The system is designed to handle a moderate load of inventory updates. For high traffic scenarios, further optimizations like background processing and caching might be necessary.
