module ApplicationHelper
  def parent_layout(layout)
    @_content_for[:layout] = self.output_buffer
    self.output_buffer = render(:file => "layouts/#{layout}")
  end

  def title(page_title)
    content_for :title, page_title.to_s
  end
end