import { api, LightningElement } from 'lwc';
import { subscribe, unsubscribe, onError } from 'lightning/empApi';
import { notifyRecordUpdateAvailable } from 'lightning/uiRecordApi';

export default class DisplayRefreshMessage extends LightningElement {
    @api channelName = '/data/AccountChangeEvent';
    @api recordId;
    
    isDisplayMsg = false;
    subscription = {};

    // Initialize the component
    connectedCallback() {
        this.handleSubscribe();
        this.registerErrorListener();
    }

    // Subscribes to the channel
    handleSubscribe() {
        // Message callback to handle new events
        const messageCallback = (response) => {
            console.log('New Message Received', JSON.stringify(response));
            this.handleChangeEventResponse(response);
        };

        // Subscribe to the channel
        subscribe(this.channelName, -1, messageCallback).then(response => {
            console.log('Subscription request sent to', JSON.stringify(response.channel));
            this.subscription = response;
        }).catch(error => {
            console.error('Subscription error:', error);
        });
    }

    // Unsubscribes from the channel when the component is disconnected
    disconnectedCallback() {
        this.handleUnsubscribe();
    }

    // Unsubscribe logic
    handleUnsubscribe() {
        if (this.subscription) {
            unsubscribe(this.subscription, (response) => {
                console.log('Unsubscribed successfully', JSON.stringify(response));
            }).catch(error => {
                console.error('Unsubscribe error:', error);
            });
        }
    }

    // Registers error listener for empApi
    registerErrorListener() {
        onError((error) => {
            console.log('Received error from server:', JSON.stringify(error));
        });
    }

    // Handles the event response and checks for relevant record ID
    handleChangeEventResponse(response) {
        console.log(response);

        // Ensure the event contains data and payload
        if (response?.data?.payload) {
            const payload = response.data.payload;

            // Find if the current recordId exists in the payload
            const isRecordFound = payload.ChangeEventHeader.recordIds?.find(id => id === this.recordId);
            
            if (isRecordFound) {
                this.isDisplayMsg = true;
            }
        }
    }

    // Refresh button logic to update the record
    async refreshButton() {
        try {
            await notifyRecordUpdateAvailable([{ recordId: this.recordId }]);
            this.isDisplayMsg = false;
        } catch (error) {
            console.error('Error refreshing record:', error);
        }
    }
}
