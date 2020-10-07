import { LightningElement, track } from 'lwc';

export default class QuoteCalcyLWC extends LightningElement {
@track addRow = [];

connectedCallback(){
this.addRow.push("addRow");

}
addMoreRow(){
    this.addRow.push("addRow");  
    console.log("sdffd"+this.addRow); 
}
delRow(e){
    var index = e.target.name;
    console.log(index);
    console.log(this.addRow.length);
    if(this.addRow.length>1){
    this.addRow.splice(index, 1);
    }
}
}