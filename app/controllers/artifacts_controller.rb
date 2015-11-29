class ArtifactsController < ApplicationController
  before_action :set_artifact, only: [:show, :edit, :update, :destroy]
    @@var1 = 5
    @@var2 = 10

  # GET /artifacts
  # GET /artifacts.json
  def index
    @artifacts = Artifact.all
  end

  # GET /artifacts/1
  # GET /artifacts/1.json
  def show
  end

  # GET /artifacts/new
  def new
    @artifact = Artifact.new
  end

  # GET /artifacts/1/edit
  def edit
  end

  # POST /artifacts
  # POST /artifacts.json
  def create
    @artifact = Artifact.new(artifact_params)

    respond_to do |format|
      if @artifact.save
        format.html { redirect_to @artifact, notice: 'Artifact was successfully created.' }
        format.json { render :show, status: :created, location: @artifact }
      else
        format.html { render :new }
        format.json { render json: @artifact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /artifacts/1
  # PATCH/PUT /artifacts/1.json
  def update
    respond_to do |format|
      if @artifact.update(artifact_params)
        format.html { redirect_to @artifact, notice: 'Artifact was successfully updated.' }
        format.json { render :show, status: :ok, location: @artifact }
      else
        format.html { render :edit }
        format.json { render json: @artifact.errors, status: :unprocessable_entity }
      end
    end
  end

  def msg
    stringData = ArtifactAPI.artifact_webservice(params[:data])
    if !stringData.empty?
      json_data = JSON.parse(stringData)
    else
    end

    render json: {
      opcode: json_data['opcode'],
      source: params[:number],
      server_opcode: bal(json_data['opcode'], params[:number], json_data['amount']),
      amount: json_data['amount'],
      balance1: @@var1,
      balance2: @@var2,
      destination: json_data['destination']
    }
  end

  def bal(opcode, phoneNumber, val)
    if opcode == 'transact'
      if phoneNumber == '+919840629721'
        if val <= @@var1
          @@var1 = @@var1 - val
          @@var2 = @@var2 + val
          return "success"
        else
          return "no_balance"
        end
      elsif phoneNumber == '+918411849988'
        if val <= @@var2
          @@var1 = @@var1 + val
          @@var2 = @@var2 - val
          return "success"
        else
          return "no_balance"
        end
      end
      return "not_allowed"
    end
  end

  def msg_post
    stringData = ArtifactAPI.artifact_webservice(params[:data])
    if !stringData.empty?
      json_data = JSON.parse(stringData)
    else
    end

    puts @@var1
    render json: {
      opcode: json_data['opcode'],
      source: params[:number],
      server_opcode: bal(json_data['opcode'], params[:number], json_data['amount']),
      amount: json_data['amount'],
      balance1: @@var1,
      balance2: @@var2,
      destination: json_data['destination']
    }
  end

  # DELETE /artifacts/1
  # DELETE /artifacts/1.json
  # def destroy
  #   @artifact.destroy
  #   respond_to do |format|
  #     format.html { redirect_to artifacts_url, notice: 'Artifact was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_artifact
      @artifact = Artifact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def artifact_params
      params.require(:artifact).permit(:user, :msg)
    end
  end