*** Settings ***
Documentation    Page object: payment page / order summary.
Resource         ../../Resources/Imports/Imports.resource


*** Keywords ***
Wait Until Payment Page Is Loaded
    ${summary}=    Get Locator    payment    order_summary
    ${timeout}=    Get Config     timeout
    Wait Until Element Is Visible    ${summary}    ${timeout}

Payment Page Should Not Be Shown
    ${summary}=    Get Locator    payment    order_summary
    Page Should Not Contain Element    ${summary}

Get Summary Amount
    ${locator}=    Get Locator    payment    summary_amount
    ${text}=       Get Text       ${locator}
    ${value}=      Parse Amount   ${text}
    RETURN    ${value}

Get Summary Fee
    [Documentation]    Returns 0 if the page shows no fee line.
    ${locator}=    Get Locator    payment    summary_fee
    ${present}=    Run Keyword And Return Status    Page Should Contain Element    ${locator}
    IF    not ${present}
        RETURN    ${0}
    END
    ${text}=       Get Text       ${locator}
    ${value}=      Parse Amount   ${text}
    RETURN    ${value}

Get Summary Total
    ${locator}=    Get Locator    payment    summary_total
    ${text}=       Get Text       ${locator}
    ${value}=      Parse Amount   ${text}
    RETURN    ${value}
