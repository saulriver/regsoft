class IncidentmanagementsController < ApplicationController
  before_action :authenticate_login!
  before_action :authenticate_role_user
  before_action :set_incidentmanagement, only: [:show, :edit, :update, :destroy]

  # GET /incidentmanagements
  # GET /incidentmanagements.json
  def index
    if params[:search].present?
      @incidentmanagements = Incidentmanagement.where("incident_id LIKE ?", "%#{params[:search]}%").page params[:page]
       else
        @incidents = Incident.joins(:incidentmanagements).where("incidentmanagements.user_id = #{current_login.id}").page(params[:page]).per(5)
            respond_to do |format|#parametro para mostrar en pdf
            format.html
            format.json
            format.pdf {render template: 'layouts/reporte.html.erb',  pdf: 'reporte'}
        end#fin del parametro pdf
    end
  end

  # GET /incidentmanagements/1
  # GET /incidentmanagements/1.json
  def show
  end

  # GET /incidentmanagements/new
  def new
    @incidents = Incident.joins(:incidentmanagements).where("incidentmanagements.user_id = #{current_login.id}").order("incidentmanagements.id DESC")
  end

  # GET /incidentmanagements/1/edit
  def edit
    @incidentmanagement = Incidentmanagement.new
    respond_to do |format|
      if @incidentmanagement.save!
        format.html { redirect_to @incidentmanagement, notice: 'Incidentmanagement was successfully created.' }
        format.json { render :new, status: :created, location: @incidentmanagement }
      else
        format.html { render :new }
        format.json { render json: @incidentmanagement.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /incidentmanagements
  # POST /incidentmanagements.json
  def create
    @incidentmanagement = Incidentmanagement.new(incidentmanagement_params)

    respond_to do |format|
      if @incidentmanagement.save!
        format.html { redirect_to @incidentmanagement, notice: 'Incidentmanagement was successfully created.' }
        format.json { render :show, status: :created, location: @incidentmanagement }
      else
        format.html { render :new }
        format.json { render json: @incidentmanagement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /incidentmanagements/1
  # PATCH/PUT /incidentmanagements/1.json
  def update
    #@incidentmanagement.picture.url # => '/url/to/file.png'
    #@incidentmanagement.picture.current_path # => 'path/to/file.png'
   # @incidentmanagement.picture_identifier # => 'file.png'
    respond_to do |format|
      if @incidentmanagement.update(incidentmanagement_params)
        format.html { redirect_to @incidentmanagement, notice: 'Incidentmanagement was successfully updated.' }
        format.json { render :show, status: :ok, location: @incidentmanagement }
      else
        format.html { render :edit }
        format.json { render json: @incidentmanagement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /incidentmanagements/1
  # DELETE /incidentmanagements/1.json
  def destroy
    @incidentmanagement.destroy
    respond_to do |format|
      format.html { redirect_to incidentmanagements_url, notice: 'Incidentmanagement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_incidentmanagement
      @incidentmanagement = Incidentmanagement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def incidentmanagement_params
      params.require(:incidentmanagement).permit(:user_id, :incident_id, :datereport, :description, :state, :page)
    end

    def authenticate_role_user
      unless current_login.user.role_id == 1
        redirect_to root_path
      end
    end
end
