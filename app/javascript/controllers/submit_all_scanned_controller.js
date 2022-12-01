import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="submit-all-scanned"
export default class extends Controller {
  static targets = ["form"]

  connect() {
    console.log(this.formTargets);
    console.log('hi');
  }

  submitAll() {
    this.formTargets.forEach((form) => {
      let url = form.action;
      fetch(url, {
        method: 'PUT',
        body: new FormData(form),
        headers: {
          "X-CSRF-Token": this.getMetaValue("csrf-token")
        }
      })
        .then(response => console.log(response))
        .then((data) => console.log(data))
      // console.log(form)
    })
    // window.location.href = '/house_foods';
  }
  getMetaValue(name) {
    const element = document.head.querySelector(`meta[name="${name}"]`)
    return element.getAttribute("content")
  }
}
