class StatisticreportsController < ApplicationController
    before_action :authenticate_login!
    before_action :authenticate_role_user
    before_action :set_statisticreport, only: [:index]

    def index
      @users = User.all
      @incidents_count = Incident.group(:user_id).count
      @incidents_date = Incident.group(:created_at).count
    end



  def show
  end


  def new

  end


  def edit
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_statisticreport
      @statisticreport = Statisticreport.all
    end

    def authenticate_role_user
      unless current_login.user.role_id == 2
        redirect_to root_path
      end
    end
end
