*** Settings ***
Documentation     Automated checks for the NokCash top-up flow.
Resource          ../resources/common.resource
Resource          ../resources/pages/HomePage.resource
Resource          ../resources/pages/TopUpPage.resource
Resource          ../resources/pages/PaymentPage.resource
Resource          ../config/testdata.robot
Test Setup        Open NokCash Website
Test Teardown     Close NokCash Browser

*** Test Cases ***
NC-002 NokCash banner opens top-up page
    [Documentation]    Verify that the NokCash homepage banner navigates to the top-up page.
    Click NokCash Banner
    Top-up Page Should Be Open

NC-006 A valid top-up amount can be entered
    [Documentation]    Verify that a valid top-up amount is accepted and the user can continue.
    Click NokCash Banner
    Top-up Page Should Be Open
    Enter Valid Top-up Amount    ${VALID_TOPUP_AMOUNT}
    Continue To Payment

NC-015 Payment order summary shows selected top-up amount
    [Documentation]    Verify that the amount selected on the top-up page is shown on the payment page.
    Click NokCash Banner
    Top-up Page Should Be Open
    Enter Valid Top-up Amount    ${VALID_TOPUP_AMOUNT}
    Continue To Payment
    Payment Page Should Show Selected Amount    ${VALID_TOPUP_AMOUNT}
