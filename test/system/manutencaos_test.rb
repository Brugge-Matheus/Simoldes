require "application_system_test_case"

class ManutencaosTest < ApplicationSystemTestCase
  setup do
    @manutencao = manutencaos(:one)
  end

  test "visiting the index" do
    visit manutencaos_url
    assert_selector "h1", text: "Manutencaos"
  end

  test "should create manutencao" do
    visit manutencaos_url
    click_on "New manutencao"

    fill_in "Custo", with: @manutencao.custo
    fill_in "Data manutencao", with: @manutencao.data_manutencao
    fill_in "Descricao", with: @manutencao.descricao
    fill_in "Molde", with: @manutencao.molde_id
    fill_in "Responsavel", with: @manutencao.responsavel
    fill_in "Tipo manutencao", with: @manutencao.tipo_manutencao
    click_on "Create Manutencao"

    assert_text "Manutencao was successfully created"
    click_on "Back"
  end

  test "should update Manutencao" do
    visit manutencao_url(@manutencao)
    click_on "Edit this manutencao", match: :first

    fill_in "Custo", with: @manutencao.custo
    fill_in "Data manutencao", with: @manutencao.data_manutencao
    fill_in "Descricao", with: @manutencao.descricao
    fill_in "Molde", with: @manutencao.molde_id
    fill_in "Responsavel", with: @manutencao.responsavel
    fill_in "Tipo manutencao", with: @manutencao.tipo_manutencao
    click_on "Update Manutencao"

    assert_text "Manutencao was successfully updated"
    click_on "Back"
  end

  test "should destroy Manutencao" do
    visit manutencao_url(@manutencao)
    click_on "Destroy this manutencao", match: :first

    assert_text "Manutencao was successfully destroyed"
  end
end
