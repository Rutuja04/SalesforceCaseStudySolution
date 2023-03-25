//Test class to cover ProductCostMappingAPI
@isTest
public class ProductCostMappingAPITest {
    
        //Test Setup method to create dummy data for test class
        @testSetup static void setup() {
        
        //Create Contact
        Contact ct = new Contact();
        ct.LastName = 'Jones';
        ct.Product__c = 'Standard';
        ct.Home_Country__c = 'UK';
        ct.UUID__c = '00011';
        insert ct;
        
        //Create Custom Setting record
        ProductCostMapping__c pcm = new ProductCostMapping__c();
        pcm.Name = 'X-0001';
        pcm.Product__c = 'Standard';
        pcm.Home_Country__c = 'UK';
        pcm.Card_replacement_cost__c = 20;
        pcm.ATM_Fee_in_other_currencies__c = 1.6;
        pcm.Cost_per_Calendar_month__c = 10.0;
        pcm.CurrencyIsoCode = 'GBP';
        insert pcm;
    }
   
    //Test method to cover try block
    static testMethod void getContactTest1() {
         String uuid = '00011';
         Contact c = [Select Id,Home_Country__c,Product__c,UUID__c from Contact where UUID__c =: uuid ];  
         System.assertNotEquals(null, c.Product__c);
         RestRequest req = new RestRequest(); 
         RestResponse res = new RestResponse();
         req.addHeader('httpMethod', 'GET');
         req.requestUri = '/services/api/ProductCostMapping__c';  
         req.params.put('UUID__c',uuid);
         RestContext.request = req; 
         RestContext.response= res;
        
         Test.startTest();
         ProductCostMappingAPI.getContact();
         Test.stopTest();
   }
    
    //Test method to cover catch block
    static testMethod void getContactTest2() {
         String uuid = '00011';
         Contact c = [Select Id,Home_Country__c,Product__c,UUID__c from Contact where UUID__c =: uuid ]; 
         System.assertNotEquals(null, c.Product__c);
         RestRequest req = new RestRequest(); 
         RestResponse res = new RestResponse();
         req.addHeader('httpMethod', 'GET');
         req.requestUri = '/services/api/ProductCostMapping__c';  
         req.params.put('UUID__c','00012');
         RestContext.request = req; 
         RestContext.response= res;
        
         Test.startTest();
         ProductCostMappingAPI.getContact();
         Test.stopTest();
   }

}