import { Controller } from "@hotwired/stimulus";
import { csrfToken } from "@rails/ujs";
import { initStarRating } from '../plugins/init_star_rating.js';

export default class extends Controller {
  static targets = ['items', 'form', 'noitems'];

  connect() {
    console.log(this.element);
    console.log(this.itemsTarget);
    console.log(this.formTarget);
    console.log(this.countTarget);
  }
  send(event) {
    event.preventDefault();
    fetch(this.formTarget.action, {
        method: 'POST',
        headers: { 'Accept': "application/json", 'X-CSRF-Token': csrfToken() },
        body: new FormData(this.formTarget)
      })
      .then(response => response.json())
      .then((data) => {
        if (data.inserted_item) {
          this.itemsTarget.insertAdjacentHTML("beforebegin", data.inserted_item);
          if(this.hasNoitemsTarget){
            this.noitemsTarget.remove();
          }
        }
        //this.countTarget.remove();
        this.formTarget.outerHTML = data.form;
        initStarRating();
      });
  }
}
