
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const form = document.querySelector("#player_form");

    async function autoSubmit() {
      const formData = new FormData(form);

      try {
        const response = await fetch(form.action, {
          method: "POST",
          body: formData,
          headers: {
            "Accept": "text/vnd.turbo-stream.html" // Expecting a Turbo Stream response
          }
        });
      } catch (e) {
        console.error(e);
      }
    }

    // add to change event listener to all inputs except player_name text field
    form.querySelectorAll('input:not(#player_name)').forEach( (input) => {
      input.addEventListener('change', (e) => {
        autoSubmit() // todo: handle the async submission
      })
    })
  }
}
