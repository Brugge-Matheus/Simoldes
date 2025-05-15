class ProcessosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_processo, only: %i[ show edit update destroy ]

  # GET /processos or /processos.json
  def index
    @processos = Processo.all
  end

  # GET /processos/1 or /processos/1.json
  def show
  end

  # GET /processos/new
  def new
    @processo = Processo.new
  end

  # GET /processos/1/edit
  def edit
  end

  # POST /processos or /processos.json
  def create
    @processo = Processo.new(processo_params)

    respond_to do |format|
      if @processo.save
        format.html { redirect_to @processo, notice: "Processo was successfully created." }
        format.json { render :show, status: :created, location: @processo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @processo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /processos/1 or /processos/1.json
  def update
    respond_to do |format|
      if @processo.update(processo_params)
        format.html { redirect_to @processo, notice: "Processo was successfully updated." }
        format.json { render :show, status: :ok, location: @processo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @processo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /processos/1 or /processos/1.json
  def destroy
    @processo.destroy!

    respond_to do |format|
      format.html { redirect_to processos_path, status: :see_other, notice: "Processo was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_processo
      @processo = Processo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def processo_params
      params.require(:processo).permit(:molde_id, :nome_processo, :data_inicio, :data_prevista_fim, :data_fim, :status, :responsavel, :observacoes)
    end
end
