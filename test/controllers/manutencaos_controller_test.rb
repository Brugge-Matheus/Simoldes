require "test_helper"

class ManutencaosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @manutencao = manutencaos(:one)
  end

  test "should get index" do
    get manutencaos_url
    assert_response :success
  end

  test "should get new" do
    get new_manutencao_url
    assert_response :success
  end

  test "should create manutencao" do
    assert_difference("Manutencao.count") do
      post manutencaos_url, params: { manutencao: { custo: @manutencao.custo, data_manutencao: @manutencao.data_manutencao, descricao: @manutencao.descricao, molde_id: @manutencao.molde_id, responsavel: @manutencao.responsavel, tipo_manutencao: @manutencao.tipo_manutencao } }
    end

    assert_redirected_to manutencao_url(Manutencao.last)
  end

  test "should show manutencao" do
    get manutencao_url(@manutencao)
    assert_response :success
  end

  test "should get edit" do
    get edit_manutencao_url(@manutencao)
    assert_response :success
  end

  test "should update manutencao" do
    patch manutencao_url(@manutencao), params: { manutencao: { custo: @manutencao.custo, data_manutencao: @manutencao.data_manutencao, descricao: @manutencao.descricao, molde_id: @manutencao.molde_id, responsavel: @manutencao.responsavel, tipo_manutencao: @manutencao.tipo_manutencao } }
    assert_redirected_to manutencao_url(@manutencao)
  end

  test "should destroy manutencao" do
    assert_difference("Manutencao.count", -1) do
      delete manutencao_url(@manutencao)
    end

    assert_redirected_to manutencaos_url
  end
end
