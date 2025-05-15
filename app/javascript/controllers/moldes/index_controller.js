import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="moldes--index"
export default class extends Controller {
  connect() {
    console.log('conectou')
  }

  clearFilters() {
    window.location.href = 'moldes';
  }
}
