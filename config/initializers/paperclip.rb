module Paperclip
  module Interpolations
    def user_id(attachment, style)
      current_user.id
    end
  end
end
