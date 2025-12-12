import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // todo: explain what is going on here
  static values = { url: String }
  connect() {
    window.location.href = this.urlValue
  }
}
