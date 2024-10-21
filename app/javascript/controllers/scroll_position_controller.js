import { Controller } from "@hotwired/stimulus"
import { nextFrame } from "helpers/timing_helpers"

export default class extends Controller {
  connect() {
    this.restoreScrollPosition()
  }

  async restoreScrollPosition() {
    const savedPosition = this.#savedScrollPosition
    if (savedPosition !== null) {
      await nextFrame()
      this.element.scrollTop = savedPosition
    }
  }

  saveScrollPosition() {
    const scrollPosition = this.element.scrollTop
    localStorage.setItem("scroll-position", scrollPosition.toString())
  }

  get #savedScrollPosition() {
    const scrollPosition = localStorage.getItem("scroll-position")
    return scrollPosition ? parseInt(scrollPosition, 10) : null
  }
}
