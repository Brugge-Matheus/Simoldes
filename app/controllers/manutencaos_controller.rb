class ManutencaosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_manutencao, only: %i[ show edit update destroy ]

  # GET /manutencaos or /manutencaos.json
  def index
    @manutencaos = Manutencao.all
  end

  # GET /manutencaos/1 or /manutencaos/1.json
  def show
  end

  # GET /manutencaos/new
  def new
    @manutencao = Manutencao.new
  end

  # GET /manutencaos/1/edit
  def edit
  end

  # POST /manutencaos or /manutencaos.json
  def create
    @manutencao = Manutencao.new(manutencao_params)

    respond_to do |format|
      if @manutencao.save
        format.html { redirect_to @manutencao, notice: "Manutencao was successfully created." }
        format.json { render :show, status: :created, location: @manutencao }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @manutencao.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /manutencaos/1 or /manutencaos/1.json
  def update
    respond_to do |format|
      if @manutencao.update(manutencao_params)
        format.html { redirect_to @manutencao, notice: "Manutencao was successfully updated." }
        format.json { render :show, status: :ok, location: @manutencao }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @manutencao.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /manutencaos/1 or /manutencaos/1.json
  def destroy
    @manutencao.destroy!

    respond_to do |format|
      format.html { redirect_to manutencaos_path, status: :see_other, notice: "Manutencao was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_manutencao
      @manutencao = Manutencao.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def manutencao_params
      params.require(:manutencao).permit(:molde_id, :tipo_manutencao, :data_manutencao, :descricao, :custo, :responsavel)
    end
end
