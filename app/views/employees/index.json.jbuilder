json.array!(@employees) do |employee|
  json.extract! employee, :id, :first_name, :last_name, :email, :is_active
  json.url employee_url(employee, format: :json)
end
