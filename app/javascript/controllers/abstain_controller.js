import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  onChange() {
    document.querySelectorAll('input[name="player[score]"]').forEach(input => {
      input.checked = false
    })
  }
}
