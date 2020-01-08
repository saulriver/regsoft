class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  # GET /clients
  # GET /clients.json
  def index
    if params[:search].present?
      @clients = Client.where("name LIKE ?", "%#{params[:search]}%").page params[:page]
    else
      @clients = Client.page(params[:page]).per(5)
  end
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
  end

  # GET /clients/new
  def new
    @client = Client.new
  end

  # GET /clients/1/edit
  def edit
  end

  # POST /clients
  # POST /clients.json
  def create
    @client = Client.new(client_params)

    respond_to do |format|
      if @client.save
        format.html { redirect_to clients_path(@client), notice: 'Cliente guardado correctamente.' }
        format.json { render :show, status: :created, location: @client }
      else
        format.html { render :new }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to clients_path(@client), notice: 'Cliente actualizado correctamente.' }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client.destroy
    respond_to do |format|
      format.html { redirect_to clients_url, notice: 'Cliente eliminado correctamente.' }
      format.json { head :no_content }
    end
  end

  def client_application_client_index    
    @client = Client.find(params[:id]) 
    @clientapplicationclients = @client.applicationclients
    @applications = Application.all
    @applicationclient = Applicationclient.new
    render "applicationclients/index"

  end

   def client_application_client_create
    
    @applicationclient = Applicationclient.new(applicationclient_params)


    if @applicationclient.save
      @client = Client.find(params[:id]) 
      @clientapplicationclients = @client.applicationclients
      @applications = Application.all
      @clientapplicationclient = Applicationclient.new
      render "applicationclients/index"
    else
        render json: { error: @clientapplicationclient.errors.full_messages }, status: :bad_request
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params.require(:client).permit(:nit, :name, :reason, :addres, :telephone, :contact, :state, :page, :search)
    end

    def applicationclient_params
      params.require(:applicationclient).permit(:client_id, :state, :servicelevel, :application_id)
  end
end
