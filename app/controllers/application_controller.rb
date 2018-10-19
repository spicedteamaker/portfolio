class ApplicationController < ActionController::Base
  helper_method :hero_image, :check_privlege, :user_operator?, :user_admin?, :user_operator_or_admin?

  def hero_image
    backgroundImg = HeaderImage.last
    if backgroundImg.nil?
      return nil
    else
      return backgroundImg.picture
    end
  end

  def check_privilege
    if !current_user.nil?
      if !user_operator_or_admin?
        flash[:error] = "You do not have permission to access that page."
        redirect_to root_path
      end
    else
      flash[:error] = "You must log in to access that page."
      redirect_to new_user_session_path
    end
  end

  def user_operator?
    if user_signed_in?
      current_user.operator?
    else
      false
    end
  end

  def user_admin?
    if user_signed_in?
      current_user.admin?
    else
      false
    end
  end

  def user_operator_or_admin?
    if user_signed_in?
      user_operator? || user_admin?
    else
      false
    end
  end
end
