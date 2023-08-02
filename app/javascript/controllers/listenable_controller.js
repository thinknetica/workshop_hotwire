import { Controller } from "@hotwired/stimulus";
import consumer from "channels/consumer"

// Connects to data-controller="listeners"
export default class extends Controller {
    static targets = ["count"];
    static values = { station: Number };
    connect() {
        let countT = this.countTarget

        consumer.subscriptions.create({ channel: "ListenersCountChannel", station: this.stationValue} , {
            received(data) {
                if (countT) {
                    let counter= countT.querySelector('#listeners-count-id')

                    if (counter) {
                        counter.textContent = data.count
                    }
                }
            }
        });
    }
}
