#!/bin/bash

clear

SENHA_ROOT="root"

echo "Mostra como é possível usar o comando 'select ... for update' do MySQL para criar um lock"
echo "e assim impedir que outro usuário (em outra transação) consiga fazer alterações"
echo "em um registro enquanto as alterações do primeiro usuário não forem confirmadas com o comando commit"
echo ""
echo "Para testar este exemplo, abra dois terminais e execute o script em cada um."
echo "Você verá que o segundo fica parado a espera do update no primeiro ser confirmado (commit)."
echo ""
echo "CERTIFIQUE-SE DE INSERIR A SENHA DO USUÁRIO ROOT DO MYSQL DENTRO DESTE SCRIPT."
echo ""
echo ""

#Cria um arquivo SQL na pasta temporária, contendo os comandos a serem executados no banco
echo "create database if not exists concorrencia;
use concorrencia;

# Cria a tabela se ela não existir e insere um registro nela.
create table if not exists cidade as select 1 as id, 'Palmas                                            ' as nome;

select '# Tentando selecionar dados (pode demorar por conta de lock em outra operação paralela)' as '';

# Locks só funcionam dentro de transações
start transaction;

# Seleciona o registro da cidade 1, criando um lock para evitar o acesso
# enquanto a transação não for finalizada.
# Como vamos alterar o registro logo abaixo, o lock impede o acesso ao registro 
# neste meio tempo.
select * from cidade where id = 1 for update;

\! echo ''
\! echo '# Alterando registro e aguardando alguns segundos para conseguirmos perceber o lock.'
\! echo '# Neste intervalo, execute o script em outro terminal'
\! echo '# e verá que ele não consegue nem sequer obter os dados do registro usando o primeiro select.'
\! echo ''

# Altera o nome da cidade para um valor aleatório (aguardando 10 segundos para concluir o update)
update cidade set nome = concat('Aleatório ', rand()) where id = 1 and sleep(10) >= 0;

# Confirma as alterações e libera o lock.
# Se foi o script foi aberto em outro terminal,
# a partir deste momento a outra instância do script terá acesso
# ao registro que estava bloqueado.
commit;

# Exibe os dados depois da confirmação das alterações acima.
# Se colocarmos um sleep antes deste select, poderemos inclusive
# ver alterações feitas por outros usuários (outras instâncias deste script).
select * from cidade;
" > /tmp/script.sql

# Executa os comandos do arquivo SQL criado acima
mysql -u root -p$SENHA_ROOT < /tmp/script.sql
