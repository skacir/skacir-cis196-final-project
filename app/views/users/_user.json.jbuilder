json.extract! user, :id, :name, :car, :email, :phone, :trips_id, :created_at, :updated_at
json.url user_url(user, format: :json)
