*** Settings ***
Documentation     Test suite for login functionality
Resource          ../resources/common.resource
Test Setup        Setup Browser
Test Teardown     Teardown Browser
Test Tags         login

*** Test Cases ***
Valid Login With Standard User
    [Documentation]    Verify login functionality with standard user
    Login Page.Verify Login Page Loaded
    Login Page.Login With Valid Credentials    ${STANDARD_USER}    ${STANDARD_USER_PASSWORD}
    Inventory Page.Verify Inventory Page Loaded

Invalid Login With Wrong Password
    [Documentation]    Verify error message when login with wrong password
    Login Page.Verify Login Page Loaded
    Login Page.Login With Invalid Credentials    ${STANDARD_USER}    invalid_password
    Login Page.Verify Error Message Text    Epic sadface: Username and password do not match any user in this service

Locked Out User Login
    [Documentation]    Verify error message when logging in with locked out user
    Login Page.Verify Login Page Loaded
    Login Page.Login With Invalid Credentials    ${LOCKED_OUT_USER}    ${LOCKED_OUT_USER_PASSWORD}
    Login Page.Verify Error Message Text    Epic sadface: Sorry, this user has been locked out.

Login Without Username
    [Documentation]    Verify error message when login without username
    Login Page.Verify Login Page Loaded
    Login Page.Login With Invalid Credentials    ${EMPTY}    ${STANDARD_USER_PASSWORD}
    Login Page.Verify Error Message Text    Epic sadface: Username is required

Login Without Password
    [Documentation]    Verify error message when login without password
    Login Page.Verify Login Page Loaded
    Login Page.Login With Invalid Credentials    ${STANDARD_USER}    ${EMPTY}
    Login Page.Verify Error Message Text    Epic sadface: Password is required

Performance Glitch User Login
    [Documentation]    Verify login functionality with performance glitch user
    Login Page.Verify Login Page Loaded
    Login Page.Login With Valid Credentials    ${PERFORMANCE_GLITCH_USER}    ${PERFORMANCE_GLITCH_USER_PASSWORD}
    Inventory Page.Verify Inventory Page Loaded

Logout Functionality
    [Documentation]    Verify logout functionality
    Login Page.Verify Login Page Loaded
    Login Page.Login With Valid Credentials    ${STANDARD_USER}    ${STANDARD_USER_PASSWORD}
    Inventory Page.Verify Inventory Page Loaded
    Inventory Page.Logout
    Login Page.Verify Login Page Loaded