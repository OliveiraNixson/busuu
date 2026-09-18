import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="removals"
export default class extends Controller {
  connect() {
    console.log("Aqui")
  }
  remove(){
    this.element.remove()
  }
}
