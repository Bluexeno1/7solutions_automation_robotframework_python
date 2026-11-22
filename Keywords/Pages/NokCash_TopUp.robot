*** Settings ***
Documentation    Page object: NokCash top-up page.
Resource         ../../Resources/Imports/Imports.resource


*** Keywords ***
Wait Until TopUp Page Is Loaded
    ${marker}=    Get Locator    nokcash_topup    page_marker
    ${input}=     Get Locator    nokcash_topup    amount_input
    ${timeout}=   Get Config     timeout
    Wait Until Element Is Visible    ${marker}    ${timeout}
    Wait Until Element Is Visible    ${input}     ${timeout}

Enter Amount
    [Arguments]    ${amount}
    ${input}=    Get Locator    nokcash_topup    amount_input
    Wait Until Element Is Visible    ${input}
    Clear Element Text    ${input}
    Run Keyword If    '${amount}' != ''    Input Text    ${input}    ${amount}

Select Preset Amount By Index
    [Documentation]    Clicks the preset button at the 0-based index and returns its numeric value.
    [Arguments]    ${index}
    ${presets}=    Get Locator    nokcash_topup    preset_amount_buttons
    Wait Until Element Is Visible    ${presets}
    ${buttons}=    Get WebElements    ${presets}
    ${count}=      Get Length    ${buttons}
    Should Be True    ${count} > ${index}    Only ${count} preset button(s) found, cannot pick index ${index}
    ${text}=       Get Text    ${buttons}[${index}]
    ${value}=      Parse Amount    ${text}
    Click Element    ${buttons}[${index}]
    RETURN    ${value}

Click Continue
    ${button}=    Get Locator    nokcash_topup    continue_button
    Wait Until Element Is Visible    ${button}
    Click Element    ${button}

Try Click Continue
    [Documentation]    Used by negative tests: the button may be disabled, which is also a valid way to block the user.
    ${button}=    Get Locator    nokcash_topup    continue_button
    Run Keyword And Ignore Error    Click Element    ${button}

Amount Error Should Be Visible
    ${error}=    Get Locator    nokcash_topup    error_message
    ${timeout}=  Get Config     short_timeout
    Wait Until Element Is Visible    ${error}    ${timeout}    Expected a validation message but none was shown
