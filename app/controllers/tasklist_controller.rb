class TasklistController < ApplicationController
  unloadable

  layout 'redmini'

  def index
  	user =  User.current
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

  def tail
    @issues = Issue
      .where(project_id: params[:id])
      .order('updated_on DESC')
      .all
  end

  def invalid_tasks
    unclosed = Issue
      .where('closed_on is NULL')

    @badly_planned = unclosed
      .where('(due_date is NULL OR estimated_hours is NULL) AND created_on < ?', 1.day.ago)
      .order('updated_on DESC')

    @unassigned = unclosed
      .where('assigned_to_id is NULL AND created_on < ?', 1.day.ago)
      .order('updated_on DESC')

    @stalled = unclosed
      .where('updated_on < ?', 30.day.ago)
      .order('updated_on DESC')
  end

  def cmatrix

  end

  private 

  def group_for_index(issues)
  end

end
