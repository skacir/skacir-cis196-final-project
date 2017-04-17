json.extract! trip, :id, :user_id, :departure, :start_location, :end_location, :connection?, :transit, :cost, :created_at, :updated_at
json.url trip_url(trip, format: :json)
