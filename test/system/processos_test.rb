require "application_system_test_case"

class ProcessosTest < ApplicationSystemTestCase
  setup do
    @processo = processos(:one)
  end

  test "visiting the index" do
    visit processos_url
    assert_selector "h1", text: "Processos"
  end

  test "should create processo" do
    visit processos_url
    click_on "New processo"

    fill_in "Data fim", with: @processo.data_fim
    fill_in "Data inicio", with: @processo.data_inicio
    fill_in "Data prevista fim", with: @processo.data_prevista_fim
    fill_in "Molde", with: @processo.molde_id
    fill_in "Nome processo", with: @processo.nome_processo
    fill_in "Observacoes", with: @processo.observacoes
    fill_in "Responsavel", with: @processo.responsavel
    fill_in "Status", with: @processo.status
    click_on "Create Processo"

    assert_text "Processo was successfully created"
    click_on "Back"
  end

  test "should update Processo" do
    visit processo_url(@processo)
    click_on "Edit this processo", match: :first

    fill_in "Data fim", with: @processo.data_fim
    fill_in "Data inicio", with: @processo.data_inicio
    fill_in "Data prevista fim", with: @processo.data_prevista_fim
    fill_in "Molde", with: @processo.molde_id
    fill_in "Nome processo", with: @processo.nome_processo
    fill_in "Observacoes", with: @processo.observacoes
    fill_in "Responsavel", with: @processo.responsavel
    fill_in "Status", with: @processo.status
    click_on "Update Processo"

    assert_text "Processo was successfully updated"
    click_on "Back"
  end

  test "should destroy Processo" do
    visit processo_url(@processo)
    click_on "Destroy this processo", match: :first

    assert_text "Processo was successfully destroyed"
  end
end
