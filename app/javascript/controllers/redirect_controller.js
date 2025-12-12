import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // This declares a Stimulus "value"
  // The div that connects to this controller also has a data-redirect-url-value attribute
  // whose value is the URL to redirect to.
  // This value is automatically mapped to this.urlValue by Stimulus
  // due to the naming convention: data-[controller]-[value-name]-value.
  static values = { url: String }
  connect() {
    // accesses the `url` field in the controller's `values` object,
    // which contains the URL specified in the data attribute,
    // then immediately redirects the browser to that URL
    window.location.href = this.urlValue
  }
}
