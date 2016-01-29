module WikiHelper
  def public_or_private
    if @wiki.public?
      content_tag :span, 'Public', class: 'badge glyphicon glyphicon-eye-open'
    else
      content_tag :span, 'Private', class: 'badge glyphicon glyphicon-lock'
    end
  end
end
