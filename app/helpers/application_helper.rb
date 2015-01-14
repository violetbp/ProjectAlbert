module ApplicationHelper
  def parent_layout(layout)
    @_content_for[:layout] = self.output_buffer
    self.output_buffer = render(:file => "layouts/#{layout}")
  end
  
  def bootstrap_class_for flash_type
    case flash_type
        when :notice then "alert-info"
        when :success then "alert-success"
        when :error then "alert-error"
        when :alert then "alert-error"
    end
  end

  def title(page_title)
    content_for :title, page_title.to_s
  end
end