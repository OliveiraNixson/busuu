import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["language", "course"]

  connect() {
    this.filterCourses()
  }

  filterCourses() {
    const languageId = this.languageTarget.value

    Array.from(this.courseTarget.options).forEach((option) => {
      const matchesLanguage = !option.value || option.dataset.languageId === languageId
      option.hidden = !matchesLanguage
    })

    if (this.courseTarget.selectedOptions[0]?.hidden) {
      this.courseTarget.value = ""
    }
  }
}