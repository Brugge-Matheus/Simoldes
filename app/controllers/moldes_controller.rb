class MoldesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_molde, only: %i[ show edit update destroy ]

  # GET /moldes or /moldes.json
  def index
    @moldes = Molde.all
  end

  # GET /moldes/1 or /moldes/1.json
  def show
  end

  # GET /moldes/new
  def new
    @molde = Molde.new
  end

  # GET /moldes/1/edit
  def edit
  end

  # POST /moldes or /moldes.json
  def create
    @molde = Molde.new(molde_params)

    respond_to do |format|
      if @molde.save
        format.html { redirect_to @molde, notice: "Molde was successfully created." }
        format.json { render :show, status: :created, location: @molde }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @molde.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /moldes/1 or /moldes/1.json
  def update
    respond_to do |format|
      if @molde.update(molde_params)
        format.html { redirect_to @molde, notice: "Molde was successfully updated." }
        format.json { render :show, status: :ok, location: @molde }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @molde.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /moldes/1 or /moldes/1.json
  def destroy
    @molde.destroy!

    respond_to do |format|
      format.html { redirect_to moldes_path, status: :see_other, notice: "Molde was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_molde
      @molde = Molde.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def molde_params
      params.require(:molde).permit(:codigo, :descricao, :cliente_id, :tipo, :status, :data_criacao, :data_ultima_modificacao, :responsavel, :observacoes)
    end
end
