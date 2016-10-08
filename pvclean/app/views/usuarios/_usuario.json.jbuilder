json.extract! usuario, :id, :nome, :idade, :cargo, :formacao, :created_at, :updated_at
json.url usuario_url(usuario, format: :json)