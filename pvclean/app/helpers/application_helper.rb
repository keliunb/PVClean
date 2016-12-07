module ApplicationHelper

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def flash_message
    messages = ""
    [:notice, :info, :warning, :error, :success, :danger].each {|type|
      if flash[type]
        messages += "<div class=\" panel-heading alert alert-#{type}\">#{flash[type]} </div>"
        #messages += "<p class=\"#{type}\">#{flash[type]}</p>"
      end
    }

    messages
  end
end
