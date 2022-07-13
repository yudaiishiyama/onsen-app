module NoticesHelper
  def unchecked_notices
    @notices=current_user.passive_notices.where(checked: false)
  end

  def notice_form(notice)
    @comment=nil
    visiter=link_to notice.visiter.name, notice.visiter, style:"font-weight: bold;"
    your_post=link_to 'あなたの投稿', notice.micropost, style:"font-weight: bold;", remote: true
    case notice.action
      when "like" then
        "#{visiter}が#{your_post}にいいね！しました"
      when "comment" then
        @comment=Comment.find_by(id:notice.comment_id)&.content
        "#{visiter}が#{your_post}にコメントしました"
    end
  end
end
