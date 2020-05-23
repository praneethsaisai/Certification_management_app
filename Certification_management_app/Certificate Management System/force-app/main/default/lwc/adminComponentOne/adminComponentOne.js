import { LightningElement,wire } from 'lwc';
import addemployee from '@salesforce/apex/CertificationRequests.addNewEmp';
import addcertification from '@salesforce/apex/CertificationRequests.addNewCert';
import addvoucher from '@salesforce/apex/CertificationRequests.addNewVou';
import viewemployees from '@salesforce/apex/CertificationRequests.getAllEmployees';
import viewcertifications from '@salesforce/apex/CertificationRequests.getAllCertifications';
import viewvouchers from '@salesforce/apex/CertificationRequests.getAllVouchers';
import upvoucher from '@salesforce/apex/CertificationRequests.upervoucher';
import upemployee from '@salesforce/apex/CertificationRequests.uperemp';
import upcerti from '@salesforce/apex/CertificationRequests.upercert';
import delevoucher from '@salesforce/apex/CertificationRequests.delVoucher';
import deleemp from '@salesforce/apex/CertificationRequests.delEmployee';
import delecert from '@salesforce/apex/CertificationRequests.delCertificate';

export default class AdminComponentOne extends LightningElement {
    empflag;
    certflag;
    vouflag;

    viewempflag;
    viewcertflag;
    viewvouflag;

    Employees;
    Certifications;
    Vouchers;

    @wire (viewemployees)
    getApexData({error,data}){
        if(data){
            console.log(data);
            this.Employees=data;
            var req=data[0];
            console.log(req.Name);
        }
        if(error){
            console.log('error has occured');
        }
    }

    @wire (viewcertifications)
    getApexData1({error,data}){
        if(data){
            console.log(data);
            this.Certifications=data;
        }
        if(error){
            console.log('error has occured');
        }
    }

    @wire (viewvouchers)
    getApexData2({error,data}){
        if(data){
            console.log(data);
            this.Vouchers=data;
            var req=data[0];
            console.log(req.Name);
        }
        if(error){
            console.log('error has occured');
        }
    }

    viewemps() {
        this.viewempflag = true;
        this.viewvouflag=false;
        this.viewcertflag=false;
    }

    viewcerts() {
        this.viewcertflag = true;
        this.viewvouflag=false;
        this.viewempflag=false;
    }
    viewvous() {
        this.viewvouflag = true;
        this.viewempflag=false;
        this.viewcertflag=false;
    }

    EmpName;
    EmpId;
    EmpMail;
    EmpPS;
    EmpSS;
    EmpExp;
    EmpComm;

    CertName;
    CertId;
    CertCost;
    CertComm;

    VouId;
    VouCost;
    VouValid;
    VouCert;
    VouComm;
    VouActive;

    CertRecordId;

    EmpNameChange(event) {
        this.EmpName = event.target.value;
    }
    EmpIdChange(event) {
        this.EmpId = event.target.value;
    }
    EmpMailChange(event) {
        this.EmpMail = event.target.value;
    }
    EmpPSChange(event) {
        this.EmpPS = event.target.value;
    }
    EmpSSChange(event) {
        this.EmpSS = event.target.value;
    }
    EmpExpChange(event) {
        this.EmpExp = event.target.value;
    }
    EmpCommChange(event) {
        this.EmpComm = event.target.value;
    }

    CertNameChange(event) {
        this.CertName = event.target.value;
    }
    CertIdChange(event) {
        this.CertId = event.target.value;
    }
    CertCostChange(event) {
        this.CertCost = event.target.value;
    }
    CertCommChange(event) {
        this.CertComm = event.target.value;
    }

    VouIdChange(event) {
        this.VouId = event.target.value;
    }
    VouCostChange(event) {
        this.VouCost = event.target.value;
    }
    VouValidChange(event) {
        this.VouValid = event.target.value;
        this.openlookup = true;
    }
    VouCommChange(event) {
        this.VouComm = event.target.value;
    }  
    /*value = ['true'];
    get VouOption() {
        return [
            { label: 'Active', value: 'true' }
        ];
    }*/
    VouActiveChange(event){
        //this.VouActive = event.detail.value;
        this.VouActive = event.target.checked;
        console.log(this.VouActive);
    }

    handleAutoSelect(event) {
        var nav = event.detail;
        this.VouCert = nav.selectedRecordName;
        this.CertRecordId = nav.selectedRecordId;
    }

