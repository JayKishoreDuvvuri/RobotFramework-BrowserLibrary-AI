*** Settings ***
Documentation     Test suite for cart page functionality
Resource          ../resources/common.resource
Test Setup        Run Keywords    Setup Browser    AND    Login Page.Login With Valid Credentials
Test Teardown     Teardown Browser
Test Tags         cart

*** Test Cases ***
Empty Cart Initially
    [Documentation]    Verify cart is empty initially
    Inventory Page.Verify Inventory Page Loaded
    Inventory Page.Go To Shopping Cart
    Cart Page.Verify Cart Page Loaded
    Cart Page.Verify Cart Contents    0

Add Multiple Products To Cart
    [Documentation]    Verify adding multiple products to cart
    Inventory Page.Verify Inventory Page Loaded
    Inventory Page.Add Item To Cart    1
    Inventory Page.Add Item To Cart    2
    Inventory Page.Verify Shopping Cart Badge    2
    Inventory Page.Go To Shopping Cart
    Cart Page.Verify Cart Page Loaded
    Cart Page.Verify Cart Contents    2

Remove Product From Cart Page
    [Documentation]    Verify removing a product from cart on cart page
    Inventory Page.Verify Inventory Page Loaded
    Inventory Page.Add Item To Cart    1
    Inventory Page.Go To Shopping Cart
    Cart Page.Verify Cart Page Loaded
    Cart Page.Verify Cart Contents    1
    Cart Page.Remove Item From Cart    1
    Cart Page.Verify Cart Contents    0

Continue Shopping From Cart
    [Documentation]    Verify continue shopping button functionality
    Inventory Page.Verify Inventory Page Loaded
    Inventory Page.Go To Shopping Cart
    Cart Page.Verify Cart Page Loaded
    Cart Page.Continue Shopping
    Inventory Page.Verify Inventory Page Loaded

Add Remove Add Same Product
    [Documentation]    Verify adding, removing, and re-adding same product
    Inventory Page.Verify Inventory Page Loaded
    ${item_name}=    Inventory Page.Get Item Name    1
    ${item_price}=    Inventory Page.Get Item Price    1
    
    # Add product to cart
    Inventory Page.Add Item To Cart    1
    Inventory Page.Verify Shopping Cart Badge    1
    
    # Remove product from cart
    Inventory Page.Remove Item From Cart    1
    Inventory Page.Verify Shopping Cart Badge    0
    
    # Add the same product again
    Inventory Page.Add Item To Cart    1
    Inventory Page.Verify Shopping Cart Badge    1
    
    # Verify in cart
    Inventory Page.Go To Shopping Cart
    Cart Page.Verify Cart Page Loaded
    Cart Page.Verify Cart Contents    1
    Cart Page.Verify Cart Item Details    1    ${item_name}    ${item_price}