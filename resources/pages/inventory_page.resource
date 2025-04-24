*** Settings ***
Documentation     Keywords related to the inventory page
Library           Browser
Resource          ../common.resource

*** Variables ***
# Inventory page locators
${INVENTORY_CONTAINER}       id=inventory_container
${INVENTORY_ITEMS}           .inventory_item
${ITEM_NAME}                 .inventory_item_name
${ITEM_PRICE}                .inventory_item_price
${ADD_TO_CART_BUTTON}        [data-test^="add-to-cart"]
${REMOVE_BUTTON}             [data-test^="remove"]
${SHOPPING_CART_BADGE}       .shopping_cart_badge
${SHOPPING_CART_LINK}        .shopping_cart_link
${PRODUCT_SORT_CONTAINER}    [data-test="product_sort_container"]
${BURGER_MENU_BUTTON}        id=react-burger-menu-btn
${LOGOUT_LINK}               id=logout_sidebar_link
${MENU_CLOSE_BUTTON}         id=react-burger-cross-btn

*** Keywords ***
Verify Inventory Page Loaded
    Verify Current URL    inventory.html
    Verify Element Is Visible    ${INVENTORY_CONTAINER}
    Verify Element Count    ${INVENTORY_ITEMS}    6

Add Item To Cart
    [Arguments]    ${item_index}=1
    ${add_to_cart_button}=    Set Variable    (${INVENTORY_ITEMS})[${item_index}] ${ADD_TO_CART_BUTTON}
    Wait And Click    ${add_to_cart_button}
    Verify Item Added To Cart    ${item_index}

Verify Item Added To Cart
    [Arguments]    ${item_index}=1
    ${remove_button}=    Set Variable    (${INVENTORY_ITEMS})[${item_index}] ${REMOVE_BUTTON}
    Verify Element Is Visible    ${remove_button}
    Verify Shopping Cart Badge    1

Remove Item From Cart
    [Arguments]    ${item_index}=1
    ${remove_button}=    Set Variable    (${INVENTORY_ITEMS})[${item_index}] ${REMOVE_BUTTON}
    Wait And Click    ${remove_button}
    ${add_to_cart_button}=    Set Variable    (${INVENTORY_ITEMS})[${item_index}] ${ADD_TO_CART_BUTTON}
    Verify Element Is Visible    ${add_to_cart_button}

Verify Shopping Cart Badge
    [Arguments]    ${expected_count}
    IF    ${expected_count} > 0
        Verify Element Is Visible    ${SHOPPING_CART_BADGE}
        Verify Element Text    ${SHOPPING_CART_BADGE}    ${expected_count}
    ELSE
        Verify Element Is Not Visible    ${SHOPPING_CART_BADGE}
    END

Go To Shopping Cart
    Wait And Click    ${SHOPPING_CART_LINK}

Sort Products
    [Arguments]    ${sort_option}
    Wait And Click    ${PRODUCT_SORT_CONTAINER}
    Wait And Click    xpath=//option[text()='${sort_option}']

Get Item Name
    [Arguments]    ${item_index}=1
    ${item_name_locator}=    Set Variable    (${INVENTORY_ITEMS})[${item_index}] ${ITEM_NAME}
    ${item_name}=    Get Text    ${item_name_locator}
    RETURN    ${item_name}

Get Item Price
    [Arguments]    ${item_index}=1
    ${item_price_locator}=    Set Variable    (${INVENTORY_ITEMS})[${item_index}] ${ITEM_PRICE}
    ${item_price}=    Get Text    ${item_price_locator}
    RETURN    ${item_price}

Logout
    Wait And Click    ${BURGER_MENU_BUTTON}
    Wait And Click    ${LOGOUT_LINK}
    Verify Login Page Loaded