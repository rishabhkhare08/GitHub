import { LightningElement, track } from "lwc";
import getAccount from "@salesforce/apex/SearchAccountLWC_Apex.getAccount";
import updateRecord from "@salesforce/apex/SearchAccountLWC_Apex.updateRecord";
import deletetRecord from "@salesforce/apex/SearchAccountLWC_Apex.updateRecord";
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class AccountRecordsLWC extends LightningElement {
  @track accountList = [];
  accountRecord;
  indexVal;
  index;
  name;
  id;
  phone;
  website;
  industry;
  rating;
  message;
  connectedCallback() {
    getAccount().then(results => {
      this.accountList = results;
    });
  }
  editrecord(e) {
    this.indexVal = e.target.name;
    console.log(this.accountList[this.indexVal].show);
    this.accountList[this.indexVal].show = true;    ``
  }
  deleteRecordMethod(e){
   let indexvalue = e.target.name;
    let id =this.accountList[indexvalue].accountRecord.Id;
    console.log(id);
    deleteRecord({Id: id}).then(results=>{
    if(results == 'SUCCESS'){
        const evt = new ShowToastEvent({
            title: results,
            message: results,
            variant: 'success',
        });
        this.dispatchEvent(evt);
      }
      else{
        const evt = new ShowToastEvent({
            title: results,
            message: results,
            variant: 'error',
        });
        this.dispatchEvent(evt);
      }
   });
   this.accountList[this.indexVal].show = false;
  }
  saveRecord(e) {
    this.indexVal = e.target.name;
    let name = this.template.querySelector("[data-name= 'Name']").value;
    let phone = this.template.querySelector("[data-phone= 'Phone']").value;
    let rating = this.template.querySelector("[data-r= 'rating']").value;
    let Website = this.template.querySelector("[data-w= 'Website']").value;
    let industry = this.template.querySelector("[data-i= 'Industry']").value;
   
    this.accountList[this.indexVal].accountRecord.Name = name;
    this.accountList[this.indexVal].accountRecord.Phone = phone;
    this.accountList[this.indexVal].accountRecord.Rating = rating;
    this.accountList[this.indexVal].accountRecord.Website = Website;
    this.accountList[this.indexVal].accountRecord.Industry = industry;

    updateRecord({ getAccountRecord: this.accountList[this.indexVal].accountRecord}).then(results => {
      console.log(results);
      if(results == 'SUCCESS'){
        const evt = new ShowToastEvent({
            title: results,
            message: results,
            variant: 'success',
        });
        this.dispatchEvent(evt);
      }
      else{
        const evt = new ShowToastEvent({
            title: results,
            message: results,
            variant: 'error',
        });
        this.dispatchEvent(evt);
      } 
    });
    this.accountList[this.indexVal].show = false;
}
}