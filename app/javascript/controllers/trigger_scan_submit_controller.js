import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="trigger-scan-submit"
export default class extends Controller {
  static targets = ["form", "loading"]
  connect() {
    console.log("Hi I am connected");
  }

  triggerButton() {
    console.log(this.formTarget)
    const form = this.formTarget
    this.loadingTarget.classList.remove('d-none')
    form.submit()
  }
}
