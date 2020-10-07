import { LightningElement, track, wire, api } from "lwc";
import getSobjectsRecord from "@salesforce/apex/sObjectsCount_Apex.getSobjectsRecord";
import getSObjectSchema from "@salesforce/apex/sObjectsCount_Apex.getSObjectSchema";
import getPicklistValue from "@salesforce/apex/sObjectsCount_Apex.getPicklistValue";
import getGroupByCode from "@salesforce/apex/sObjectsCount_Apex.getGroupByCode";
import updateObjectTable from "@salesforce/apex/sObjectsCount_Apex.updateObjectTable";
export default class GetObjectCount extends LightningElement {
  @track sObjects = [];
  @track objectField = [];
  @track sobjectWrapper = [];
  @track sObjectList = [];
  @track groupList = [];
  @track sobjectWrapList = [];
  @track checkSubsidiaryRadio=0;
   label;
   oprator;
   value;
   objectname;
  @track trueField = "";
  @track callGroupApexMethod = false;
  @track showGroupTable = false;
  @track radioContactTrue = false;
  @track radioUserTrue = false;
  @track showTable = false;
  @track openPanel = false;
  @track showPanelBodyHead = false;
  @track date = false;
  @track input = false;
  @track pick = false;
  @track showSaveButton = false;
  fieldType;
  @track fieldLabel;
  @track headObjectName;
  @track picklist = [];
  @track selectedPicklist;
  @track fields = [];
  @track sObjectFieldsList = [];
  @track sObjectFields = [];
  @track indexValue;
  @track filterList = [];
  @track
  listOptions = [
    { value: "User", label: "User" },
    { value: "Account", label: "Account" },
    { value: "Contact", label: "Contact" }
  ];

