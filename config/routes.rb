# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

get 'redmini/tasks', 		to: 'tasklist#index'
get 'redmini/tail/:id', 	to: 'tasklist#tail'
get 'redmini/invalids', 	to: 'tasklist#invalid_tasks'