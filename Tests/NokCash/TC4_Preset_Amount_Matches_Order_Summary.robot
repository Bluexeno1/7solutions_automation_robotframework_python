*** Settings ***
Documentation    Order summary: the amount on the payment page equals the preset amount selected.
Resource         ../../Keywords/Features/Homepage_Features.robot
Resource         ../../Keywords/Features/NokCash_Features.robot
Suite Setup      Launch Browser And Open Homepage
Suite Teardown   Close Browser Session
Test Setup       Open NokCash TopUp Page From Homepage
Force Tags       nokcash    order-summary    smoke    NC-D


*** Test Cases ***
TC4 Preset Amount Matches Order Summary
    [Documentation]    Expected: summary amount equals the preset value. The test stops at the payment page and does not pay.
    ${index}=     Get Test Data    amounts    preset_index
    ${amount}=    Select Preset Amount By Index    ${index}
    Click Continue
    Verify Order Summary Amount    ${amount}
