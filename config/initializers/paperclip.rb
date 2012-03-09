module Paperclip
  module Interpolations
    def user_id(attachment, style)
      current_user.id rescue 0
    end
  end
end
