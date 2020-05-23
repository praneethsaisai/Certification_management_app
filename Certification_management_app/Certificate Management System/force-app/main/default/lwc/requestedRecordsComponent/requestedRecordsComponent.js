import { LightningElement,wire } from 'lwc';
import getdata from '@salesforce/apex/CertificationRequests.getAllRequests';
export default class RequestedRecordsComponent extends LightningElement {
    Requests;
    @wire (getdata)
    getApexData({error,data}){
        if(data){
            console.log(data);
            this.Requests=data;
        }
        if(error){
            console.log('error has occured');
        }
    }
}