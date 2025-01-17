import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  greet() {
    navigator.clipboard.writeText(window.location.href);

    this.element.textContent = "Copied!"

    setTimeout(() => {
      this.element.textContent = "Copy URL"
    }, 1000)
  }
}
