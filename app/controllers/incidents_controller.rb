class IncidentsController < ApplicationController
  before_action :authenticate_login!
  before_action :authenticate_role_user
  before_action :set_incident, only: [:show, :edit, :update, :destroy]


  # GET /incidents
  # GET /incidents.json
  def index
    @incidents = Incident.page(params[:page]).per(5)
    if params[:q].present?
      @incidents = @incidents.joins(:area, userapplication: [{applicationclient: :application}]).where("applications.name like :q or areas.name like :q", q: "%#{params[:q]}%").page params[:page]
      # flash[:success] = "Busqueda correctamente"
     # else
     #   flash[:alert] = "Problemas con la grabación"
    end
  end

  # GET /incidents/1
  # GET /incidents/1.json
  def show
    @incident.picture = params[:file]
  end

  # GET /incidents/new
  def new
    @incident = Incident.new
    @incident.picture = params[:file]
  end

  # GET /incidents/1/edit
  def edit
  end

  # POST /incidents
  # POST /incidents.json
  def create
    @incident = Incident.new(incident_params)
    @user = User.joins(:userareas).where("userareas.area_id = #{@incident.area_id}").sample
    respond_to do |format|
      if @incident.save!
        @incidentmanagement = Incidentmanagement.create(user: @user, incident: @incident)
        format.html { redirect_to incidents_path(@incident), notice: 'Incident was successfully created.' }
        format.json { render :show, status: :created, location: @incident }
      else
        format.html { render :new }
        format.json { render json: @incident.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /incidents/1
  # PATCH/PUT /incidents/1.json
  def update
    @incident.picture.url # => '/url/to/file.png'
    @incident.picture.current_path # => 'path/to/file.png'
    @incident.picture_identifier # => 'file.png'
    respond_to do |format|
      if @incident.update(incident_params)
        format.html { redirect_to incidents_path(@incident), notice: 'Incident was successfully updated.' }
        format.json { render :show, status: :ok, location: @incident }
      else
        format.html { render :edit }
        format.json { render json: @incident.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /incidents/1
  # DELETE /incidents/1.json
  def destroy
    @incident.destroy
    respond_to do |format|
      format.html { redirect_to incidents_url, notice: 'Incident was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_incident
      @incident = Incident.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def incident_params
      params.require(:incident).permit(:user_id, :area_id, :userapplication_id, :criticality_id, :incident_id, :datareport, :description, :state)
    end

    def authenticate_role_user
      unless current_login.user.role_id == 2
        redirect_to root_path
      end
    end
end
