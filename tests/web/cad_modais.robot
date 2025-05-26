*** Settings ***
Resource    ../../resources/common.resource

*** Variables ***
${btn_login}      button[id=login]
${input_email}    //*[@id="email"]
${input_senha}    //*[@id="password"]
${form_login}     /html/body/main/form
${btn_logout}    nav > button
${login_wrong}    div[role=alert]

*** Test Cases ***
CT001 - Validar exibição 