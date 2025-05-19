*** Settings ***
Documentation    Suite Testes de Usuários
Resource    ../resources/common.resource

*** Test Cases ***
CT001 - Listar Usuários com Sucesso
    ${token}    Pegar Token
    ${resposta}    Get Users    ${token}
    Status Should Be    expected_status=200    response=${resposta}

CT002 - Não Deve Listar Usuário Sem o Uso de Token
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

CT005 - Pesquisar Usuário por ID
    ${token}    Pegar Token

    # Fazer cadastro de novo usuário
    ${resposta}    Cadastrar Usuários    ${token}
    ${id_usuario}    Set Variable    ${resposta.json()['user']['_id']}
    ${nome_usuario}    Set Variable    ${resposta.json()['user']['fullName']}
    ${email_usuario}    Set Variable    ${resposta.json()['user']['mail']}
    ${cpf_usuario}    Set Variable    ${resposta.json()['user']['cpf']}

    # Pesquisar o usuário pelo ID
    ${resposta}    Pesquisar Usuário por ID    ${token}   ${id_usuario}
    Log    ${resposta.json()}

    #Validações
    Status Should Be    200    response=${resposta}
    Should Be Equal    ${resposta.json()['_id']}    ${id_usuario}
    Should Be Equal    ${resposta.json()['fullName']}    ${nome_usuario}
    Should Be Equal    ${resposta.json()['mail']}    ${email_usuario} 
    Should Be Equal    ${resposta.json()['cpf']}    ${cpf_usuario}

CT006 - Atualizar Email do Usuário
    ${token}    Pegar Token
    
    # Fazer cadastro de novo usuário
    ${resposta}    Cadastrar Usuários    ${token}
    ${id_usuario}    Set Variable    ${resposta.json()['user']['_id']}
    ${nome_usuario}    Set Variable    ${resposta.json()['user']['fullName']}
    ${email_usuario}    Set Variable    ${resposta.json()['user']['mail']}
    ${cpf_usuario}    Set Variable    ${resposta.json()['user']['cpf']}

    # Fazer login com novo usuário
    ${resposta}    Realizar Login    ${email_usuario}    ${senha_admin}
    ${token_usuario}    Set Variable    ${resposta.json()['token']}

    ${novo_email}    Set Variable    novo_${cpf_usuario}@test.com

    ${dados}    Create Dictionary
    ...    fullName=${nome_usuario}
    ...    mail=${novo_email}

    # Atualizar Email do Usuário
    ${resposta_update}    Atualizar Dados do Usuário    ${token_usuario}    ${id_usuario}    ${dados}

    # Validações
    Status Should Be    expected_status=200    response=${resposta_update}

    ${usuario_atualizado}    Pesquisar Usuário por ID    ${token}    ${id_usuario}
    Should Be Equal    ${usuario_atualizado.json()['mail']}    ${novo_email}

CT007 - Atualizar Nome e Email do Usuário
    ${token}    Pegar Token
    
    # Fazer cadastro de novo usuário
    ${resposta}    Cadastrar Usuários    ${token}
    ${id_usuario}    Set Variable    ${resposta.json()['user']['_id']}
    ${nome_usuario}    Set Variable    ${resposta.json()['user']['fullName']}
    ${email_usuario}    Set Variable    ${resposta.json()['user']['mail']}
    ${cpf_usuario}    Set Variable    ${resposta.json()['user']['cpf']}

    # Fazer login com novo usuário
    ${resposta}    Realizar Login    ${email_usuario}    ${senha_admin}
    ${token_usuario}    Set Variable    ${resposta.json()['token']}

    ${caracteres_nome}    Generate Random String    5    [LOWER]

    ${novo_nome}    Set Variable    ${nome_usuario}${caracteres_nome}

    ${novo_email}    Set Variable    novo_${cpf_usuario}@test.com

    ${dados}    Create Dictionary
    ...    fullName=${novo_nome}
    ...    mail=${novo_email}

    # Atualizar Email do Usuário
    ${resposta_update}    Atualizar Dados do Usuário    ${token_usuario}    ${id_usuario}    ${dados}

    # Validações
    Status Should Be    expected_status=200    response=${resposta_update}

    ${usuario_atualizado}    Pesquisar Usuário por ID    ${token}    ${id_usuario}
    Should Be Equal    ${usuario_atualizado.json()['mail']}    ${novo_email}
    Should Be Equal    ${usuario_atualizado.json()['fullName']}    ${novo_nome}

CT008 - Deletar Usuário
    ${token}    Pegar Token
    
    # Fazer cadastro de novo usuário
    ${resposta}    Cadastrar Usuários    ${token}
    ${id_usuario}    Set Variable    ${resposta.json()['user']['_id']}

    # Deletar usuário
    ${resposta}    Excluir Usuário    ${token}    ${id_usuario}

    #Validação
    Status Should Be    expected_status=200    response=${resposta}
    Should Be Equal    ${resposta.json()['msg']}    Usuário deletado com sucesso!.

    



    


   