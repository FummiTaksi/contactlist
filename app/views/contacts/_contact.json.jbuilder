json.extract! contact, :id, :name, :number, :email, :created_at, :updated_at
json.url contact_url(contact, format: :json)