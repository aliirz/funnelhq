Paperclip.interpolates :user_id do |attachment, style|
  attachment.instance.current_user.id
end