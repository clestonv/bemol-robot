*** Settings ***
Documentation    Arquivo contendo as principais Keywords do Projeto
Library    RequestsLibrary
# Library    AppiumLibrary
Library    OperatingSystem
Library    String
Library    Collections

*** Variables ***
${base_URL}       https://api-automacao.qacoders.dev.br/api
#${base_URL}       https://invictus.qacoders.dev.br/api
${email_admin}    sysadmin@qacoders.com
${senha_admin}    1234@Test
${fake_token}     f90890f8as908f90as8fasdjfklasdjfkljasdlkfjaskljfklas

*** Keywords ***
Criar Sessao
    [Documentation]    Criar sessão inicial para ser reutilizada nas requests
    ${headers}    Create Dictionary    accept=application/json    Content-Type=application/json
    Create Session    alias=bemol    url=${base_URL}    headers=${headers}    verify=true
    RETURN    ${headers}

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

    ${cpf}    Generate Random String    11    [NUMBERS]

    ${primeiro_nome_email}   Convert To Lower Case    ${primeiro_nome}
    ${segundo_nome_email}   Convert To Lower Case    ${segundo_nome}

    ${body}    Create Dictionary
    ...    fullName=${nome_completo}
    ...    mail=${primeiro_nome_email}${segundo_nome_email}_${cpf}@mail.com
    ...    accessProfile=ADMIN
    ...    cpf=${cpf}
    ...    password=1234@Test
    ...    confirmPassword=1234@Test

    ${headers}    Create Dictionary
    ...    accept=application/json
    ...    Content-Type=application/json
    ...    Authorization=${token}

    ${resposta}    POST On Session
    ...    alias=bemol
    ...    expected_status=201
    ...    url=/user
    ...    json=${body}
    ...    headers=${headers}
    
    RETURN    ${resposta}

Pesquisar Usuário por ID
    [Arguments]    ${token}    ${id}

    ${headers}    Criar Sessao

    Set To Dictionary    ${headers}
    ...    Authorization=${token}

    ${resposta}   GET On Session
    ...    alias=bemol
    ...    expected_status=200
    ...    url=/user/${id}
    ...    headers=${headers}

    RETURN    ${resposta}

Atualizar Dados do Usuário
    [Arguments]    ${token}    ${id}    ${dados}

    ${headers}    Criar Sessao

    Set To Dictionary    ${headers}
    ...    Authorization=${token}
    
    ${resposta}    PUT On Session
    ...    alias=bemol
    ...    expected_status=200
    ...    url=/user/${id}
    ...    headers=${headers}
    ...    json=${dados}
    
    RETURN    ${resposta}

Excluir Usuário
    [Arguments]    ${token}    ${id}

    ${headers}    Criar Sessao

    Set To Dictionary    ${headers}
    ...    Authorization=${token}
    
    ${resposta}    DELETE On Session
    ...    alias=bemol
    ...    expected_status=200
    ...    url=/user/${id}
    ...    headers=${headers}
    
    RETURN    ${resposta}

# UTEIS
Validar Mensagem Login
    [Arguments]    ${mensagem_esperada}    ${mensagem_resposta}
    Should Be Equal    first=${mensagem_esperada}    second=${mensagem_resposta}

