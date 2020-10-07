import { LightningElement, track } from "lwc";
import getAccountField from "@salesforce/apex/SchemaAccount.getAccountField";
import getAccount from "@salesforce/apex/SchemaAccount.getAccount";
import saveContactRecord from "@salesforce/apex/SchemaAccount.saveContactRecord";
export default class AccountFields extends LightningElement {
  @track wrapperList = [];
  @track searchSo;
  @track api =[];
  @track contvalue =[];
  @track saveData = new Map();
  @track multiPickValue = [];
  @track selected = [];
  @track showBox = false;
  @track accountName;
  @track multiPciklist = [];
  @track accountList = [];

  searchSobject(event) {
    if (event.target.name == "search") {
      this.searchSo = this.template.querySelector("[data-id='sobject']").value;
      console.log(this.searchSo);
      getAccountField({ sobjectName: this.searchSo }).then(results => {
        this.wrapperList = results;
        console.log(JSON.stringify(this.wrapperList));

        for (var i = 0; i < this.wrapperList.length; i++) {
          if (this.wrapperList[i].multiPicklistValue != null) {
            for (
              var j = 0;
              j < this.wrapperList[i].multiPicklistValue.length;
              j++
            ) {
              this.multiPciklist.push({
                label: this.wrapperList[i].multiPicklistValue[j],
                value: this.wrapperList[i].multiPicklistValue[j]
              });
            }
          }
        }
      });
    }
  }
  setAccountName(e) {
    this.accountName = e.target.dataset.id;
    var index = e.target.dataset.index;
    var Id = e.target.dataset.name;
    var api = this.wrapperList[index].fieldApi;
    this.saveData.set(api, Id);
    console.log(this.saveData);
    this.showBox = false;
  }
  handleChange(e) {
    this.selected = e.detail.value;
    var label = e.target.name;
    var ceck = "";
    ceck = ceck+" "+e.detail.value;
    this.saveData.set(label, ceck);
    console.log(ceck);
  }
  inputValue(e) {
    var index = e.target.name;
    var label = this.wrapperList[index].fieldApi;
    var value = e.target.value;
    if (label == "Same Country as User & Company") {
      value = true;
    }
   
    this.saveData.set(label, value);
    console.log(this.saveData);
  }
  getData(e) {
    var index = e.target.name;
    var label = this.wrapperList[index].fieldApi;
    var value = e.target.value;
    this.saveData.set(label, value);
    console.log(this.saveData);
  }
  showAcc(e) {
    var accName = e.target.value;
    if (accName.length > 0) {
      getAccount({ accountName: accName }).then(result => {
        this.accountList = result;
        this.showBox = true;
        console.log(this.showBox);
      });
    } else {
      this.showBox = false;
    }
  }
  saveContact() {
    console.table(this.saveData);
    var object ={};
    for(var key of this.saveData.keys()){
      object[key] = this.saveData.get(key);
    }
    console.log(object);
    saveContactRecord({sobjectName: this.searchSo, saveRecord: object }).then(results => {
      console.log(JSON.stringify(results));
     });
   }
  get pickvalue() {
    return this.multiPciklist;
  }
}