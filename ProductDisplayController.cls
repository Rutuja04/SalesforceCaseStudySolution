/*
* Controller class to fetch the contact Id from Case Id and then the Product details from Contact Product and home country.
*/
public class ProductDisplayController {
    @AuraEnabled(cacheable = true)
    public static ContactDetails getProdInfo(Id caseId){
        
        ContactDetails cd = new ContactDetails();
        Contact con = new Contact();
        try{
            Id contactId = [Select Id,ContactId from Case where id =: caseId].ContactId;
            
            if(contactId != null){
                con = [SELECT Product__c,Home_Country__c,UUID__c , Phone FROM Contact WHERE Id = :contactId];
            }
            
            if(con.Product__c != null && con.Home_Country__c != null){
                ProductCostMapping__c prodCostMapping = [Select Product__c,Home_Country__c,Cost_per_Calendar_month__c,ATM_Fee_in_other_currencies__c, 
                                                         Card_replacement_cost__c,CurrencyIsoCode from ProductCostMapping__c where 
                                                         Home_Country__c =: con.Home_Country__c AND
                                                         Product__c =: con.Product__c ];
                cd.Product = prodCostMapping.Product__c;
                cd.HomeCountry = prodCostMapping.Home_Country__c;
                cd.CostperCalenderMonth = prodCostMapping.Cost_per_Calendar_month__c;
                cd.AtmFeePercent = prodCostMapping.ATM_Fee_in_other_currencies__c;
                cd.CardReplacementCost = prodCostMapping.Card_replacement_cost__c;
                cd.CurrencyCode = prodCostMapping.CurrencyIsoCode;
                
            }
            system.debug('CD::'+cd);
        }catch(Exception ex){
            System.debug('ERROR MESSAGE'+ ex.getMessage());
        }
        return cd;
    }
    
    //Wrapper class to send details to LWC
    public class ContactDetails{
        @AuraEnabled public String Product {get;set;}
        @AuraEnabled public String HomeCountry {get;set;}
        @AuraEnabled public Decimal CostperCalenderMonth {get;set;}
        @AuraEnabled public Decimal AtmFeePercent {get;set;}
        @AuraEnabled public Decimal CardReplacementCost {get;set;}
        @AuraEnabled public String CurrencyCode {get;set;}
    }
}