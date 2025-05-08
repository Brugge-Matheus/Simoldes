require "test_helper"

class MoldesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @molde = moldes(:one)
  end

  test "should get index" do
    get moldes_url
    assert_response :success
  end

  test "should get new" do
    get new_molde_url
    assert_response :success
  end

  test "should create molde" do
    assert_difference("Molde.count") do
      post moldes_url, params: { molde: { cliente_id: @molde.cliente_id, codigo: @molde.codigo, data_criacao: @molde.data_criacao, data_ultima_modificacao: @molde.data_ultima_modificacao, descricao: @molde.descricao, observacoes: @molde.observacoes, responsavel: @molde.responsavel, status: @molde.status, tipo: @molde.tipo } }
    end

    assert_redirected_to molde_url(Molde.last)
  end

  test "should show molde" do
    get molde_url(@molde)
    assert_response :success
  end

  test "should get edit" do
    get edit_molde_url(@molde)
    assert_response :success
  end

  test "should update molde" do
    patch molde_url(@molde), params: { molde: { cliente_id: @molde.cliente_id, codigo: @molde.codigo, data_criacao: @molde.data_criacao, data_ultima_modificacao: @molde.data_ultima_modificacao, descricao: @molde.descricao, observacoes: @molde.observacoes, responsavel: @molde.responsavel, status: @molde.status, tipo: @molde.tipo } }
    assert_redirected_to molde_url(@molde)
  end

  test "should destroy molde" do
    assert_difference("Molde.count", -1) do
      delete molde_url(@molde)
    end

    assert_redirected_to moldes_url
  end
end
