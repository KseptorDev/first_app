FirstApp::Application.routes.draw do
  root 	:to	 => "both#wall"
  get 	"add" 	 => "temp#add_link"
  get 	"search" => "both#show", :format=>false, :defaults=>{:format=>'json'}
  match "index"  => "temp#index"
  get 	"run"	 => "temp#run"
end
