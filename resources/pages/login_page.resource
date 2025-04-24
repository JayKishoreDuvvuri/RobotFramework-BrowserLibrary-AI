*** Settings ***
Documentation     Keywords related to the login page
Library           Browser
Resource          ../common.resource

*** Variables ***
# Login page locators
${USERNAME_FIELD}        id=user-name
${PASSWORD_FIELD}        id=password
${LOGIN_BUTTON}          id=login-button
${ERROR_MESSAGE}         [data-test="error"]
${LOGIN_LOGO}            .login_logo

*** Keywords ***
Login With Valid Credentials
    [Arguments]    ${username}=${STANDARD_USER}    ${password}=${STANDARD_USER_PASSWORD}
    Login With Credentials    ${username}    ${password}
    Verify Login Success

Login With Invalid Credentials
    [Arguments]    ${username}    ${password}
    Login With Credentials    ${username}    ${password}
    Verify Error Message Is Displayed

Login With Credentials
    [Arguments]    ${username}    ${password}
    Wait And Type    ${USERNAME_FIELD}    ${username}
    Wait And Type    ${PASSWORD_FIELD}    ${password}
    Wait And Click    ${LOGIN_BUTTON}

Verify Login Success
    Verify Current URL    inventory.html

Verify Login Page Loaded
    Verify Element Is Visible    ${LOGIN_LOGO}
    Verify Element Is Visible    ${USERNAME_FIELD}
    Verify Element Is Visible    ${PASSWORD_FIELD}
    Verify Element Is Visible    ${LOGIN_BUTTON}

Verify Error Message Is Displayed
    Verify Element Is Visible    ${ERROR_MESSAGE}

Verify Error Message Text
    [Arguments]    ${expected_error}
    Verify Element Contains Text    ${ERROR_MESSAGE}    ${expected_error}