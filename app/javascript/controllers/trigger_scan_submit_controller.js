import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="trigger-scan-submit"
export default class extends Controller {
  static targets = ["form"]
  connect() {
    console.log("Hi I am connected");
  }

  triggerButton() {
    console.log(this.formTarget)
    const form = this.formTarget
    form.submit()
  }
}
