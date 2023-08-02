import { Controller } from "@hotwired/stimulus";
import consumer from "../channels/consumer"
export default class extends Controller {
    static outlets = ["player"];

    connect() {
        this.subscription = consumer.subscriptions.create({ channel: "ListenerChannel", id: this.playerOutlet.stationValue }, { id: this.playerOutlet.stationValue })
    }

    disconnect() {
        if (this.subscription) {
            this.subscription.unsubscribe();
        }
    }

}
