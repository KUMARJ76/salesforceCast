import { api, LightningElement, wire } from 'lwc';
import { getObjectInfo, getPicklistValues } from 'lightning/uiObjectInfoApi';
import CASE_OBJECT from '@salesforce/schema/Case';
import CASE_STATUS from '@salesforce/schema/Case.Status';
import CASE_ID from '@salesforce/schema/Case.Id';
import { getFieldValue, getRecord, updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { notifyRecordUpdateAvailable } from 'lightning/uiRecordApi';



import {
    subscribe,
    unsubscribe,
    onError,
    setDebugFlag,
    isEmpEnabled,
} from 'lightning/empApi';


export default class CaseProgressIndicator extends LightningElement {

    statusOption;
    @api recordId;
    caseStatusValue;
    channelName = '/event/Case_Detail__e';
    isSubscribeDisabled = false;
    subscription = {}
    //! 1. Get the Picklist Values as case status

    @wire(getObjectInfo, {
        objectApiName: CASE_OBJECT
    }) objectInfo;

    @wire(getPicklistValues, {
        recordTypeId: "$objectInfo.data.defaultRecordTypeId",
        fieldApiName: CASE_STATUS
    })
    picklistFunction({ data, error }) {
        if (data) {
            this.statusOption = data.values;
        } else if (error) {
            console.error('Error fetching picklist values', error);
        }
    }
    //! 1. Get the Current Values as case status

    @wire(getRecord, {
        recordId: "$recordId",
        fields: [CASE_STATUS]
    })
    getRecordOutput({ data, error }) {
        if (data) {
            this.caseStatusValue = getFieldValue(data, CASE_STATUS);
        } else if (error) {
            console.error('Error fetching record data', error);
        }
    }

    // Initializes the component
    connectedCallback() {
        this.handleSubscribe();
        // Register error listener
        this.registerErrorListener();
    }


    // Handles subscribe button click
    handleSubscribe() {
        // Callback invoked whenever a new event message is received
        // const messageCallback = function (response) {
        //     console.log('New message received: ', JSON.stringify(response));
        //     // Response contains the payload of the new message received
        // };

        const messageCallback = (response) => {
            console.log('Message received', JSON.stringify(response));
            this.handleEventResponse(response);
        }

        // Invoke subscribe method of empApi. Pass reference to messageCallback
        subscribe(this.channelName, -1, messageCallback).then((response) => {
            // Response contains the subscription information on subscribe call
            console.log(
                'Subscription request sent to: ',
                JSON.stringify(response.channel)
            );
            this.subscription = response;


        });
    }



    registerErrorListener() {
        // Invoke onError empApi method
        onError((error) => {
            console.log('Received error from server: ', JSON.stringify(error));
            // Error contains the server-side error
        });
    }


    disconnectedCallback() {
        // Invoke unsubscribe method of empApi
        unsubscribe(this.subscription, (response) => {
            console.log('unsubscribe() response: ', JSON.stringify(response));
            // Response is true for successful unsubscribe
        });

    }

    async handleEventResponse(response) {
        console.log('Response from Postman', JSON.parse(JSON.stringify(response)));

        /*if(response.hasOwnProperty('data')){
            let jsonObject=response.data;

            if(jsonObject.hasOwnProperty('payload')){
                let responseCaseId=response.data.payload.Case_Id__c; 
                let responseCaseStatus=response.data.payload.Case_Status__c; 

               let fields={};
               fields[CASE_ID.fieldApiName]=responseCaseId;
               fields[CASE_STATUS.fieldApiName]=responseCaseStatus;

               let recordInput={fields}
               
               await updateRecord(recordInput)
               await notifyRecordUpdateAvailable([{recordId: this.recordId}]);
               
                const event = new ShowToastEvent({
                    title: 'Success',
                    message:
                        `Case status is set to ${responseCaseStatus} `,
                });
                this.dispatchEvent(event);
            
            }
        }*/
    }

}