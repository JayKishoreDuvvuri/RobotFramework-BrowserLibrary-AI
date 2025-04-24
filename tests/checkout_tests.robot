*** Settings ***
Documentation     Test suite for checkout functionality
Resource          ../resources/common.resource
Test Setup        Run Keywords
...               Setup Browser    AND
...               Login Page.Login With Valid Credentials    AND
...               Inventory Page.Add Item To Cart    1    AND
...               Inventory Page.Go To Shopping Cart
Test Teardown     Teardown Browser
Test Tags         checkout

*** Test Cases ***
Complete Checkout Process
    [Documentation]    Verify complete checkout process
    Cart Page.Verify Cart Page Loaded
    Cart Page.Verify Cart Contents    1
    Cart Page.Proceed To Checkout
    
    Checkout Page.Verify Checkout Step One Page Loaded
    Checkout Page.Fill Checkout Information
    Checkout Page.Continue To Step Two
    
    Checkout Page.Verify Checkout Step Two Page Loaded
    Checkout Page.Verify Checkout Summary    1
    Checkout Page.Complete Checkout
    
    Checkout Page.Verify Checkout Complete Page Loaded
    Checkout Page.Return To Products
    Inventory Page.Verify Inventory Page Loaded

Cancel Checkout At Step One
    [Documentation]    Verify cancelling checkout at step one
    Cart Page.Verify Cart Page Loaded
    Cart Page.Proceed To Checkout
    
    Checkout Page.Verify Checkout Step One Page Loaded
    Checkout Page.Cancel Checkout
    
    Cart Page.Verify Cart Page Loaded
    Cart Page.Verify Cart Contents    1

Checkout With Empty Fields
    [Documentation]    Verify error when checkout with empty first name
    Cart Page.Verify Cart Page Loaded
    Cart Page.Proceed To Checkout
    
    Checkout Page.Verify Checkout Step One Page Loaded
    Checkout Page.Fill Checkout Information    ${EMPTY}    ${LAST_NAME}    ${POSTAL_CODE}
    Wait And Click    ${CONTINUE_BUTTON}
    Verify Element Contains Text    ${ERROR_MESSAGE}    Error: First Name is required

Checkout With Empty Last Name
    [Documentation]    Verify error when checkout with empty last name
    Cart Page.Verify Cart Page Loaded
    Cart Page.Proceed To Checkout
    
    Checkout Page.Verify Checkout Step One Page Loaded
    Checkout Page.Fill Checkout Information    ${FIRST_NAME}    ${EMPTY}    ${POSTAL_CODE}
    Wait And Click    ${CONTINUE_BUTTON}
    Verify Element Contains Text    ${ERROR_MESSAGE}    Error: Last Name is required

Checkout With Empty Postal Code
    [Documentation]    Verify error when checkout with empty postal code
    Cart Page.Verify Cart Page Loaded
    Cart Page.Proceed To Checkout
    
    Checkout Page.Verify Checkout Step One Page Loaded
    Checkout Page.Fill Checkout Information    ${FIRST_NAME}    ${LAST_NAME}    ${EMPTY}
    Wait And Click    ${CONTINUE_BUTTON}
    Verify Element Contains Text    ${ERROR_MESSAGE}    Error: Postal Code is required