import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = ["toggleable", "btn"]

  toggle() {
    this.toggleableTarget.classList.toggle("hidden")
    if (this.hasBtnTarget) {
      this.btnTarget.classList.add("hidden")
    }
  }
}
