import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  async connect() {
    this.element.querySelector("mark")?.scrollIntoView({ behavior: "smooth", block: "center" })
  }
}
