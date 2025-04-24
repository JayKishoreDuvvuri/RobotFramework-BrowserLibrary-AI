*** Settings ***
Documentation     Common resources and keywords for all test suites
Library           Browser
Resource          pages/login_page.resource
Resource          pages/inventory_page.resource
Resource          pages/cart_page.resource
Resource          pages/checkout_page.resource
Resource          variables/users.resource

*** Variables ***
${BROWSER}        chromium
${HEADLESS}       True
${TIMEOUT}        10s
${BASE_URL}       https://www.saucedemo.com
${SCREENSHOT_DIR}    ${OUTPUTDIR}/screenshots

*** Keywords ***
Setup Browser
    New Browser    browser=${BROWSER}    headless=${HEADLESS}
    New Context    viewport={'width': 1280, 'height': 720}
    New Page       ${BASE_URL}
    
Teardown Browser
    Take Screenshot
    Close Browser

Take Screenshot On Failure
    [Arguments]    ${test_name}
    ${screenshot_path}=    Set Variable    ${SCREENSHOT_DIR}/${test_name}.png
    Take Screenshot    filename=${screenshot_path}

Wait Until Element Is Visible With Timeout
    [Arguments]    ${locator}    ${timeout}=${TIMEOUT}
    Wait For Elements State    ${locator}    visible    ${timeout}

Wait Until Element Is Enabled With Timeout
    [Arguments]    ${locator}    ${timeout}=${TIMEOUT}
    Wait For Elements State    ${locator}    enabled    ${timeout}

Wait And Click
    [Arguments]    ${locator}
    Wait Until Element Is Visible With Timeout    ${locator}
    Wait Until Element Is Enabled With Timeout    ${locator}
    Click    ${locator}

Wait And Type
    [Arguments]    ${locator}    ${text}
    Wait Until Element Is Visible With Timeout    ${locator}
    Wait Until Element Is Enabled With Timeout    ${locator}
    Fill Text    ${locator}    ${text}

Verify Element Contains Text
    [Arguments]    ${locator}    ${expected_text}
    ${actual_text}=    Get Text    ${locator}
    Should Contain    ${actual_text}    ${expected_text}
    
Verify Element Text
    [Arguments]    ${locator}    ${expected_text}
    ${actual_text}=    Get Text    ${locator}
    Should Be Equal As Strings    ${actual_text}    ${expected_text}

Verify Element Is Visible
    [Arguments]    ${locator}
    Wait For Elements State    ${locator}    visible    ${TIMEOUT}

Verify Element Is Not Visible
    [Arguments]    ${locator}
    Wait For Elements State    ${locator}    hidden    ${TIMEOUT}

Verify Element Count
    [Arguments]    ${locator}    ${expected_count}
    ${elements}=    Get Elements    ${locator}
    ${actual_count}=    Get Length    ${elements}
    Should Be Equal As Integers    ${actual_count}    ${expected_count}

Verify Page Title
    [Arguments]    ${expected_title}
    ${title}=    Get Title
    Should Be Equal As Strings    ${title}    ${expected_title}

Verify Current URL
    [Arguments]    ${expected_url_part}
    ${url}=    Get URL
    Should Contain    ${url}    ${expected_url_part}