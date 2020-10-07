import { LightningElement, track } from "lwc";
import showContact from "@salesforce/apex/AccountRelatedContact.showContact";
export default class RelatedContactLWC extends LightningElement {
  @track showCard = false;
  @track contactList = [];
  @track contactName = [];
  @track numberOfContact=0;
  getContact() {
   
    showContact().then(results => {
      this.contactList = results;
      this.contactName = results.Name;
    });
     this.numberOfContact = this.contactList.length+1;
    this.showCard = true;
  }
}