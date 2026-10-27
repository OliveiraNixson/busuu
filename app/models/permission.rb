class Permission < Struct.new(:user)
    def allow?(controller, action)
        @current_user.present?
    end
end
