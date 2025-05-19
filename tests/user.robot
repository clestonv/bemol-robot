*** Settings ***
Documentation    Suite Testes de Usuários
Resource    ../resources/common.resource

*** Test Cases ***
CT001 - Listar Usuarios com Sucesso
    ${token}    Pegar Token
    ${resposta}    Get Users    ${token}
    Status Should Be    expected_status=200    response=${resposta}

CT002 - Não deve listar usuário sem o uso de Token
    ${resposta}    Get Users    ${fake_token}
    Validar Mensagem Login    mensagem_esperada=Failed to authenticate token.    mensagem_resposta=${resposta.json()["errors"][0]}
    Status Should Be    expected_status=403    response=${resposta}

CT003 - Validar Contagem de Usúarios com Sucesso
    ${token}    Pegar Token
    
    # Fazer a contagem inicial
    ${resposta}    Count Users    ${token}
    ${count_atual}    Set variable    ${resposta.json()['count']}

    # Fazer um novo cadastro
    ${resposta}    Cadastrar Usuários    ${token}
    
    #Verificar a nova contagem
    ${resposta}    Count Users    ${token}
    ${count_novo}    Set variable    ${resposta.json()['count']}

    ${valor_esperado}    Evaluate    ${count_atual}+1

    #Exemplo de validações
    Status Should Be    expected_status=200    response=${resposta}
    Should Be True    ${resposta.json()['count']} > 0
    Should Not Be Equal As Numbers    ${count_atual}    ${count_novo}    # validar que os números são diferentes
    Should Be Equal    ${valor_esperado}   ${count_novo}    # Atenção: se outro teste que mexa nesse endpoint estiver rodando em paralelo, essa validação pode falhar

CT004 - Validar Contagem de Usuários sem Token
    ${resposta}    Count Users    ${fake_token}
    Log To Console    ${resposta.json()}
    Status Should Be    expected_status=403    response=${resposta}

    # Should Not Be Empty    ${resposta.json()["count"]}

   