Rails.application.routes.draw do
  get '/get_list_processors', to: 'build_validator#get_list_processors'
  get '/get_list_motherboards', to: 'build_validator#get_list_motherboards'
  get '/get_list_ram_memories', to: 'build_validator#get_list_ram_memories'
  get '/get_list_graphic_cards', to: 'build_validator#get_list_graphic_cards'
  get '/get_list_valid_machines', to: 'build_validator#get_list_valid_machines'
  post '/validate_build', to: 'build_validator#validate_build'
end
