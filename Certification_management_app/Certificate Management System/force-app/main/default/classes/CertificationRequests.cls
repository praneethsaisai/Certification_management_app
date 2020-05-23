public with sharing class CertificationRequests {
    public CertificationRequests() {

    }
    @AuraEnabled(cacheable=true)
    public static List<Certification_Request__c> getAllRequests(){
        List<Certification_Request__c> reqs = [SELECT Employee__c,Certification__c,Status__c,Voucher__c,Due_Date__c,Comments__c,Name,Id FROM Certification_Request__c ORDER BY Name DESC NULLS FIRST];
        return reqs;
    }
    @AuraEnabled(cacheable=true)
    public static List<Employee__c> getAllEmployees(){
        List<Employee__c> emps = [SELECT Name,Emp_ID__c,Employee_email__c,Primary_Skill__c,Secondary_Skill__c,Experience__c,Comments__c FROM Employee__c] ;
        return emps;
    }
    @AuraEnabled(cacheable=true)
    public static List<Certification__c> getAllCertifications(){
        List<Certification__c> certs = [SELECT Name,Cert_Id__c,Certification_cost__c,Comments__c FROM Certification__c];
        return certs;
    }
    @AuraEnabled(cacheable=true)
    public static List<Voucher__c> getAllVouchers(){
        List<Voucher__c> vous = [SELECT Name,Certification__c,Active__c,Validity__c,Voucher_Cost__c,Comments__c,Id FROM Voucher__c];
        return vous;
    }

    @AuraEnabled(cacheable=true)
    public static List<Certification_Request__c> getDraftRequests(){
        List<Certification_Request__c> reqs = [SELECT Employee__c,Certification__c,Status__c,Voucher__c,Due_Date__c,Comments__c,Name,Mail_ID__c,Id FROM Certification_Request__c WHERE Status__c='Draft' ORDER BY Employee__c DESC NULLS FIRST] ;
        return reqs;
    }
    @AuraEnabled(cacheable=true)
    public static List<Certification_Request__c> getAssignedRequests(){
        List<Certification_Request__c> reqs = [SELECT Employee__r.Name,Certification__r.Name,Status__c,Voucher__c,Due_Date__c,Comments__c,Name,Mail_ID__c,Id FROM Certification_Request__c WHERE Status__c='Assigned' ORDER BY Employee__c DESC NULLS FIRST] ;
        return reqs;
    }
    @AuraEnabled(cacheable=true)
    public static List<Certification_Request__c> getApprovedRequests(){
        List<Certification_Request__c> reqs = [SELECT Employee__r.Name,Certification__r.Name,Status__c,Voucher__c,Due_Date__c,Comments__c,Name,Mail_ID__c,Id FROM Certification_Request__c WHERE Status__c='Approved' ORDER BY Employee__c DESC NULLS FIRST] ;
        return reqs;
    }
    @AuraEnabled(cacheable=true)
    public static List<Certification_Request__c> getSubmittedRequests(){
        List<Certification_Request__c> reqs = [SELECT Employee__r.Name,Certification__r.Name,Status__c,Voucher__c,Due_Date__c,Comments__c,Name,Mail_ID__c,Id FROM Certification_Request__c WHERE Status__c='Submitted' ORDER BY Employee__c ASC NULLS FIRST] ;
        return reqs;
    }
    @AuraEnabled(cacheable=true)
    public static List<Certification_Request__c> getRejectedRequests(){
        List<Certification_Request__c> reqs = [SELECT Employee__c,Certification__c,Status__c,Voucher__c,Due_Date__c,Comments__c,Name,Mail_ID__c,Id FROM Certification_Request__c WHERE Status__c='Rejected' ORDER BY Employee__c DESC NULLS FIRST] ;
        return reqs;
    }
    @AuraEnabled(cacheable=true)
    public static List<Certification_Request__c> getResultRequests(){
        List<Certification_Request__c> reqs = [SELECT Employee__c,Certification__c,Status__c,Voucher__c,Due_Date__c,Comments__c,Name,Mail_ID__c,Id FROM Certification_Request__c WHERE Status__c='Passed' AND Status__c='Failed' ORDER BY Employee__c DESC NULLS FIRST] ;
        return reqs;
    }
    @AuraEnabled(cacheable=true)
    public static List<Certification_Request__c> getPassedRequests(){
        List<Certification_Request__c> reqs = [SELECT Employee__c,Certification__c,Status__c,Voucher__c,Due_Date__c,Comments__c,Name,Mail_ID__c,Id FROM Certification_Request__c WHERE Status__c='Passed' ORDER BY Employee__c DESC NULLS FIRST] ;
        return reqs;
    }
    @AuraEnabled(cacheable=true)
    public static List<Certification_Request__c> getFailedRequests(){
        List<Certification_Request__c> reqs = [SELECT Employee__c,Certification__c,Status__c,Voucher__c,Due_Date__c,Comments__c,Name,Mail_ID__c,Id FROM Certification_Request__c WHERE Status__c='Failed' ORDER BY Employee__c DESC NULLS FIRST] ;
        return reqs;
    }

    //code for adding new employee record
    @AuraEnabled
    public static String addNewEmp(String EmpName,Decimal EmpId,String EmpMail,String EmpPS,String EmpSS,Decimal EmpExp,String EmpComm){
        Employee__c newemp = new Employee__c(Name=EmpName, Emp_ID__c=EmpId, Employee_email__c=EmpMail, Primary_Skill__c=EmpPS, Secondary_Skill__c=EmpSS, Experience__c=EmpExp, Comments__c=EmpComm);
        try {
            insert newemp; 
        }
        catch(Exception e){
             return e.getMessage();
        } 
        return 'Employee Created Successfully';    
    }
    //code for adding new certification record
    @AuraEnabled
    public static String addNewCert(String CertName, Decimal CertId, Decimal CertCost, String CertComm){
        Certification__c newcert = new Certification__c(Name=CertName, 	Cert_Id__c=CertId, Certification_cost__c=CertCost, Comments__c=CertComm); 
        try {
            insert newcert; 
        }
        catch(Exception e){
             return e.getMessage();
        } 
        return 'Certification Created Successfully';       
    }
    //code for adding new voucher record
    @AuraEnabled
    public static String addNewVou(String VouId, Decimal VouCost, Date VouValid,String VouCert, String VouComm, Boolean VouActive){
        Voucher__c newvou = new Voucher__c(Name=VouId, Voucher_Cost__c=VouCost, Validity__c=VouValid, Certification__c=VouCert, Comments__c=VouComm, Active__c=VouActive);
       try {
           insert newvou; 
        }
       catch(Exception e){
            return e.getMessage();
       } 
       return 'Voucher Added Successfully';    
    }


    //code for adding new Request record
    @AuraEnabled
    public static String addNewReq(String ReqEmp, String ReqCert, Date ReqDueDate, String ReqComm){
        Certification_Request__c newreq = new Certification_Request__c(Employee__c=ReqEmp, Certification__c=ReqCert, Due_Date__c=ReqDueDate, Comments__c=ReqComm);
        try {
            insert newreq; 
        }
        catch(Exception e){
            return e.getMessage();
       } 
       return 'Request Added Successfully';      
    }


    //code for submitting request for approval
    @AuraEnabled
    public static String updateRequest(String ReqRecordId,String status){
        Certification_Request__c updreq = new Certification_Request__c(Id=ReqRecordId,Status__c=status);
        try {
            update updreq; 
        }
        catch(Exception e){
            return e.getMessage();
       } 
       return 'Request Updated Successfully';
    }

    //updation of vouchers
    @AuraEnabled
    public static string upervoucher(String VouComm, Decimal VouCost, String inde){
        Voucher__c upvou = new Voucher__c(Id=inde, Comments__c=VouComm, Voucher_Cost__c=VouCost);
        try{
            update upvou;
        }
        catch(Exception e){
            return e.getMessage();
        }
        return 'Voucher successfully updated';
    }

    //deleting of vouchers
    @AuraEnabled
    public static void delVoucher(integer inde){
        List<Voucher__c> vous = [SELECT Active__c,Certification__c,Comments__c,Id,Name,Validity__c,Voucher_Cost__c FROM Voucher__c];
        Voucher__c vn = vous[inde];
        //try{
            delete vn;
        /*}
        catch(Exception e){
            return e.getMessage();
        }
        return 'Deleted voucher successfully';*/        
    }

    //updation of the employee
    @AuraEnabled
    public static void uperemp(String EmpName,Decimal EmpId,String EmpMail,String EmpPS,String EmpSS,Decimal EmpExp,String EmpComm, String inde){
        Employee__c emp = new Employee__c(Id=inde, Name=EmpName, Emp_ID__c=EmpId, Employee_email__c=EmpMail, Primary_Skill__c=EmpPS, Secondary_Skill__c=EmpSS, Experience__c=EmpExp, Comments__c=EmpComm);
        update emp;
    }
    //deleting of employee
    @AuraEnabled
    public static void delEmployee(integer inde){
        List<Employee__c> ems = [SELECT Name,Emp_ID__c,Employee_email__c,Primary_Skill__c,Secondary_Skill__c,Experience__c,Comments__c FROM Employee__c];
        Employee__c em = ems[inde];
        delete em;
    }

    //updation of the certification
    @AuraEnabled
    public static string upercert( Decimal CertCost, String CertComm, String inde){
        Certification__c cer=new Certification__c(Id=inde, Certification_cost__c=CertCost, Comments__c=CertComm);
        try{
            update cer;
        }
        catch(Exception e){
            return e.getMessage();
        }
        return 'updated certificate successfully';
    }
    @AuraEnabled
    public static void delCertificate(integer inde){
        List<Certification__c> cers = [SELECT Name,Cert_Id__c,Certification_cost__c,Comments__c FROM Certification__c];
        Certification__c cer = cers[inde];
        delete cer;
    }
}