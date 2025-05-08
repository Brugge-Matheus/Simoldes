require "test_helper"

class ProcessosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @processo = processos(:one)
  end

  test "should get index" do
    get processos_url
    assert_response :success
  end

  test "should get new" do
    get new_processo_url
    assert_response :success
  end

  test "should create processo" do
    assert_difference("Processo.count") do
      post processos_url, params: { processo: { data_fim: @processo.data_fim, data_inicio: @processo.data_inicio, data_prevista_fim: @processo.data_prevista_fim, molde_id: @processo.molde_id, nome_processo: @processo.nome_processo, observacoes: @processo.observacoes, responsavel: @processo.responsavel, status: @processo.status } }
    end

    assert_redirected_to processo_url(Processo.last)
  end

  test "should show processo" do
    get processo_url(@processo)
    assert_response :success
  end

  test "should get edit" do
    get edit_processo_url(@processo)
    assert_response :success
  end

  test "should update processo" do
    patch processo_url(@processo), params: { processo: { data_fim: @processo.data_fim, data_inicio: @processo.data_inicio, data_prevista_fim: @processo.data_prevista_fim, molde_id: @processo.molde_id, nome_processo: @processo.nome_processo, observacoes: @processo.observacoes, responsavel: @processo.responsavel, status: @processo.status } }
    assert_redirected_to processo_url(@processo)
  end

  test "should destroy processo" do
    assert_difference("Processo.count", -1) do
      delete processo_url(@processo)
    end

    assert_redirected_to processos_url
  end
end
