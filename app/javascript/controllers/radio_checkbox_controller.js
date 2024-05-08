import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "checkbox" ]

  input({target}) {
    if (target.checked) {
      for (const checkbox of this.checkboxTargets) {
        if (checkbox !== target) {
          checkbox.checked = false
        }
      }
    }
  }
}
