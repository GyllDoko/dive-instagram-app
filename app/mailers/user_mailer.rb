class UserMailer < ApplicationMailer
    def user_mailer(user)
        @contact = user
        mail to: "dokogyll@gmail.com", subject: "Email de confirmation"
        end
end
