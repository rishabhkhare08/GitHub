import { LightningElement,api, track} from 'lwc';

export default class PopoverMainLWC extends LightningElement {
    @api showPop=false; 
    @track indexvalue; 
    @track iterate = [];
    popoverFunc(e){
     this.indexvalue = e.target.dataset.index;
     this.showPop = true;
     this.iterate.push("add"); 
     console.log(JSON.stringify(this.iterate));
     this.template.querySelector('c-popover-component-l-w-c').closeFunc();
     this.template.querySelector('c-popover-component-l-w-c').connectedCallback();
     this.template.querySelector('c-popover-component-l-w-c').handlecheck();
    }
    remove(e){
    var index = e.target.dataset.index;
    this.iterate.splice(index,1);
    this.template.querySelector('c-popover-component-l-w-c').closeFunc(); 
    this.template.querySelector('c-popover-component-l-w-c').connectedCallback();
    this.template.querySelector('c-popover-component-l-w-c').subtractTop();
    this.template.querySelector('c-popover-component-l-w-c').connectedCallback();
    }
    popovr(){
        this.template.querySelector('c-popover-component-l-w-c').closeFunc();
        this.template.querySelector('c-popover-component-l-w-c').handlecheck();        
    }
    removeall(){
        this.iterate = [];
        this.showPop = false;
    }
    reflect(e){
     this.iterate[this.indexvalue].list = e.detail;
     console.log(JSON.stringify(this.iterate));
    }
}