import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="image-select"
export default class extends Controller {
  static targets = [ "file", "image" ]
  connect() {
  }
  fileCheck() {
    this.fileTarget.addEventListener('change', e => {
      const preview = this.imageTarget
      const file = e.target.files[0]
      const reader = new FileReader()

      reader.addEventListener("load", () => {
        preview.src = reader.result
      }, false)
      reader.readAsDataURL(file)
    })
  }
}