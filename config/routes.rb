FirstApp::Application.routes.draw do
  root 	:to	 => "both#wall"
  get 	"add" 	 => "temp#add_link"
  get 	"search" => "both#wall", :format=>false, :defaults=>{:format=>'json'}
  match "index"  => "temp#index"
  get 	"run"	 => "temp#run"
  resources :temp
end
