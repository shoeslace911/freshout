import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toast"
export default class extends Controller {
  static targets = ['form']
  connect() {
    console.log('Controller connected');
    // console.log(this.formTarget.action)
    // console.log(this.formTarget)
  }
  addedToShoppingList(event) {
    event.preventDefault();
    console.log(this.formTarget.action);
    fetch(this.formTarget.action, {
      method: "POST",
      body: new FormData(this.formTarget)
    }).then(response => response)
      .then((data) => {
        Toastify({
          text: "Added to shopping list.",
          duration: 3000,
          destination: "https://github.com/apvarun/toastify-js",
          newWindow: true,
          close: true,
          gravity: "bottom", // `top` or `bottom`
          position: "right", // `left`, `center` or `right`
          stopOnFocus: true, // Prevents dismissing of toast on hover
          style: {
            background: "linear-gradient(to right, #00b09b, #96c93d)",
          },
        }).showToast();
      })
  }
}
