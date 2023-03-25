{/* <Helper class to get data from apex and pass to LWC */}
import { LightningElement, api ,track,wire } from 'lwc';
import getProdInfo from '@salesforce/apex/ProductDisplayController.getProdInfo';

export default class DisplayProductDetails extends LightningElement {
@api recordId;
@track products = [];
@track error;
@track productMap;

//call apex controller
@wire (getProdInfo,{caseId: '$recordId'})
	wiredProducts({data, error}){
		if(data) {
                   this.products = data;
		}else if(error){
	           this.error = error;
		}
	}
}
