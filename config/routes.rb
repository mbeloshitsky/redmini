# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

get 'redmini/tasks', 		to: 'tasklist#index'
get 'redmini/tail/:id', 	to: 'tasklist#tail'