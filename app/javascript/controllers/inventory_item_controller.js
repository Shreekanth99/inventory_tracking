import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  resetForm(event) {
    event.target.reset()
  }
}
