*** Settings ***
Documentation    Arquivo contendo as principais Keywords do Projeto
Library    RequestsLibrary
Library    AppiumLibrary

*** Variables ***
# ${base_URL}    https://develop.qacoders-academy.com.br/api/
${base_URL}       https://invictus.qacoders.dev.br/api/
${email_admin}    sysadmin@qacoders.com
${senha_admin}    1234@Test
${fake_token}     f90890f8as908f90as8fasdjfklasdjfkljasdlkfjaskljfklas

*** Keywords ***
Criar Sessao
    [Documentation]    Criar sessão inicial para ser reutilizada nas requests
    ${headers}    Create Dictionary    accept=application/json    Content-Type=application/json
    Create Session    alias=bemol    url=${base_URL}    headers=${headers}    verify=true

Pegar Token
    [Documentation]    Request usada para pegar o token Admin
    ${body}    Create Dictionary    
    ...    mail=${email_admin}    
    ...    password=${senha_admin}
    Criar Sessao
    ${resposta}    POST On Session    alias=bemol    expected_status=any    url=/login    json=${body}
    RETURN    ${resposta.json()["token"]}

Realizar Login
    [Arguments]    ${login_email}    ${login_senha}
    ${body}    Create Dictionary    
    ...    mail=${login_email}
    ...    password=${login_senha}
    Criar Sessao
    ${resposta}    POST On Session    alias=bemol    expected_status=any    url=/login    json=${body}
    RETURN    ${resposta}

Get Users
    [Arguments]    ${token}
    ${resposta}    GET On Session    alias=bemol    expected_status=any    url=/user/?token=${token}
    RETURN    ${resposta}

Count Users
    [Arguments]    ${token}
    ${resposta}    GET On Session    alias=bemol    expected_status=any    url=/user/count/?token=${token}

# UTEIS
Validar Mensagem Login
    [Arguments]    ${mensagem_esperada}    ${mensagem_resposta}
    Should Be Equal    first=${mensagem_esperada}    second=${mensagem_resposta}

