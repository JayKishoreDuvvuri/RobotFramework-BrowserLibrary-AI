*** Settings ***
Documentation     Keywords related to the cart page
Library           Browser
Resource          ../common.resource

*** Variables ***
# Cart page locators
${CART_CONTAINER}           id=cart_contents_container
${CART_ITEMS}               .cart_item
${CART_ITEM_NAME}           .inventory_item_name
${CART_ITEM_PRICE}          .inventory_item_price
${CART_ITEM_QUANTITY}       .cart_quantity
${REMOVE_BUTTON}            [data-test^="remove"]
${CONTINUE_SHOPPING_BUTTON} [data-test="continue-shopping"]
${CHECKOUT_BUTTON}          [data-test="checkout"]

*** Keywords ***
Verify Cart Page Loaded
    Verify Current URL    cart.html
    Verify Element Is Visible    ${CART_CONTAINER}

Verify Cart Contents
    [Arguments]    ${expected_item_count}
    Verify Element Count    ${CART_ITEMS}    ${expected_item_count}

Verify Cart Item Details
    [Arguments]    ${item_index}    ${expected_name}    ${expected_price}
    ${item_name_locator}=    Set Variable    (${CART_ITEMS})[${item_index}] ${CART_ITEM_NAME}
    ${item_price_locator}=    Set Variable    (${CART_ITEMS})[${item_index}] ${CART_ITEM_PRICE}
    
    Verify Element Text    ${item_name_locator}    ${expected_name}
    Verify Element Text    ${item_price_locator}    ${expected_price}

Remove Item From Cart
    [Arguments]    ${item_index}=1
    ${before_count}=    Get Element Count    ${CART_ITEMS}
    ${remove_button}=    Set Variable    (${CART_ITEMS})[${item_index}] ${REMOVE_BUTTON}
    Wait And Click    ${remove_button}
    
    ${after_count}=    Evaluate    ${before_count} - 1
    IF    ${after_count} > 0
        Verify Element Count    ${CART_ITEMS}    ${after_count}
    END

Continue Shopping
    Wait And Click    ${CONTINUE_SHOPPING_BUTTON}
    Verify Inventory Page Loaded

Proceed To Checkout
    Wait And Click    ${CHECKOUT_BUTTON}
    Verify Checkout Step One Page Loaded