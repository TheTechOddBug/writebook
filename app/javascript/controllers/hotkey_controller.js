import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  click() {
    if (this.#isClickable) {
      this.element.click()
    }
  }

  get #isClickable() {
    return getComputedStyle(this.element).pointerEvents !== "none"
  }
}
