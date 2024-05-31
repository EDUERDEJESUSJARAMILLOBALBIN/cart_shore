module ApplicationHelper
  def current_controller_action(controller, action)
    params[:controller] == controller && params[:action] == action
  end
end
