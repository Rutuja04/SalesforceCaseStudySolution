//Test class to cover ProductDisplayController
@isTest
public class ProductDisplayControllerTest {
    
    //Test setup method to create required data
    @testSetup static void setup() {
        
        //Create Contact
        Contact ct = new Contact();
        ct.LastName = 'Jones';
        ct.Product__c = 'Standard';
        ct.Home_Country__c = 'UK';
        insert ct;
        
        //Create Case
        Case cs = new Case();
        cs.ContactId = ct.id;
        insert cs;
        
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
    
    //Test Method to cover try
    @isTest
    public static void getProdInfoTest(){
        
        Case cs = [Select id,ContactId from Case limit 1];
        System.assertNotEquals(null, cs.ContactId);
        
        Test.startTest();
        ProductDisplayController.getProdInfo(cs.Id);
        Test.stopTest();
    }
    
    //Test Method to cover catch
    @isTest
    public static void getProdInfoTest1(){
        Case cs = new Case();
        System.assertEquals(null, cs.ContactId);
        
        Test.startTest();
        ProductDisplayController.getProdInfo(cs.Id);
        Test.stopTest();
    }
}