import { Controller } from "@hotwired/stimulus"
import { readCookie, setCookie } from "helpers/cookie_helpers"

export default class extends Controller {
  static values = { targetUrl: String }
  static classes = [ "editing" ]

  connect() {
    document.body.classList.toggle(this.editingClass, this.#savedCheckedState)
  }

  change({ target: { checked } }) {
    setCookie("edit_mode", checked)
    Turbo.visit(this.targetUrlValue)
  }

  get #savedCheckedState() {
    return readCookie("edit_mode") === "true"
  }
}
