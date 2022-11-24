import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "input", "cards"]

  connect() {
    console.log(this.formTarget)
    console.log(this.inputTarget)
    console.log(this.cardsTarget)
  }
  update() {
    const url = `${this.formTarget.action}?query=${this.inputTarget.value}`
    fetch(url, {headers: {Accept: "text/plain"}})
    .then(response => response.text())
    .then((data) => {
      this.cardsTarget.innerHTML = data
    })
  }
}
