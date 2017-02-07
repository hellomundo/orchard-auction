module ApplicationHelper
  def icon_link(link, icon_name, remote = false)
    if(remote)
      link_to content_tag(:i, "", :class => "fa fa-#{icon_name}"), link, :remote => true
    else
      link_to content_tag(:i, "", :class => "fa fa-#{icon_name}"), link
    end
  end

  def icon_delete_link(link, message)
    link_to '<i class="fa fa-trash-o"></i>'.html_safe, link, method: :delete, data: { confirm: message }
  end

  def sort_link(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    icon = sort_direction == "asc" ? "fa fa-arrow-down" : "fa fa-arrow-up"
    icon = column == sort_column ? icon : ""
    link_to "#{title} <span class='#{icon}'></span>".html_safe, {column: column, direction: direction}
    #link_to "#{title}".html_safe, {column: column, direction: direction}
  end

end
