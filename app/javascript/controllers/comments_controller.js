import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() { }

  toggleForm(event) {
    event.preventDefault();
    event.stopPropagation();

    const formID = event.params["form"]
    const bodyID = event.params["body"]
    const editButtonID = event.params["edit"]

    const formEle = document.getElementById(formID)
    const bodyEle = document.getElementById(bodyID)
    const editButtonEle = document.getElementById(editButtonID)

    formEle.classList.toggle('d-none')
    bodyEle.classList.toggle('d-none')
    this.toggleEditButton(editButtonEle)
  }

  toggleEditButton(editButton) {
    if (editButton.innerText === 'Edit') {
      editButton.innerText = 'Cancel'
      editButton.classList.remove("btn-warning");
      editButton.classList.add("btn-secondary");
    } else {
      editButton.innerText = 'Edit'
      editButton.classList.remove("btn-secondary");
      editButton.classList.add("btn-warning");
    }
  }

  toggleButtonClass() {


  }
}
