*** Settings ***
Documentation     Test suite for inventory page functionality
Resource          ../resources/common.resource
Test Setup        Run Keywords    Setup Browser    AND    Login Page.Login With Valid Credentials
Test Teardown     Teardown Browser
Test Tags         inventory

*** Test Cases ***
Verify Product List
    [Documentation]    Verify the product list is displayed correctly
    Inventory Page.Verify Inventory Page Loaded

Add Product To Cart
    [Documentation]    Verify adding a product to cart
    Inventory Page.Verify Inventory Page Loaded
    ${item_name}=    Inventory Page.Get Item Name    1
    ${item_price}=    Inventory Page.Get Item Price    1
    Inventory Page.Add Item To Cart    1
    Inventory Page.Verify Shopping Cart Badge    1
    Inventory Page.Go To Shopping Cart
    Cart Page.Verify Cart Page Loaded
    Cart Page.Verify Cart Contents    1
    Cart Page.Verify Cart Item Details    1    ${item_name}    ${item_price}

Remove Product From Cart From Inventory Page
    [Documentation]    Verify removing a product from cart on inventory page
    Inventory Page.Verify Inventory Page Loaded
    Inventory Page.Add Item To Cart    1
    Inventory Page.Verify Shopping Cart Badge    1
    Inventory Page.Remove Item From Cart    1
    Inventory Page.Verify Shopping Cart Badge    0

Sort Products By Name (A to Z)
    [Documentation]    Verify sorting products by name A to Z
    Inventory Page.Verify Inventory Page Loaded
    Inventory Page.Sort Products    Name (A to Z)
    ${first_item}=    Inventory Page.Get Item Name    1
    ${second_item}=    Inventory Page.Get Item Name    2
    Should Be True    '${first_item}' < '${second_item}'

Sort Products By Name (Z to A)
    [Documentation]    Verify sorting products by name Z to A
    Inventory Page.Verify Inventory Page Loaded
    Inventory Page.Sort Products    Name (Z to A)
    ${first_item}=    Inventory Page.Get Item Name    1
    ${second_item}=    Inventory Page.Get Item Name    2
    Should Be True    '${first_item}' > '${second_item}'

Sort Products By Price (Low to High)
    [Documentation]    Verify sorting products by price low to high
    Inventory Page.Verify Inventory Page Loaded
    Inventory Page.Sort Products    Price (low to high)
    ${first_price}=    Inventory Page.Get Item Price    1
    ${second_price}=    Inventory Page.Get Item Price    2

Sort Products By Price (High to Low)
    [Documentation]    Verify sorting products by price high to low
    Inventory Page.Verify Inventory Page Loaded
    Inventory Page.Sort Products    Price (high to low)
    ${first_price}=    Inventory Page.Get Item Price    1
    ${second_price}=    Inventory Page.Get Item Price    2
