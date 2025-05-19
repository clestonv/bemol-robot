*** Settings ***
Documentation    Arquivo contendo as principais Keywords do Projeto
Library    RequestsLibrary
Library    AppiumLibrary
Library    OperatingSystem
Library    String

*** Variables ***
#${base_URL}    https://develop.qacoders-academy.com.br/api
${base_URL}       https://invictus.qacoders.dev.br/api
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
    RETURN    ${resposta}

Cadastrar Usuários
    [Arguments]    ${token}
    
    ${letra_maiúscula}    Generate Random String    1    [UPPER]
    ${letras_aleatórias}    Generate Random String    5    [LOWER]
    
    ${primeiro_nome}    Set Variable    Marcos
    ${segundo_nome}    Set Variable     ${letra_maiúscula}${letras_aleatórias}

    ${nome_completo}    Set Variable    ${primeiro_nome} ${segundo_nome}

    ${body}    Create Dictionary
    ...    fullName=${nome_completo}
    ...    mail=meuemail@mail.com
    ...    accessProfile=ADMIN
    ...    cpf=44455518746
    ...    password=1234@Test
    ...    confirmPassword=1234@Test
    
    ${headers}    Create Dictionary
    ...    accept=application/json
    ...    Content-Type=application/json
    ...    Authorization=${token}

    #Criar Sessao

    ${reposta}    POST On Session
    ...    alias=bemol
    ...    expected_status=201
    ...    url=/user/token=${token}
    ...    json=${body}
    ...    headers=${headers}
    
    RETURN    ${resposta}

# UTEIS
Validar Mensagem Login
    [Arguments]    ${mensagem_esperada}    ${mensagem_resposta}
    Should Be Equal    first=${mensagem_esperada}    second=${mensagem_resposta}

