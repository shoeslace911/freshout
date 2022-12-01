import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  static targets = ["alert"]
  connect() {
    console.log(this.alertTargets);
    this.alertTargets.forEach((alert) => {
      setInterval(function(){
        alert.style.display = "none";
      }, 3000);
    })
  }
}
