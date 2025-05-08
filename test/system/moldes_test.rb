require "application_system_test_case"

class MoldesTest < ApplicationSystemTestCase
  setup do
    @molde = moldes(:one)
  end

  test "visiting the index" do
    visit moldes_url
    assert_selector "h1", text: "Moldes"
  end

  test "should create molde" do
    visit moldes_url
    click_on "New molde"

    fill_in "Cliente", with: @molde.cliente_id
    fill_in "Codigo", with: @molde.codigo
    fill_in "Data criacao", with: @molde.data_criacao
    fill_in "Data ultima modificacao", with: @molde.data_ultima_modificacao
    fill_in "Descricao", with: @molde.descricao
    fill_in "Observacoes", with: @molde.observacoes
    fill_in "Responsavel", with: @molde.responsavel
    fill_in "Status", with: @molde.status
    fill_in "Tipo", with: @molde.tipo
    click_on "Create Molde"

    assert_text "Molde was successfully created"
    click_on "Back"
  end

  test "should update Molde" do
    visit molde_url(@molde)
    click_on "Edit this molde", match: :first

    fill_in "Cliente", with: @molde.cliente_id
    fill_in "Codigo", with: @molde.codigo
    fill_in "Data criacao", with: @molde.data_criacao
    fill_in "Data ultima modificacao", with: @molde.data_ultima_modificacao
    fill_in "Descricao", with: @molde.descricao
    fill_in "Observacoes", with: @molde.observacoes
    fill_in "Responsavel", with: @molde.responsavel
    fill_in "Status", with: @molde.status
    fill_in "Tipo", with: @molde.tipo
    click_on "Update Molde"

    assert_text "Molde was successfully updated"
    click_on "Back"
  end

  test "should destroy Molde" do
    visit molde_url(@molde)
    click_on "Destroy this molde", match: :first

    assert_text "Molde was successfully destroyed"
  end
end
