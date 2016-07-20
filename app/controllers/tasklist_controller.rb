class TasklistController < ApplicationController
  unloadable

  layout 'redmini'

  def index
  	@assigned_tasks = Issue.where(assigned_to: 	User.current)
  	@managed_tasks  = Issue.where(author: 		User.current)
  end

end
