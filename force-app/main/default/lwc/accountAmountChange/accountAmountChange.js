import { LightningElement, api, track, wire } from "lwc";
import { CurrentPageReference } from "lightning/navigation";
import { fireEvent } from "c/pubsub";
export default class AccountAmountChange extends LightningElement {
  @track inputValue = 0;
  amount = 0;
  @wire(CurrentPageReference) pageRef;

  addAccount(event) {
    if (event.target.name == "add") {
      this.inputValue = parseInt(this.template.querySelector("[data-id='amount']").value);
      fireEvent(this.pageRef, "EventAccount", this.inputValue);
    }
    if (event.target.name == "sub") {
        this.inputValue = parseInt(this.template.querySelector("[data-id='amount']").value)*(-1);
        console.log(this.inputValue);
        fireEvent(this.pageRef, "EventAccount", this.inputValue);
      }
  }
}