module WikiHelper
  def private
    if @wiki.private?
      content_tag :span, 'Private', class: 'badge glyphicon glyphicon-lock'
    else
      content_tag :span, 'Public', class: 'badge glyphicon glyphicon-eye-open'
    end
  end
end
