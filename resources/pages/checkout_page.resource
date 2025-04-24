*** Settings ***
Documentation     Keywords related to the checkout page
Library           Browser
Resource          ../common.resource

*** Variables ***
# Checkout page locators - Step One
${CHECKOUT_STEP_ONE}        id=checkout_info_container
${FIRST_NAME_FIELD}         id=first-name
${LAST_NAME_FIELD}          id=last-name
${POSTAL_CODE_FIELD}        id=postal-code
${CONTINUE_BUTTON}          id=continue
${CANCEL_BUTTON}            id=cancel
${ERROR_MESSAGE}            [data-test="error"]

# Checkout page locators - Step Two
${CHECKOUT_STEP_TWO}        id=checkout_summary_container
${SUMMARY_SUBTOTAL}         .summary_subtotal_label
${SUMMARY_TAX}              .summary_tax_label
${SUMMARY_TOTAL}            .summary_total_label
${FINISH_BUTTON}            id=finish

# Checkout page locators - Complete
${CHECKOUT_COMPLETE}        id=checkout_complete_container
${COMPLETE_HEADER}          .complete-header
${BACK_HOME_BUTTON}         id=back-to-products

*** Keywords ***
Verify Checkout Step One Page Loaded
    Verify Current URL    checkout-step-one.html
    Verify Element Is Visible    ${CHECKOUT_STEP_ONE}

Fill Checkout Information
    [Arguments]    ${first_name}=${FIRST_NAME}    ${last_name}=${LAST_NAME}    ${postal_code}=${POSTAL_CODE}
    Wait And Type    ${FIRST_NAME_FIELD}    ${first_name}
    Wait And Type    ${LAST_NAME_FIELD}    ${last_name}
    Wait And Type    ${POSTAL_CODE_FIELD}    ${postal_code}
    
Continue To Step Two
    Wait And Click    ${CONTINUE_BUTTON}
    Verify Checkout Step Two Page Loaded

Cancel Checkout
    Wait And Click    ${CANCEL_BUTTON}
    Verify Cart Page Loaded

Verify Checkout Step Two Page Loaded
    Verify Current URL    checkout-step-two.html
    Verify Element Is Visible    ${CHECKOUT_STEP_TWO}

Verify Checkout Summary
    [Arguments]    ${expected_items_count}
    Verify Element Count    ${CART_ITEMS}    ${expected_items_count}
    Verify Element Is Visible    ${SUMMARY_SUBTOTAL}
    Verify Element Is Visible    ${SUMMARY_TAX}
    Verify Element Is Visible    ${SUMMARY_TOTAL}

Complete Checkout
    Wait And Click    ${FINISH_BUTTON}
    Verify Checkout Complete Page Loaded

Verify Checkout Complete Page Loaded
    Verify Current URL    checkout-complete.html
    Verify Element Is Visible    ${CHECKOUT_COMPLETE}
    Verify Element Is Visible    ${COMPLETE_HEADER}
    Verify Element Text    ${COMPLETE_HEADER}    Thank you for your order!

Return To Products
    Wait And Click    ${BACK_HOME_BUTTON}
    Verify Inventory Page Loaded