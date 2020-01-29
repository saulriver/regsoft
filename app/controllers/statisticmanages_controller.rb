class StatisticmanagesController < ApplicationController
    before_action :authenticate_login!
    before_action :authenticate_role_user
    before_action :set_statisticmanage, only: [:index]

    def index
      @statisticmanages = Statisticmanage.all
    end



  def show
  end


  def new

  end


  def edit
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_statisticmanage
      @statisticmanage = Statisticmanage.all
    end

    def authenticate_role_user
      unless current_login.user.role_id == 1
        redirect_to root_path
      end
    end
end
