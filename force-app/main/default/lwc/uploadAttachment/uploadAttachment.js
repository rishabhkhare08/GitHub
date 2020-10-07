import { LightningElement,track,api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import upload from '@salesforce/apex/UploadAttachment.upload';
import uploadNow from '@salesforce/apex/UploadAttachment.uploadNow';
import deleteRecord from '@salesforce/apex/UploadAttachment.deleteRecord';
export default class UploadAttachment extends LightningElement {
      @api recordId;
      @track pick;
      @track showTable=false; 
      @track tableList =[];
      listId = [];
      index;
      checkListId = [];
      call(e){
       this.pick = e.target.value;
      }
      connectedCallback(){
        console.log(JSON.stringify(this.recordId));
        uploadNow().then(result => {  
          console.log(JSON.stringify(result)); 
          this.tableList = result;
          if(this.tableList){
            this.showTable = true;
          }          
        });
      }
      makeTrue(){
        if(this.template.querySelector('[data-id="checkbox"]').checked == true){
          this.template.querySelector('[data-id="checkbox"]').checked=false;
          for(var i=0;i<this.tableList.length;i++){
                   this.tableList[i].check=false;
                   this.checkListId = [];
          }
        }else{
          this.template.querySelector('[data-id="checkbox"]').checked=true;
          this.checkListId = [];
          for(var i=0;i<this.tableList.length;i++){
                   this.tableList[i].check=true;
                   this.checkListId[i]=this.tableList[i];
          }
          console.log("<<<<<"+JSON.stringify(this.checkListId));
        }
      }
      deleteRecords(){
        deleteRecord({records:this.tableList}).then(result =>{
          this.tableList = [];
          this.showTable = false;
          const evt = new ShowToastEvent({
            title: "Documents",
            message: "Delete All Records",
            variant: "success",
        });
        this.dispatchEvent(evt);
      });
    }
      selectedDeleteRecords(){
        if(this.checkListId){
          console.log(this.checkListId.length+" "+this.tableList.length);
        deleteRecord({records:this.checkListId}).then(result =>{
          const evt = new ShowToastEvent({
            title: "Documents",
            message: "Delete All Records",
            variant: "success",
        });
        if(this.checkListId.length == this.tableList.length){
          this.tableList = [];
          this.checkListId = [];
          this.showTable = false;
        }
        else{
          this.tableList.splice(this.index,1);
          this.checkListId = [];

        }
        this.dispatchEvent(evt);
        });
        connectedCallback();
      }
      }
      makeTrueRecord(e){
        this.index = e.target.dataset.check;
       this.checkListId[index]=this.tableList[index];
       console.log("<<<<<<<<<<<<>>>>>>>>>>"+this.checkListId.length);
      }
      openDocument(e){
        console.log(JSON.stringify(e.currentTarget.id));
        let value = e.currentTarget.id;
        let ind = value.split('-');
        let aa = ind[0];
        console.log(JSON.stringify(this.tableList[aa].Id));
        
        window.open("https://rishabh-cloudanalogy-dev-ed.lightning.force.com/"+this.tableList[aa].Id);
      }
      get acceptedFormats() {
          return ['.pdf', '.png'];
      }
      handleUploadFinished(event) {
          // Get the list of uploaded files
          this.tableList = [];
          const uploadedFiles = event.detail.files;
          for(var i=0;i<uploadedFiles.length;i++){
            this.listId.push(uploadedFiles[i].documentId);
          }
          console.log(JSON.stringify(this.listId));
          if(uploadedFiles.length>0){
            upload({documentId:this.listId,recordid:this.recordId}).then(result => {
                     console.log(JSON.stringify(result));
                     this.tableList = result;
                     this.showTable = true;                     
          });
    }
      }
}