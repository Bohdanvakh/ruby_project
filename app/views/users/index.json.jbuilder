json.array!(@users) do |user|
  json.extract! user, :id, :email, :first_name, :last_name
  json.created_at user.created_at.strftime('%Y-%m-%d')
end