
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["importForm", "fileInput", "fileInfo", "fileName", "fileSize", "fileType", "importButton", "importButtonText"]

  connect() {
  }

  clearFilters() {
    window.location.href = 'moldes';
  }

  handleFileSelect(event) {
    const file = event.target.files[0];

    if (file) {
      // Validar tipo de arquivo
      const allowedTypes = [
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
        'application/vnd.ms-excel'
      ];

      if (!allowedTypes.includes(file.type)) {
        this.showError('Por favor, selecione um arquivo Excel válido (.xlsx ou .xls)');
        this.resetFileInput();
        return;
      }

      const maxSize = 10 * 1024 * 1024;
      if (file.size > maxSize) {
        this.showError('O arquivo deve ter no máximo 10MB');
        this.resetFileInput();
        return;
      }

      this.displayFileInfo(file);
      this.importButtonTarget.disabled = false;
    } else {
      this.hideFileInfo();
      this.importButtonTarget.disabled = true;
    }
  }

  displayFileInfo(file) {
    this.fileNameTarget.textContent = file.name;
    this.fileSizeTarget.textContent = this.formatFileSize(file.size);
    this.fileTypeTarget.textContent = file.type.includes('openxml') ? 'Excel 2007+ (.xlsx)' : 'Excel 97-2003 (.xls)';
    this.fileInfoTarget.style.display = 'block';
  }

  hideFileInfo() {
    this.fileInfoTarget.style.display = 'none';
  }

  formatFileSize(bytes) {
    if (bytes === 0) return '0 Bytes';
    const k = 1024;
    const sizes = ['Bytes', 'KB', 'MB', 'GB'];
    const i = Math.floor(Math.log(bytes) / Math.log(k));
    return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
  }

  processImport() {
    const file = this.fileInputTarget.files[0];

    if (!file) {
      this.showError('Por favor, selecione um arquivo para importar');
      return;
    }

    this.importButtonTarget.disabled = true;
    this.importButtonTextTarget.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i>Processando...';

    setTimeout(() => {
      this.showSuccess('Arquivo processado com sucesso!)');
      this.resetImportModal();
    }, 2000);
  }

  importFile(event) {
    event.preventDefault();
    this.processImport();
  }

  resetFileInput() {
    this.fileInputTarget.value = '';
    this.hideFileInfo();
    this.importButtonTarget.disabled = true;
  }

  resetImportModal() {
    this.resetFileInput();
    this.importButtonTarget.disabled = true;
    this.importButtonTextTarget.innerHTML = '<i class="fas fa-upload me-1"></i>Importar Planilha';

    const modal = bootstrap.Modal.getInstance(document.getElementById('importModal'));
    if (modal) {
      modal.hide();
    }
  }

  showError(message) {
    const alertHtml = `
      <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <i class="fas fa-exclamation-triangle me-2"></i>
        ${message}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      </div>
    `;

    const modalBody = document.querySelector('#importModal .modal-body');
    modalBody.insertAdjacentHTML('afterbegin', alertHtml);

    setTimeout(() => {
      const alert = modalBody.querySelector('.alert-danger');
      if (alert) {
        alert.remove();
      }
    }, 5000);
  }

  showSuccess(message) {
    const alertHtml = `
      <div class="alert alert-success alert-dismissible fade show mb-4" role="alert">
        <i class="fas fa-check-circle me-2"></i>
        ${message}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      </div>
    `;

    // Inserir após o header
    const header = document.querySelector('#header');
    header.insertAdjacentHTML('afterend', alertHtml);

    // Scroll para o topo
    window.scrollTo({ top: 0, behavior: 'smooth' });
  }
}