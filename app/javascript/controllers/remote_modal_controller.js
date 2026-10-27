import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="remote-modal"
export default class extends Controller {
  static targets = ["modal"]

  connect() {
    console.log("Remote modal controller connected")
    
  }

  close() {
    this.modalTarget.classList.toggle("hidden")
  }
}