    empform() {
        this.empflag = true;
    }

    certform() {
        this.certflag = true;
    }

    vouform() {
        this.vouflag = true;
        console.log(this.VouActive);
    }

    addemp() {
        addemployee({ EmpName: this.EmpName, EmpId: this.EmpId, EmpMail: this.EmpMail, EmpPS: this.EmpPS, EmpSS: this.EmpSS, EmpExp: this.EmpExp, EmpComm: this.EmpComm }).then(result => { if (result == 'Employee Created Successfully') { alert(result); } else alert(result); });
        this.empflag = false;
    }

    addcert() {
        addcertification({ CertName: this.CertName, CertId: this.CertId, CertCost: this.CertCost, CertComm: this.CertComm }).then(result => { if (result == 'Certification Created Successfully') { alert(result); } else alert(result); });
        this.certflag = false;
    }

    addvou() {
        addvoucher({ VouId: this.VouId, VouCost: this.VouCost, VouValid: this.VouValid, VouCert: this.CertRecordId, VouComm: this.VouComm, VouActive: this.VouActive }).then(result => { if (result == 'Voucher Added Successfully') { alert(result); } else alert(result); });
        this.vouflag = false;
    }

    closepopup() {
        this.empflag = false;
        this.certflag = false;
        this.vouflag = false;
        this.viewvouflag=false;
        this.viewempflag=false;
        this.viewcertflag=false;
    }

    vid;
    upvflag;
    updatevoucher(event){
        this.vid=event.target.value;
        this.VouId=this.Vouchers[this.vid].Name;
        this.VouCost=this.Vouchers[this.vid].Voucher_Cost__c;
        this.VouComm=this.Vouchers[this.vid].Comments__c;
        this.upvflag = true;
        alert('works'+ {upvflag});
    }
    updatervoucher(){
        upvoucher({ VouCost: this.VouCost, VouComm: this.VouComm, inde: this.Vouchers[this.vid].Id});
        this.upvflag = false;
    }

    deletevoucher(event){
        this.vid=event.target.value;
        delevoucher({inde: this.vid});//.then(result => { if (result == 'Deleted voucher successfully') { alert(result); } else alert(result); });
        location.reload();
    }

    eid;
    upeflag;
    updateemp(event){
        this.eid=event.target.value;
        console.log(this.eid);
        this.EmpName=this.Employees[this.eid].Name;
        this.EmpId=this.Employees[this.eid].Emp_ID__c;
        this.EmpMail=this.Employees[this.eid].Employee_email__c;
        this.EmpPS=this.Employees[this.eid].Primary_Skill__c;
        this.EmpSS=this.Employees[this.eid].Secondary_Skill__c;
        this.EmpExp=this.Employees[this.eid].Experience__c;
        this.EmpComm=this.Employees[this.eid].Comments__c;
        this.upeflag = true;
    }
    updateremp(){
        upemployee({ EmpName: this.EmpName, EmpId: this.EmpId, EmpMail: this.EmpMail, EmpPS: this.EmpPS, EmpSS: this.EmpSS, EmpExp: this.EmpExp, EmpComm: this.EmpComm, inde: this.Employees[this.eid].Id});
        this.upeflag = false;
    }
    deleteemployee(event){
        this.eid=event.target.value;
        deleemp({inde: this.eid});
        location.reload();
    }

    cid;
    cetfla;
    sample(event){
        this.cid=event.target.value;
        console.log("entered");
        console.log(this.cid);
        console.log("ended");
        this.CertName=this.Certifications[this.cid].Name;
        this.CertId=this.Certifications[this.cid].Cert_Id__c;
        this.CertCost=this.Certifications[this.cid].Certification_cost__c;
        this.CertComm=this.Certifications[this.cid].Comments__c;
        this.cetfla = true;
        console.log(this.cetfla);
    }
    updatercert(){
        console.log("in second step");
        upcerti({ CertName: this.CertName, CertId: this.CertId, CertCost: this.CertCost, CertComm: this.CertComm, inde: this.Certifications[this.cid].Id}).then(result => { if (result == 'updated certificate successfully') { alert(result); } else alert(result); });
        console.log("step - 2-1");
        this.cetfla = false;
        console.log("step - 2-2");
    }
    deletecertificate(event){
        this.cetfla = event.target.value;
        delecert({inde: this.cetfla});
        location.reload();
    }

    closeflag(){
        this.cetfla = false;
        this.upvflag = false;
        this.upeflag = false;
    }
}