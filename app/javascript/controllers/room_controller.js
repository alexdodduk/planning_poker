
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // todo: is this still needed?
    const roomIsRevealed = document.querySelector('[data-controller="room"]').classList.contains('revealed')

    if (!roomIsRevealed) {
      document.querySelectorAll('input[name="player[score]"]').forEach(input => {
        input.checked = false
      })
    }
  }
}
