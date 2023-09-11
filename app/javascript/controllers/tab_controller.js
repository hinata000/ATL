import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tab"
export default class extends Controller {
  static targets = ["tab", "content"]

  tabClick(event){
    const tabs = this.tabTargets
    const current = event.currentTarget
    const currentIndex = tabs.indexOf(current)
    const contents = this.contentTargets

    tabs.forEach((tab, index)=>{
      if(current.classList.contains("not-active")){
        tab.classList.remove("is-active")
        tab.classList.add("not-active")
        contents[index].classList.add("hidden")
      }
    })

    if(current.classList.contains("not-active")){
      current.classList.remove("not-active")
      current.classList.add("is-active")
      contents[currentIndex].classList.remove("hidden")
    }
  }
}