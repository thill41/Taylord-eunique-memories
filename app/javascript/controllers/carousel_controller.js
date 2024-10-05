import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="carousel"
export default class extends Controller {
  static targets = ["slide", "description"]

  connect() {
    this.currentIndex = 0
    this.showCurrentSlide()
  }

  next() {
    this.currentIndex = (this.currentIndex + 1) % this.slideTargets.length
    this.showCurrentSlide()
  }

  previous() {
    this.currentIndex = (this.currentIndex - 1 + this.slideTargets.length) % this.slideTargets.length
    this.showCurrentSlide()
  }

  showCurrentSlide() {
    this.slideTargets.forEach((slide, index) => {
      if (index === this.currentIndex) {
        slide.style.display = ''
      } else {
        slide.style.display = 'none'
      }
    })
  }

  toggleContent(event) {
    const button = event.currentTarget
    const card = button.closest('.card')
    const cardBodyBottom = card.querySelector('.card-body-bottom')
    const description = card.querySelector('.package-description')

    cardBodyBottom.classList.toggle('hidden')
    description.classList.toggle('hidden')

    button.textContent = cardBodyBottom.classList.contains('hidden') ? 'Show More' : 'Show Less'
  }
}
