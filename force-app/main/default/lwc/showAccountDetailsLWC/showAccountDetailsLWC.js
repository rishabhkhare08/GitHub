import { LightningElement, track } from 'lwc';
import accountRelatedList from '@salesforce/apex/AccountDetailsLWC_Apex.accountRelatedList';
export default class ShowAccountDetailsLWC extends LightningElement {
@track showBox = false;
@track opportunityShowBox = false;
@track accountList=[];
@track contactList=[];
@track opportunityList=[];
connectedCallback(){
    accountRelatedList().then(results =>{   
        this.accountList = results.accountList;
        this.contactList = results.contactList;
        if(this.contactList.length>0){
            this.showBox = true;
        }
        this.opportunityList = results.opportunityList;    
        this.contactList = results.contactList;
        if(this.contactList.length>0){
            this.opportunityShowBox = true;
        } 
    });
}
}