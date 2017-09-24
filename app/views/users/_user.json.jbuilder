json.extract! user, :id, :tokenid, :username, :password, :email, :phone_no, :created_at, :updated_at
json.url user_url(user, format: :json)
