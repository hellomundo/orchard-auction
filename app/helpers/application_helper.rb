module ApplicationHelper
  def icon_link(link, icon_name, remote = false)
    link_to content_tag(:i, "", :class => "fa fa-#{icon_name}"), link, remote: remote
  end

  def icon_toggle_link(condition, link, icon_true, icon_false, remote = false)
    icon_name = condition ? icon_true : icon_false
    icon_link(link, icon_name, remote)
  end

  def icon_delete_link(link, message, remote = false)
    link_to '<i class="fa fa-trash-o"></i>'.html_safe, link, method: :delete, data: { confirm: message }, remote: remote
  end

  def sort_link(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    icon = sort_direction == "asc" ? "fa fa-arrow-down" : "fa fa-arrow-up"
    icon = column == sort_column ? icon : ""
    link_to "#{title} <span class='#{icon}'></span>".html_safe, {column: column, direction: direction}
  end

end
