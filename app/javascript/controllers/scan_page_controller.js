import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="scan-page"
// const formData = {
//   amount: '',
//   measurement: '',
//   expiry_data: '',
// }
export default class extends Controller {
  static targets = ["amount", "measurement", "date"]
  connect() {
    console.log('Scan page controller connected.');
  }
  preventReload(event) {
    event.preventDefault();
    console.log(new FormData(event.currentTarget));
    let url = event.currentTarget.action;
    fetch(url, {
      method: 'PUT',
      body: new FormData(event.currentTarget),
      headers: {
        "X-CSRF-Token": this.getMetaValue("csrf-token")
      }
    })
      .then(response => console.log(response))
    // console.log(this.amountTarget);
    // console.log(this.measurementTarget);
    // console.log(this.dateTarget);
    // console.log(event.currentTarget);
  }
  getMetaValue(name) {
    const element = document.head.querySelector(`meta[name="${name}"]`)
    return element.getAttribute("content")
  }
}
