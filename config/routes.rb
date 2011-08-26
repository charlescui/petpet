Petpet::Application.routes.draw do
  #第三方登录omniauth callback地址
  match "/auth/:provider/callback" => "provider#auth"
  match '/auth/failure' => "provider#failure"
  match '/provider/create' => "provider#create"
  match "/provider/delete/:id" => "provider#delete"

  # match ':controller(/:action(/:id(.:format)))'
end
