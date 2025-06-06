
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const form = document.querySelector("#player_form");

    async function sendData() {
      // Associate the FormData object with the form element
      const formData = new FormData(form);

      try {
        const response = await fetch(form.action, {
          method: "POST",
          // Set the FormData instance as the request body
          body: formData,
          headers: {
            "Accept": "text/vnd.turbo-stream.html"
          }
        });
      } catch (e) {
        console.error(e);
      }
    }

    form.querySelectorAll('input').forEach( (input) => {
      input.addEventListener('change', (e) => {
        sendData()
      })
    })
  }
}
