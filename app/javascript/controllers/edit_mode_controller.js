import { Controller } from "@hotwired/stimulus"
import { readCookie, setCookie } from "helpers/cookie_helpers"

export default class extends Controller {
  static values = { editUrl: String, readUrl: String }
  static targets = [ "switch" ]

  connect() {
    this.switchTarget.checked = this.#savedCheckedState
  }

  change({ target: { checked } }) {
    setCookie("edit_mode", checked)

    if (checked && this.editUrlValue) {
      Turbo.visit(this.editUrlValue)
    }
    if (!checked && this.readUrlValue) {
      Turbo.visit(this.readUrlValue)
    }
  }

  get #savedCheckedState() {
    return readCookie("edit_mode") === "true"
  }
}
