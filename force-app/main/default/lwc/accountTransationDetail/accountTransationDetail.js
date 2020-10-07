import { LightningElement, api, track, wire } from "lwc";
import getAccountRecord from "@salesforce/apex/GetAccountLWC.getAccountRecord";
import { registerListener, unregisterAllListeners } from "c/pubsub";
import { CurrentPageReference } from "lightning/navigation";
export default class AccountTransationDetail extends LightningElement {
  @track accountRecord = [];
  @api amount = 0;
  @wire(CurrentPageReference) pageRef;
  connectedCallback() {
    getAccountRecord().then(results => {
      this.accountRecord.push(results);
      console.log(results);
    });
    registerListener("EventAccount", this.addAccount, this);
  }
  disconnectedCallback() {
    unregisterAllListeners(this);
  }
  addAccount(inputValue) {
    this.accountRecord[0].Total_Amount__c += parseInt(inputValue);
  }
}