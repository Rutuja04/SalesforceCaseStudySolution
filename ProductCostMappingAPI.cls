/*
* Class to genrate API that returns Product Information on callout
*/ 
@RestResource(urlMapping='/api/ProductCostMapping__c/*')
global with sharing class ProductCostMappingAPI {
    
    //GET METHOD
    @HttpGet
    global static ProductCostMapping__c getContact() {
        Contact contact = new Contact();
        ProductCostMapping__c prodCostMapping = new ProductCostMapping__c();
        try{
            String uuid = RestContext.request.params.get('UUID__c');
            if(uuid != null){
                contact = [SELECT Product__c,Home_Country__c,UUID__c , Phone FROM Contact WHERE UUID__c = :uuid limit 1];
            }
            if(contact.Home_Country__c != null && contact.Product__c != null){
                prodCostMapping = [Select Product__c,Home_Country__c,Cost_per_Calendar_month__c,ATM_Fee_in_other_currencies__c, 
                                   Card_replacement_cost__c,CurrencyIsoCode from ProductCostMapping__c where 
                                   Home_Country__c =: contact.Home_Country__c AND
                                   Product__c =: contact.Product__c ];
            }
        }catch(Exception ex){
            System.debug('ERROR MESSAGE'+ ex.getMessage());
        }
        return prodCostMapping;
    }
}