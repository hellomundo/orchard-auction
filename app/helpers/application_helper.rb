module ApplicationHelper
  def icon_link(link, icon_name, remote = false)
    if(remote)
      link_to content_tag(:i, "", :class => "fi-#{icon_name}"), link, :remote => true
    else
      link_to content_tag(:i, "", :class => "fi-#{icon_name}"), link
    end
  end
  
  def icon_delete_link(link, message)
    link_to '<i class="fi-x"></i>'.html_safe, link, method: :delete, data: { confirm: message }
  end
end
