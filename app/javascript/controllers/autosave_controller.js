import { Controller } from "@hotwired/stimulus"

const AUTOSAVE_INTERVAL = 5000

export default class extends Controller {
  #timer

  submit() {
    this.#resetTimer()
  }

  change() {
    if (!this.#timer) {
      this.#timer = setTimeout(() => this.#save(), AUTOSAVE_INTERVAL)
    }
  }

  #save() {
    this.#resetTimer()
    this.element.requestSubmit()
  }

  #resetTimer() {
    clearTimeout(this.#timer)
    this.#timer = null
  }
}
