# PicPay Challenge App

It consists of developing a native iOS app implemented in Swift. It is a simulation of sending money to another person via credit card.

The user must choose a contact from a list, inform the amount to be sent and finalize the payment with the registered credit card. If there is no credit card registered, you must also inform it (card number, expiration date and CVV) before finalizing the payment.

Cards must be persisted in the app to be used for future payments.

# Contact List Feature

## BDD Specs

### Story: Customer requests to see their contact list

### Narrative #1

```
As an online customer
I want the app to automatically load my contacts
So I can always see my friends
```

#### Scenarios (Acceptance criteria)

```
Given the customer has connectivity
When the customer requests to see their contact list
Then the app should display the latest contact list from remote
And replace the cache with the new contact list
```

### Narrative #2

```
As an offline customer
I want the app to show the latest saved version of my contact list
So I can always see my friends
```

#### Scenarios (Acceptance criteria)

```
Given the customer doesn't have connectivity
  And there’s a cached version of the contact list
  And the cache is less than seven days old
 When the customer requests to see the contact list
 Then the app should display the latest contact list saved

Given the customer doesn't have connectivity
  And there’s a cached version of the contact list
  And the cache is seven days old or more
 When the customer requests to see the contact list
 Then the app should display an error message

Given the customer doesn't have connectivity
  And the cache is empty
 When the customer requests to see the contact list
 Then the app should display an error message
```
