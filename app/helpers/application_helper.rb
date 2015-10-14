module ApplicationHelper
  def icon_link(link, icon_name)
    link_to content_tag(:i, "", :class => "fi-#{icon_name}"), link
  end
  
  def icon_delete_link(link, message)
    link_to '<i class="fi-x"></i>'.html_safe, link, method: :delete, data: { confirm: message }
  end
end
