import { LightningElement,track, api } from 'lwc';
import getAccountSchema from '@salesforce/apex/PopoverAccountSchema.getAccountSchema';
export default class PopoverComponentLWC extends LightningElement {
    @track show=false;
    @track height = 170;
    @track value = 'inProgress';
    @track valuelist = [];
    @track accountSchema = [];
    @track list=[];
    @api
    connectedCallback(){
          getAccountSchema().then(results=>{
            this.accountSchema = results;
            for(var i=0;i<this.accountSchema.length;i++){
            this.list.push({label:'Account: '+this.accountSchema[i],value: this.accountSchema[i]});
                if(i==this.accountSchema.length-1){
                    this.show = true;
                }
             }   
        });       
    }
    @api
    disconnectedCallback(){
        this.show = false;
    }
    @api
    handlecheck(e){   
    this.height +=55;
    this.template.querySelector('[data-id="test"]').style.display = "block";
    this.template.querySelector('[data-id="test"]').style.top = this.height+"px";
    this.template.querySelector('[data-id="test"]').style.left =  "584.007px";
    this.template.querySelector('[data-id="test"]').style.height = "300px";
    this.height +=15;
    }
    @api
    subtractTop(){
        this.height -=70;
        this.template.querySelector('[data-id="test"]').style.display = "block";
        this.template.querySelector('[data-id="test"]').style.top = this.height+"px";
        this.template.querySelector('[data-id="test"]').style.left =  "584.007px";
        this.template.querySelector('[data-id="test"]').style.height = "300px";
    }
    @api
    closeFunc(){
        console.log(this.show);
        this.show = false;
        console.log(this.show);
    }
    get options(){
   
    console.log(JSON.stringify(this.list));
        return this.list;
    }
    get opp(){
        return  [
            { label: 'equals', value: 'equals' },
            { label: 'not equals to', value: 'not equals to' },
            { label: 'less than', value: 'less than' },
        ];
    }
    saveData(){
        const selectedEvent = new CustomEvent('selected', { detail: this.valuelist });

        // Dispatches the event.
        this.dispatchEvent(selectedEvent);
    }
    saveValue(e){
     var value = e.target.value;
     this.valuelist.push(value);
    }
    handleChange(event) {
        this.value = event.detail.value;
        this.valuelist.push(this.value);
    }
    handle(event) {
        var value = event.detail.value;
        this.valuelist.push(value);
    }  
}