  totalCount() {
    this.sobjectWrapList = [];
    var lastIndexOf = this.sObjectList.length - 1;
    this.sObjects = this.sObjectList[lastIndexOf];
    if (this.sObjects.length > 0) {
      getSobjectsRecord({ sObjectsList: this.sObjects }).then(results => {
        this.sobjectWrapper = results;
        for(var i=0;i<this.sobjectWrapper.length;i++){
          this.sobjectWrapList.push({count:this.sobjectWrapper[i].totalCount,name:this.sobjectWrapper[i].sobjectName});
        }
        this.showTable = true;
      });
    
    } else {
      alert("no SObject is selected.");
    }
  }
  newPanel() {
    if (this.openPanel == true) {
      this.openPanel = false;
      this.template.querySelector('[data-id="popover"]').style.display = "none";
      this.showPanelBodyHead = false;
      this.showSaveButton = false;
      this.filterList = [];
    } else {
      this.openPanel = true;
    }
  }
  closePanel() {
    this.filterList = [];
    this.openPanel = false;
    this.template.querySelector('[data-id="popover"]').style.display = "none";
  }
  handleChange(e) {
    const selectedSObjectsList = e.detail.value;
    this.sObjectList.push(selectedSObjectsList);
  }
  getValue(e) {
    operatorValue = e.target.value;
  }
  addFilterDiv(e) {
    this.indexValue = this.filterList.length;
    this.filterList.push({showdiv: false,list:[]});
    this.showPanelBodyHead = true;
    this.showSaveButton = false;
    this.callGroupApexMethod = false;
    if(this.objectname == 'Contact' || this.objectname =='User'){
      this.template.querySelector('[data-radio="radio"]').checked = false;
    }
    this.radioContactTrue = false;
    this.radioUserTrue = false;
    this.groupList=[];
    this.fields = [];
    this.showGroupTable = false;
     if (e.target.offsetTop) {
      this.template.querySelector('[data-id="popover"]').style.display = "block";
      this.template.querySelector('[data-id="popover"]').style.top =(e.target.offsetTop) + "px";
      this.template.querySelector('[data-id="popover"]').style.right = this.template.querySelector('[data-div="filterdiv"]').offsetWidth - 45 +"px";     
    }
    setTimeout(()=>{
      this.template.querySelector('[data-ob="object"]').value="";
      this.template.querySelector('[ data-fi="field"]').value="";
      this.template.querySelector('[data-operator="operator"]').value="";  
      if (this.input == false) {
        this.template.querySelector('[data-input="input"]').value="";
      } else if (this.date == true) {
        this.template.querySelector('[data-date="date"]').value="";
      } else if (this.pick == true) {
        this.template.querySelector('[data-pickvalue="picklist"]').value="";
      }
    },5);
  }
  newFilterOnClick(e){
    let value = e.currentTarget.id;
    let value1= value.split('-');
    let index = value1[0];
    this.indexValue = index;
    this.fields = [];
    this.radioContactTrue = false;
     this.radioUserTrue = false;
    if (e.target.offsetTop) {
        this.template.querySelector('[data-id="popover"]').style.display = "block";
        this.template.querySelector('[data-id="popover"]').style.top = (e.target.offsetTop-20) + "px";
        this.template.querySelector('[data-id="popover"]').style.right = this.template.querySelector('[data-div="filterdiv"]').offsetWidth - 45 +"px";
        this.template.querySelector('[data-ob="object"]').value="";
        this.template.querySelector('[ data-fi="field"]').value="";
        this.template.querySelector('[data-operator="operator"]').value="";  
        if (this.input == false) {
          this.template.querySelector('[data-input="input"]').value="";
        } else if (this.date == true) {
          this.template.querySelector('[data-date="date"]').value="";
        } else if (this.pick == true) {
          this.template.querySelector('[data-pickvalue="picklist"]').value="";
        }
      }
  }
  revomeFilter(e) {
    let index = e.target.dataset.in;
    console.log(index);
    if(index==0){
      if (e.target.offsetTop) {
        this.template.querySelector('[data-id="popover"]').style.display = "block";
        this.template.querySelector('[data-id="popover"]').style.top = (e.target.offsetTop-22) + "px";
        this.template.querySelector('[data-id="popover"]').style.right = this.template.querySelector('[data-div="filterdiv"]').offsetWidth - 45 +"px";
      }
    }
    else{
      if (e.target.offsetTop) {
        this.template.querySelector('[data-id="popover"]').style.display = "block";
        this.template.querySelector('[data-id="popover"]').style.top = (e.target.offsetTop-79) + "px";
        this.template.querySelector('[data-id="popover"]').style.right = this.template.querySelector('[data-div="filterdiv"]').offsetWidth - 45 +"px";
      }
    }
    this.filterList.splice(index, 1);
    if (this.filterList.length == 0) {
      this.showPanelBodyHead = false;
      this.template.querySelector('[data-id="popover"]').style.display = "none";  
      this.showSaveButton = false;
    }
  }
  closepopover(){
    this.template.querySelector('[data-id="popover"]').style.display = "none";  
  }
  openPopover(e){
    let value = e.currentTarget.id;
    let value1= value.split('-');
    let index = value1[0];
    this.radioContactTrue = false;
    this.radioUserTrue = false;
    this.callGroupApexMethod = false; 
    let list = this.filterList[index].list;
    this.indexValue = index;
    const checkFieldTrue = list[0].fieldTrue;
    const obj = list[0].objectName;
    this.label = list[0].label;
    this.operator = list[0].operator;
    this.value = list[0].value;
    const field = list[0].fieldType; 
    let radioStatus = list[0].radio;
    console.log(radioStatus);
    if(obj === 'Contact'){
      this.headObjectName = obj;
      this.radioContactTrue = true;
      this.radioUserTrue = false;
      if(radioStatus){
        this.template.querySelector('[data-radio="radio"]').checked = true;
      
      }
    }
    if(obj === 'User'){
       this.headObjectName = obj;
      this.radioUserTrue = true;
      this.radioContactTrue = false;
      if(radioStatus){
        this.template.querySelector('[data-radio="radio"]').checked = true;
       getSubsidiary();
      }
    }
    getSObjectSchema({ name: obj }).then(results => {
      this.sObjectFieldsList = results;
    });
    getPicklistValue({
      fieldLabel: this.label,
      objectname: obj
    }).then(result => {
      if (result[0].type == "PICKLIST") {
        this.picklist = result[0].picklistValue;
      }
    }); 
    if (
      field == "DOUBLE" ||
      field == "PHONE" ||
      field == "CURRENCY"
    ) {
      this.fields = [{label:"none",value:""},
        { label: "equals", value: "equals" },
        { label: "not equal to", value: "not equal to" },
        { label: "less than", value: "less than" },
        { label: "greater than", value: "greater than" },
        { label: "less or equal", value: "less or equal" },
        {
          label: "greater or equal",
          value: "greater or equal"
        }
      ];
    } else {
      this.fields = [{label:"none",value:""},
        { label: "equals", value: "equals" },
        { label: "not equal to", value: "not equal to" },
        { label: "less than", value: "less than" },
        { label: "greater than", value: "greater than" },
        { label: "less or equal", value: "less or equal" },
        {
          label: "greater or equal",
          value: "greater or equal"
        },
        { label: "contains", value: "contains" },
        {
          label: "does not contain",
          value: "does not contain"
        },
        { label: "starts with", value: "starts with" }
      ];
    }
    console.log(checkFieldTrue+" "+obj+" "+this.label+" "+this.operator+" "+this.value+" "+this.indexValue);
    if(this.label!=null||this.operator!=null||this.value!=null){
      if (e.target.offsetTop) {
        this.template.querySelector('[data-id="popover"]').style.display = "block";
        this.template.querySelector('[data-id="popover"]').style.top = (e.target.offsetTop-20) + "px";
        this.template.querySelector('[data-id="popover"]').style.right = this.template.querySelector('[data-div="filterdiv"]').offsetWidth - 45 +"px";
  }
  setTimeout(()=>{
  this.template.querySelector('[data-ob="object"]').value = obj;
  this.template.querySelector('[ data-fi="field"]').value=this.label;
  this.template.querySelector('[data-operator="operator"]').value=this.operator;  
if (checkFieldTrue =='input') {
  console.log('iinput');
  this.input = false;
  this.date = false;
  this.pick = false;
  setTimeout(()=>{
    this.template.querySelector('[data-input="input"]').value=this.value;
  },10);
  
}
if (checkFieldTrue == 'date') {
  console.log('date');
  this.date = true;
  this.input = true;
  this.pick = false;
  setTimeout(()=>{
    this.template.querySelector('[data-date="date"]').value=this.value;
  },8);
 
}
if (checkFieldTrue=='pick') {
  console.log('pck');
  this.pick = true;
  this.input = true;
  this.date = false;
  setTimeout(()=>{
    this.template.querySelector('[data-pickvalue="picklist"]').value=this.value;
  },10);
}
},10);
  }
  }
  removeAllFilter() {
    this.saveDataList = [];
    this.picklistList = [];
    this.filterList = [];
    this.showSaveButton = false;
    this.showPanelBodyHead = false;
    this.showTable = false;
    this.showGroupTable = false;
    this.radioContactTrue = false;
    this.objectField = [];
    this.fields = [];
    console.log(JSON.stringify(this.sobjectWrapper));
    this.template.querySelector('[data-ob="object"]').value="";
    this.template.querySelector('[ data-fi="field"]').value="";
    this.template.querySelector('[data-operator="operator"]').value="";  
  if (this.input == false) {
    this.template.querySelector('[data-input="input"]').value="";
  } else if (this.date == true) {
    this.template.querySelector('[data-date="date"]').value="";
  } else if (this.pick == true) {
    this.template.querySelector('[data-pickvalue="picklist"]').value="";
  }
  this.template.querySelector('[data-id="popover"]').style.display = "none";
  if(this.sobjectWrapper.length>0){
    this.sobjectWrapList = [];
    for(var i=0;i<this.sobjectWrapper.length;i++){
      this.sobjectWrapList.push({count:this.sobjectWrapper[i].totalCount,name:this.sobjectWrapper[i].sobjectName});
    }
    this.showTable = true;
    }
  }
  get options() {
    this.objectField = [];
    if (this.sObjects) {
      for (var i = 0; i < this.sObjects.length; i++) {
        this.objectField.push({
          label: this.sObjects[i],
          value: this.sObjects[i]
        });
      }
    }
    return this.objectField;
  }
  get getField() {
    this.sObjectFields = [];
    for (var i = 0; i < this.sObjectFieldsList.length; i++) {
      this.sObjectFields.push({
        label: this.sObjectFieldsList[i].Name,
        value: this.sObjectFieldsList[i].Name
      });
    }
    return this.sObjectFields;
  }
  getOperatorAndValue(e) {
    console.log(e.detail.label);
    this.pick = false;
    this.picklist = [];
    this.fieldLabel = "";
    this.fieldType = "";
    this.fieldLabel = e.target.value;
    getPicklistValue({
      fieldLabel: this.fieldLabel,
      objectname: this.objectname
    }).then(result => {
      if (result[0].type == "PICKLIST") {
        this.picklist = result[0].picklistValue;
        this.fieldType = result[0].type;
      } else {
        this.fieldType = result[0].type;
      }
      if (this.fieldType == "DATE" || this.fieldType == "DATETIME") {
        this.pick = false;
        this.input = true;
        this.date = true;
        this.trueField="date";
      } else if (this.fieldType == "PICKLIST") {
        this.date = false;
        this.input = true;
        this.pick = true;
        this.trueField="pick";
      } else {
        this.pick = false;
        this.date = false;
        this.input = false;
        this.trueField="input";
      }
      if (
        this.fieldType == "DOUBLE" ||
        this.fieldType == "PHONE" ||
        this.fieldType == "CURRENCY"
      ) {
        this.fields = [{label:"none",value:""},
          { label: "equals", value: "equals" },
          { label: "not equal to", value: "not equal to" },
          { label: "less than", value: "less than" },
          { label: "greater than", value: "greater than" },
          { label: "less or equal", value: "less or equal" },
          {
            label: "greater or equal",
            value: "greater or equal"
          }
        ];
      } else {
        this.fields = [{label:"none",value:""},
          { label: "equals", value: "equals" },
          { label: "not equal to", value: "not equal to" },
          { label: "less than", value: "less than" },
          { label: "greater than", value: "greater than" },
          { label: "less or equal", value: "less or equal" },
          {
            label: "greater or equal",
            value: "greater or equal"
          },
          { label: "contains", value: "contains" },
          {
            label: "does not contain",
            value: "does not contain"
          },
          { label: "starts with", value: "starts with" }
        ];
      }
    });
  }
  getObject(e) {
    this.objectname = e.target.value;
    this.headObjectName = this.objectname;
    this.picklistList = [];
    this.sObjectFields = [];
    this.input = false;
    this.pick = false;
    this.date = false;
    if(this.objectname == 'Contact'){
    this.radioContactTrue = true;
    this.radioUserTrue =false;
    }
    else if(this.objectname == 'User'){
      this.radioUserTrue =true;
      this.radioContactTrue = false;
    }
    else{
      this.radioUserTrue =false;
      this.radioContactTrue = false;
    }
    setTimeout(() => {
      getSObjectSchema({ name: this.objectname }).then(results => {
        this.sObjectFieldsList = results;
      });
    }, 10);
  }
  get values() {
    let picklistList = [];
    picklistList.push({label:"none",value:""});
    for (var i = 0; i < this.picklist.length; i++) {
      picklistList.push({
        label: this.picklist[i],
        value: this.picklist[i]
      });
    }
    return picklistList;
  }
  reflectFieldValue() {
    this.label = this.template.querySelector('[ data-fi="field"]').value;
      this.operator = this.template.querySelector('[data-operator="operator"]').value;  
    if (this.input == false) {
      this.value = this.template.querySelector('[data-input="input"]').value;
    } else if (this.date == true) {
      this.value = this.template.querySelector('[data-date="date"]').value;
      console.log(this.value);
    } else if (this.pick == true) {
      this.value = this.template.querySelector('[data-pickvalue="picklist"]').value;
    }
    this.filterList[this.indexValue].list = [];
    this.filterList[this.indexValue].list.push({
      fieldTrue:this.trueField,
      objectName:this.objectname,
      label: this.label,
      operator: this.operator,
      value: this.value,
      fieldType:this.fieldType
    });
    if( this.template.querySelector('[data-radio="radio"]').checked){
      console.log('ssssssssss000');
      this.filterList[this.indexValue].list.push({radio:true});
    }
    this.filterList[this.indexValue].showdiv = true;
    this.showSaveButton=true;
    this.template.querySelector('[data-id="popover"]').style.display = "none";
  }
  closeDiv(e) {
    let index = e.target.dataset.div;
    this.filterList[index].showdiv = false;
  }
  selectedPicklistValue(e){
    this.selectedPicklist = e.target.value;
   console.log(e.target.value);
  }
  getSubsidiary(){
    let checkIsTrue = this.template.querySelector('[data-radio="radio"]').checked; 
    console.log(checkIsTrue);
    if(checkIsTrue){
       if(this.checkSubsidiaryRadio==1){
        this.template.querySelector('[data-radio="radio"]').checked = false;
        this.callGroupApexMethod = false;
        this.checkSubsidiaryRadio = 0;
        console.log(this.checkSubsidiaryRadio);
       }
       else{
        this.template.querySelector('[data-radio="radio"]').checked = true;   
        this.checkSubsidiaryRadio=1; 
        console.log(this.checkSubsidiaryRadio);
        this.callGroupApexMethod = true; 
      }      
    }
    
  }
  closeGroupTable(){
    this.showGroupTable = false;
  }
  updateTable(){
    updateObjectTable({objectlist:this.sObjects,sobjectname:this.objectname,label:this.label,operator:this.operator,value:this.value}).then(result=>{
      console.log(JSON.stringify(result));
      if(result.length>0){
      const index = this.sobjectWrapList.findIndex(x => x.name === result[0].sobjectName);
      this.sobjectWrapList[index].count = result[0].totalCount;
      }
     });
     console.log(this.callGroupApexMethod);
     if(this.callGroupApexMethod){
     getGroupByCode({sobjectname:this.objectname,label:this.label,operator:this.operator,value:this.value}).then(result=>{
      this.groupList = result;
      if(this.groupList.length>0){
        this.showGroupTable = true;
      }
    });
  }
  }
}