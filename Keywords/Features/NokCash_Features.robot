*** Settings ***
Documentation    Business-level keywords for the top-up and payment flow.
Resource         ../../Resources/Imports/Imports.resource
Resource         ../Pages/NokCash_TopUp.robot
Resource         ../Pages/Payment.robot


*** Keywords ***
Submit Amount From TopUp Page
    [Arguments]    ${amount}
    Enter Amount    ${amount}
    Click Continue

Verify Amount Is Rejected
    [Documentation]    Negative check: validation message shown (or button disabled) AND the user never reaches the payment page.
    [Arguments]    ${amount}
    Enter Amount    ${amount}
    Try Click Continue
    Amount Error Should Be Visible
    Payment Page Should Not Be Shown

Verify Order Summary Amount
    [Arguments]    ${expected_amount}
    Wait Until Payment Page Is Loaded
    ${actual}=    Get Summary Amount
    Amounts Should Be Equal    ${actual}    ${expected_amount}    Order summary amount ${actual} != selected amount ${expected_amount}

Verify Order Summary Total
    [Documentation]    Total payable must equal top-up amount + displayed fee, and the fee must match the configured fee.
    [Arguments]    ${expected_amount}
    ${fee}=         Get Summary Fee
    ${total}=       Get Summary Total
    ${config_fee}=  Get Test Data    amount_rules    fee_thb
    ${expected}=    Calculate Total    ${expected_amount}    ${fee}
    Amounts Should Be Equal    ${total}    ${expected}    Total ${total} != amount ${expected_amount} + fee ${fee}
    Amounts Should Be Equal    ${fee}      ${config_fee}  Fee on page ${fee} differs from expected fee ${config_fee}
