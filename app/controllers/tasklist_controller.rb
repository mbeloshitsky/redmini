class TasklistController < ApplicationController
  unloadable

  layout 'redmini'

  def index
  	user = User.current
  	@taskgroups = Project
  		.includes(:issues)
  		.where(issues: {assigned_to: user, closed_on: nil})
  		.map {|project|
  			unclosed = project.issues
  				.where(assigned_to: user, closed_on: nil)
  				.order('updated_on DESC')
  			project_updated_on = unclosed   \
  				.select {|i| i.updated_on}  \
  				.max
  			closed   = project.issues
  				.where(assigned_to: user)
  				.where.not(closed_on: nil)
  				.order('closed_on DESC')

  			{project: project, updated_on: project_updated_on, closed: closed, unclosed: unclosed}
  		}
  		.sort_by { |p| p[:updated_on] }
  		.reverse
  end

  private 

  def group_for_index(issues)
  end

end
