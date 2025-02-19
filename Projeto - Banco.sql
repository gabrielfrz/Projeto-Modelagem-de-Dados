--Criacao das Tabelas
CREATE TABLE Pessoa (
    CPF VARCHAR2(11) PRIMARY KEY,
    Email VARCHAR2(100),
    Data_Nascimento DATE,
    Nome VARCHAR2(100),
    Telefone VARCHAR2(15),
    CEP VARCHAR2(10),
    Complemento VARCHAR2(100),
    Numero VARCHAR2(10)
);

CREATE TABLE Cargo (
    ID NUMBER PRIMARY KEY,
    Nome VARCHAR2(100)
);

CREATE TABLE Funcionarios (
    ID NUMBER PRIMARY KEY,
    CPF VARCHAR2(11),
    Data_Admissao DATE,
    Data_Demissao DATE,
    Carga_Horaria NUMBER,
    ID_Cargo NUMBER,
    Banco VARCHAR2(100),
    Numero_Agencia VARCHAR2(100),
    Numero_Conta VARCHAR2(100),
    Tipo_Conta VARCHAR2(100),
    FOREIGN KEY (CPF) REFERENCES Pessoa(CPF),
    FOREIGN KEY (ID_Cargo) REFERENCES Cargo(ID)
);

CREATE TABLE Tipo_Exame (
    ID NUMBER PRIMARY KEY,
    Nome VARCHAR2(100)
);

CREATE TABLE Tipo_Atestado (
    ID NUMBER PRIMARY KEY,
    Nome VARCHAR2(100)
);

CREATE TABLE Cliente (
    ID NUMBER PRIMARY KEY,
    CPF VARCHAR2(11),
    FOREIGN KEY (CPF) REFERENCES Pessoa(CPF)
);

CREATE TABLE Agendamento (
    ID NUMBER PRIMARY KEY,
    Data DATE,
    Horario TIMESTAMP,
    ID_Cliente NUMBER,
    ID_Dentista NUMBER,
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID),
    FOREIGN KEY (ID_Dentista) REFERENCES Funcionarios(ID)
);

CREATE TABLE Pagamento (
    ID NUMBER PRIMARY KEY,
    Data DATE,
    Horario TIMESTAMP,
    Valor NUMBER,
    ID_Funcionario NUMBER,
    FOREIGN KEY (ID_Funcionario) REFERENCES Funcionarios(ID)
);

CREATE TABLE Material (
    ID NUMBER PRIMARY KEY,
    Nome VARCHAR2(100)
);

CREATE TABLE Estoque (
    ID NUMBER PRIMARY KEY,
    ID_Material NUMBER,
    Quantidade NUMBER,
    FOREIGN KEY (ID_Material) REFERENCES Material(ID)
);

CREATE TABLE Fornecedor (
    ID NUMBER PRIMARY KEY,
    Razao_Social VARCHAR2(100),
    CNPJ VARCHAR2(14)
);

CREATE TABLE Pedido (
    ID NUMBER PRIMARY KEY,
    ID_Fornecedor NUMBER,
    Data_Pedido DATE,
    Status VARCHAR2(50),
    FOREIGN KEY (ID_Fornecedor) REFERENCES Fornecedor(ID)
);

CREATE TABLE Pedido_Materiais (
    ID NUMBER PRIMARY KEY,
    ID_Materiais NUMBER,
    ID_Pedido NUMBER,
    Quantidade NUMBER,
    FOREIGN KEY (ID_Materiais) REFERENCES Material(ID),
    FOREIGN KEY (ID_Pedido) REFERENCES Pedido(ID)
);

CREATE TABLE Atendimento (
    ID NUMBER PRIMARY KEY,
    ID_Tp_Atendimento NUMBER,
    ID_Agendamento NUMBER,
    Pago CHAR(1),
    FOREIGN KEY (ID_Agendamento) REFERENCES Agendamento(ID)
);

CREATE TABLE Exames (
    ID NUMBER PRIMARY KEY,
    Data DATE,
    Resultado VARCHAR2(100),
    ID_TipoExame NUMBER,
    FOREIGN KEY (ID_TipoExame) REFERENCES Tipo_Exame(ID)
);

CREATE TABLE Atendimento_Exames (
    ID NUMBER PRIMARY KEY,
    ID_Exames NUMBER,
    ID_Atendimento NUMBER,
    FOREIGN KEY (ID_Exames) REFERENCES Exames(ID),
    FOREIGN KEY (ID_Atendimento) REFERENCES Atendimento(ID)
);

CREATE TABLE Atestado (
    ID NUMBER PRIMARY KEY,
    Data_Emissao DATE,
    Observacoes VARCHAR2(500),
    ID_Funcionario NUMBER,
    ID_Atendimento NUMBER,
    ID_Tp_Atestado NUMBER,
    FOREIGN KEY (ID_Funcionario) REFERENCES Funcionarios(ID),
    FOREIGN KEY (ID_Atendimento) REFERENCES Atendimento(ID),
    FOREIGN KEY (ID_Tp_Atestado) REFERENCES Tipo_Atestado(ID)
);

CREATE TABLE Funcionario_Atendimento (
    ID NUMBER PRIMARY KEY,
    ID_Atendimento NUMBER,
    ID_Funcionarios NUMBER,
    FOREIGN KEY (ID_Atendimento) REFERENCES Atendimento(ID),
    FOREIGN KEY (ID_Funcionarios) REFERENCES Funcionarios(ID)
);

CREATE TABLE Tipo_Atendimento (
    ID NUMBER PRIMARY KEY,
    Valor NUMBER,
    Nome VARCHAR2(100)
);

CREATE TABLE Uso_Materiais (
    ID NUMBER PRIMARY KEY,
    ID_Material NUMBER,
    ID_Tp_Atendimento NUMBER,
    Quantidade_Utilizada NUMBER,
    FOREIGN KEY (ID_Material) REFERENCES Material(ID),
    FOREIGN KEY (ID_Tp_Atendimento) REFERENCES Tipo_Atendimento(ID)
);

CREATE SEQUENCE sq_cargo;
CREATE SEQUENCE sq_funcionarios;
CREATE SEQUENCE sq_tipo_exame;
CREATE SEQUENCE sq_tipo_atestado;
CREATE SEQUENCE sq_cliente;
CREATE SEQUENCE sq_agendamento;
CREATE SEQUENCE sq_pagamento;
CREATE SEQUENCE sq_material;
CREATE SEQUENCE sq_estoque;
CREATE SEQUENCE sq_fornecedor;
CREATE SEQUENCE sq_pedido;
CREATE SEQUENCE sq_pedido_materiais;
CREATE SEQUENCE sq_atendimento;
CREATE SEQUENCE sq_exames;
CREATE SEQUENCE sq_atendimento_exames;
CREATE SEQUENCE sq_atestado;
CREATE SEQUENCE sq_funcionario_atendimento;
CREATE SEQUENCE sq_tipo_atendimento;
CREATE SEQUENCE sq_uso_materiais;



--Algumas alteracoes das tabelas


ALTER TABLE Atendimento
DROP (
    ID_TP_ATENDIMENTO 
);

ALTER TABLE Agendamento
ADD ID_TP_ATENDIMENTO INT;

ALTER TABLE Agendamento
ADD CONSTRAINT fk_tp_atendimento
FOREIGN KEY (ID_TP_ATENDIMENTO) REFERENCES TIPO_ATENDIMENTO(ID);

--Povoamento

--TIPO_EXAME
Insert into TIPO_EXAME (ID, NOME) values ('1', 'Raio-X');
Insert into TIPO_EXAME (ID, NOME) values ('2', 'Limpeza');

--TIPO_ATESTADO
Insert into TIPO_ATESTADO (ID, NOME) values ('1', 'Atestado Médico');
Insert into TIPO_ATESTADO (ID, NOME) values ('2', 'Atestado Odontológico');

--TIPO_ATENDIMENTO
Insert into TIPO_ATENDIMENTO (ID, VALOR, NOME) values ('1', '300', 'Consulta');
Insert into TIPO_ATENDIMENTO (ID, VALOR, NOME) values ('2', '150', 'Tratamento');
Insert into TIPO_ATENDIMENTO (ID, VALOR, NOME) values ('3', '900', 'limpeza super completa');

--MATERIAL
Insert into MATERIAL (ID, NOME) values ('1', 'Anestesia');
Insert into MATERIAL (ID, NOME) values ('2', 'Luvas');
Insert into MATERIAL (ID, NOME) values ('3', 'pasta');
Insert into MATERIAL (ID, NOME) values ('4', 'escova de dente');
Insert into MATERIAL (ID, NOME) values ('5', 'gel para o dente');

--USO_MATERIAIS
Insert into USO_MATERIAIS (ID, ID_MATERIAL, ID_TP_ATENDIMENTO, QUANTIDADE_UTILIZADA) values ('1', '1', '1', '2');
Insert into USO_MATERIAIS (ID, ID_MATERIAL, ID_TP_ATENDIMENTO, QUANTIDADE_UTILIZADA) values ('2', '2', '2', '5');
Insert into USO_MATERIAIS (ID, ID_MATERIAL, ID_TP_ATENDIMENTO, QUANTIDADE_UTILIZADA) values ('3', '3', '1', '7');
Insert into USO_MATERIAIS (ID, ID_MATERIAL, ID_TP_ATENDIMENTO, QUANTIDADE_UTILIZADA) values ('4', '4', '3', '2');
Insert into USO_MATERIAIS (ID, ID_MATERIAL, ID_TP_ATENDIMENTO, QUANTIDADE_UTILIZADA) values ('5', '5', '3', '3');

--PESSOA
Insert into PESSOA (CPF, EMAIL, DATA_NASCIMENTO, NOME, TELEFONE, CEP, COMPLEMENTO, NUMERO) values ('12345678901', 'joao.silva@example.com', to_date('15/06/85', 'DD/MM/RR'), 'João Silva', '11123456789', '01001-000', 'Apt 101', '200');
Insert into PESSOA (CPF, EMAIL, DATA_NASCIMENTO, NOME, TELEFONE, CEP, COMPLEMENTO, NUMERO) values ('23456789012', 'maria.oliveira@example.com', to_date('25/08/90', 'DD/MM/RR'), 'Maria Oliveira', '11987654321', '22041-001', 'Casa 2', '50');
Insert into PESSOA (CPF, EMAIL, DATA_NASCIMENTO, NOME, TELEFONE, CEP, COMPLEMENTO, NUMERO) values ('70123456789', 'ana.lima@email.com', to_date('10/02/15', 'DD/MM/RR'), 'Ana Lima', '11981234567', '12345600', 'Apto 202', '101');
Insert into PESSOA (CPF, EMAIL, DATA_NASCIMENTO, NOME, TELEFONE, CEP, COMPLEMENTO, NUMERO) values ('70234567890', 'marcelo.souza@email.com', to_date('15/06/55', 'DD/MM/RR'), 'Marcelo Souza', '21981234567', '12345700', 'Casa 1', '102');
Insert into PESSOA (CPF, EMAIL, DATA_NASCIMENTO, NOME, TELEFONE, CEP, COMPLEMENTO, NUMERO) values ('70345678901', 'beatriz.melo@email.com', to_date('30/09/05', 'DD/MM/RR'), 'Beatriz Melo', '31981234567', '12345800', 'Apto 303', '103');
Insert into PESSOA (CPF, EMAIL, DATA_NASCIMENTO, NOME, TELEFONE, CEP, COMPLEMENTO, NUMERO) values ('70456789012', 'julio.alves@email.com', to_date('25/12/82', 'DD/MM/RR'), 'Julio Alves', '41981234567', '12345900', 'Bloco A', '104');
Insert into PESSOA (CPF, EMAIL, DATA_NASCIMENTO, NOME, TELEFONE, CEP, COMPLEMENTO, NUMERO) values ('70567890123', 'fernanda.souza@email.com', to_date('18/08/98', 'DD/MM/RR'), 'Fernanda Souza', '51981234567', '12345000', 'Casa 3', '105');
Insert into PESSOA (CPF, EMAIL, DATA_NASCIMENTO, NOME, TELEFONE, CEP, COMPLEMENTO, NUMERO) values ('70678901234', 'maria.santos@email.com', to_date('12/05/48', 'DD/MM/RR'), 'Maria Santos', '61981234567', '12345100', 'Bloco B', '106');
Insert into PESSOA (CPF, EMAIL, DATA_NASCIMENTO, NOME, TELEFONE, CEP, COMPLEMENTO, NUMERO) values ('70789012345', 'pedro.lucas@email.com', to_date('04/11/12', 'DD/MM/RR'), 'Pedro Lucas', '71981234567', '12345200', 'Apto 404', '107');
Insert into PESSOA (CPF, EMAIL, DATA_NASCIMENTO, NOME, TELEFONE, CEP, COMPLEMENTO, NUMERO) values ('70890123456', 'sara.costa@email.com', to_date('22/03/01', 'DD/MM/RR'), 'Sara Costa', '81981234567', '12345300', 'Casa 5', '108');
Insert into PESSOA (CPF, EMAIL, DATA_NASCIMENTO, NOME, TELEFONE, CEP, COMPLEMENTO, NUMERO) values ('70901234567', 'tiago.martins@email.com', to_date('10/10/73', 'DD/MM/RR'), 'Tiago Martins', '91981234567', '12345400', 'Bloco C', '109');
Insert into PESSOA (CPF, EMAIL, DATA_NASCIMENTO, NOME, TELEFONE, CEP, COMPLEMENTO, NUMERO) values ('71012345678', 'elaine.carvalho@email.com', to_date('05/01/39', 'DD/MM/RR'), 'Elaine Carvalho', '10198123456', '12345500', 'Apto 505', '110');
Insert into PESSOA (CPF, EMAIL, DATA_NASCIMENTO, NOME, TELEFONE, CEP, COMPLEMENTO, NUMERO) values ('71123456789', 'carlos.oliveira@email.com', to_date('15/07/92', 'DD/MM/RR'), 'Carlos Oliveira', '11991234567', '12345670', 'Casa 8', '111');
Insert into PESSOA (CPF, EMAIL, DATA_NASCIMENTO, NOME, TELEFONE, CEP, COMPLEMENTO, NUMERO) values ('71234567890', 'mariana.silva@email.com', to_date('02/11/68', 'DD/MM/RR'), 'Mariana Silva', '21991234567', '12345680', 'Bloco D', '112');
Insert into PESSOA (CPF, EMAIL, DATA_NASCIMENTO, NOME, TELEFONE, CEP, COMPLEMENTO, NUMERO) values ('71345678901', 'joao.pereira@email.com', to_date('23/04/10', 'DD/MM/RR'), 'João Pereira', '31991234567', '12345690', 'Apto 606', '113');

--FORNECEDOR
Insert into FORNECEDOR (ID, RAZAO_SOCIAL, CNPJ) values ('1', 'Fornecedor A', '12345678000195');
Insert into FORNECEDOR (ID, RAZAO_SOCIAL, CNPJ) values ('2', 'Fornecedor B', '98765432000100');

--PEDIDO
Insert into PEDIDO (ID, ID_FORNECEDOR, DATA_PEDIDO, STATUS) values ('1', '1', to_date('30/10/24', 'DD/MM/RR'), 'Pendente');
Insert into PEDIDO (ID, ID_FORNECEDOR, DATA_PEDIDO, STATUS) values ('2', '2', to_date('31/10/24', 'DD/MM/RR'), 'Concluído');

--PEDIDO_MATERIAIS
Insert into PEDIDO_MATERIAIS (ID, ID_MATERIAIS, ID_PEDIDO, QUANTIDADE) values ('1', '1', '1', '50');
Insert into PEDIDO_MATERIAIS (ID, ID_MATERIAIS, ID_PEDIDO, QUANTIDADE) values ('2', '2', '2', '100');


--CARGO
Insert into CARGO (ID, NOME) values ('1', 'Dentista');
Insert into CARGO (ID, NOME) values ('2', 'Recepcionista');

--FUNCIONARIOS
Insert into FUNCIONARIOS (ID, CPF, DATA_ADMISSAO, DATA_DEMISSAO, CARGA_HORARIA, ID_CARGO, BANCO, NUMERO_AGENCIA, NUMERO_CONTA, TIPO_CONTA) values ('1', '71123456789', to_date('10/01/20', 'DD/MM/RR'), null, '40', '1', 'Banco do Brasil', '1234', '567890', 'Corrente');
Insert into FUNCIONARIOS (ID, CPF, DATA_ADMISSAO, DATA_DEMISSAO, CARGA_HORARIA, ID_CARGO, BANCO, NUMERO_AGENCIA, NUMERO_CONTA, TIPO_CONTA) values ('2', '71234567890', to_date('05/11/19', 'DD/MM/RR'), null, '36', '1', 'Caixa Econômica', '5678', '123456', 'Poupança');
Insert into FUNCIONARIOS (ID, CPF, DATA_ADMISSAO, DATA_DEMISSAO, CARGA_HORARIA, ID_CARGO, BANCO, NUMERO_AGENCIA, NUMERO_CONTA, TIPO_CONTA) values ('3', '71234567890', to_date('13/07/20', 'DD/MM/RR'), null, '45', '2', 'Itau', '1234', '567890', 'Corrente');


--PAGAMENTO
Insert into PAGAMENTO (ID, DATA, HORARIO, VALOR, ID_FUNCIONARIO) values ('1', to_date('05/11/24', 'DD/MM/RR'), to_timestamp('05/11/24 12:00:00,000000000', 'DD/MM/RR HH24:MI:SSXFF'), '200', '1');
Insert into PAGAMENTO (ID, DATA, HORARIO, VALOR, ID_FUNCIONARIO) values ('2', to_date('06/11/24', 'DD/MM/RR'), to_timestamp('06/11/24 13:00:00,000000000', 'DD/MM/RR HH24:MI:SSXFF'), '150', '1');
Insert into PAGAMENTO (ID, DATA, HORARIO, VALOR, ID_FUNCIONARIO) values ('3', to_date('03/11/24', 'DD/MM/RR'), to_timestamp('03/11/24 21:41:47,139000000', 'DD/MM/RR HH24:MI:SSXFF'), '100', '1');

--CLIENTE
Insert into CLIENTE (ID, CPF) values ('1', '12345678901');
Insert into CLIENTE (ID, CPF) values ('2', '23456789012');
Insert into CLIENTE (ID, CPF) values ('4', '70123456789');
Insert into CLIENTE (ID, CPF) values ('5', '70234567890');
Insert into CLIENTE (ID, CPF) values ('6', '70345678901');
Insert into CLIENTE (ID, CPF) values ('7', '70456789012');
Insert into CLIENTE (ID, CPF) values ('8', '70567890123');
Insert into CLIENTE (ID, CPF) values ('9', '70678901234');
Insert into CLIENTE (ID, CPF) values ('10', '70789012345');
Insert into CLIENTE (ID, CPF) values ('11', '70890123456');
Insert into CLIENTE (ID, CPF) values ('12', '70901234567');
Insert into CLIENTE (ID, CPF) values ('13', '71012345678');

--AGENDAMENTO
Insert into AGENDAMENTO (ID, DATA, HORARIO, ID_CLIENTE, ID_DENTISTA, ID_TP_ATENDIMENTO) values ('1', to_date('05/11/24', 'DD/MM/RR'), to_timestamp('05/11/24 10:00:00,000000000', 'DD/MM/RR HH24:MI:SSXFF'), '1', '1', '1');
Insert into AGENDAMENTO (ID, DATA, HORARIO, ID_CLIENTE, ID_DENTISTA, ID_TP_ATENDIMENTO) values ('2', to_date('06/11/24', 'DD/MM/RR'), to_timestamp('06/11/24 11:00:00,000000000', 'DD/MM/RR HH24:MI:SSXFF'), '2', '1', '2');
Insert into AGENDAMENTO (ID, DATA, HORARIO, ID_CLIENTE, ID_DENTISTA, ID_TP_ATENDIMENTO) values ('3', to_date('23/12/23', 'DD/MM/RR'), null, '7', '1', '3');
Insert into AGENDAMENTO (ID, DATA, HORARIO, ID_CLIENTE, ID_DENTISTA, ID_TP_ATENDIMENTO) values ('4', to_date('23/12/23', 'DD/MM/RR'), null, '2', '1', '3');
Insert into AGENDAMENTO (ID, DATA, HORARIO, ID_CLIENTE, ID_DENTISTA, ID_TP_ATENDIMENTO) values ('5', to_date('23/12/23', 'DD/MM/RR'), null, '1', '1', '3');
Insert into AGENDAMENTO (ID, DATA, HORARIO, ID_CLIENTE, ID_DENTISTA, ID_TP_ATENDIMENTO) values ('6', to_date('23/12/23', 'DD/MM/RR'), null, '1', '1', '3');

--ATENDIMENTO
Insert into ATENDIMENTO (ID, ID_AGENDAMENTO, PAGO) values ('1', '1', 'S');
Insert into ATENDIMENTO (ID, ID_AGENDAMENTO, PAGO) values ('2', '2', 'N');
Insert into ATENDIMENTO (ID, ID_AGENDAMENTO, PAGO) values ('3', '3', 'Y');
Insert into ATENDIMENTO (ID, ID_AGENDAMENTO, PAGO) values ('4', '4', 'N');

--FUNCIONARIO_ATENDIMENTO
Insert into FUNCIONARIO_ATENDIMENTO (ID, ID_ATENDIMENTO, ID_FUNCIONARIOS) values ('1', '1', '1');
Insert into FUNCIONARIO_ATENDIMENTO (ID, ID_ATENDIMENTO, ID_FUNCIONARIOS) values ('2', '2', '1');

--EXAMES
Insert into EXAMES (ID, DATA, RESULTADO, ID_TIPOEXAME) values ('1', to_date('05/11/24', 'DD/MM/RR'), 'Normal', '1');
Insert into EXAMES (ID, DATA, RESULTADO, ID_TIPOEXAME) values ('2', to_date('06/11/24', 'DD/MM/RR'), 'Normal', '2');

--ESTOQUE
Insert into ESTOQUE (ID, ID_MATERIAL, QUANTIDADE) values ('1', '1', '100');
Insert into ESTOQUE (ID, ID_MATERIAL, QUANTIDADE) values ('2', '2', '200');
Insert into ESTOQUE (ID, ID_MATERIAL, QUANTIDADE) values ('3', '3', '4');
Insert into ESTOQUE (ID, ID_MATERIAL, QUANTIDADE) values ('4', '4', '6');
Insert into ESTOQUE (ID, ID_MATERIAL, QUANTIDADE) values ('5', '5', '4');

--ATESTADO
Insert into ATESTADO (ID, DATA_EMISSAO, OBSERVACOES, ID_FUNCIONARIO, ID_ATENDIMENTO, ID_TP_ATESTADO) values ('1', to_date('05/11/24', 'DD/MM/RR'), 'Paciente necessita de repouso', '1', '1', '1');

--ATENDIMENTO_EXAMES
Insert into ATENDIMENTO_EXAMES (ID, ID_EXAMES, ID_ATENDIMENTO) values ('1', '1', '1');
Insert into ATENDIMENTO_EXAMES (ID, ID_EXAMES, ID_ATENDIMENTO) values ('2', '2', '2');


--Consultas 

--fatzzx
select ta.nome as ATENDIMENTO, m.nome as MATERIAL, 
um.quantidade_utilizada as QUANTIDADE_UTILIZADA, 
e.quantidade as QUANTIDADE_NO_ESTOQUE  
from uso_materiais um 
left join tipo_atendimento ta 
on um.id_tp_atendimento = ta.id join 
material m on m.id = um.id_material join 
agendamento ag on ag.id_tp_atendimento = ta.id join
estoque e on e.id_material = m.id
where e.quantidade < um.quantidade_utilizada and ag.data > '04/11/2024'
and ag.data < '06/12/2024';

--nika
SELECT
	pe.nome AS nome_dentista,
	p.nome AS tipo_procedimento,
	COUNT(ag.id) AS quantidade_atendimentos,
	SUM(p.valor) AS faturamento_total
FROM
	funcionarios d
JOIN 
    pessoa pe on pe.cpf = d.cpf
JOIN
    cargo c on d.id_cargo = c.id
JOIN
	Agendamento ag ON d.id = ag.id_dentista
JOIN
	Tipo_Atendimento p ON ag.id_tp_atendimento = p.id
JOIN
    atendimento at on at.id_agendamento = ag.id
WHERE
	p.nome = 'Consulta'
	AND ag.data BETWEEN TO_DATE('04/11/2024', 'DD-MM-YYYY') AND TO_DATE('06/12/2024', 'DD-MM-YYYY')
    and c.id = 1
GROUP BY
	pe.nome, p.nome
ORDER BY
	pe.nome, p.nome;

--aragao
select ta.nome as TIPO_DE_ATENDIMENTO,m.nome as NOME_MATERIAL, sum(um.quantidade_utilizada) as QUANTIDADE_TOTAL
from uso_materiais um 
left join tipo_atendimento ta 
on um.id_tp_atendimento = ta.id join 
material m on m.id = um.id_material join 
agendamento ag on ag.id_tp_atendimento = ta.id join
atendimento at on at.id_agendamento = ag.id
where ag.data > '04/11/2024'
and ag.data < '06/12/2024'
group by m.nome, ta.nome;

--diogo
select p2.nome as NOME_DENTISTA, min(p1.data_nascimento) as MAIOR_IDADE_ATENDIDA, max(p1.data_nascimento) as MENOR_IDADE_ATENDIDA
from agendamento ag join 
atendimento at on at.id_agendamento = ag.id join 
Funcionarios d on d.id = ag.id_dentista join
Cliente c on c.id = ag.id_cliente join 
pessoa p1 on p1.cpf = c.cpf join 
pessoa p2 on p2.cpf = d.cpf
group by p2.nome
order by p2.nome asc;


--Objetos de programacao

--p1
CREATE OR REPLACE TRIGGER ATENDIMENTO_CONCLUIDO 
BEFORE INSERT ON atendimento 
FOR EACH ROW
DECLARE
    CURSOR materia_cursor IS
        SELECT um.id_material, um.quantidade_utilizada, e.quantidade 
        FROM uso_materiais um 
        JOIN tipo_atendimento ta ON ta.id = um.id_tp_atendimento 
        JOIN agendamento ag ON ag.id_tp_atendimento = ta.id 
        JOIN material m ON m.id = um.id_material 
        JOIN estoque e ON e.id_material = m.id     
        WHERE ag.id = :new.id_agendamento;

    materia_record materia_cursor%ROWTYPE; 
BEGIN
    OPEN materia_cursor;
    LOOP
        FETCH materia_cursor INTO materia_record;
        EXIT WHEN materia_cursor%NOTFOUND; 

        IF materia_record.quantidade_utilizada > materia_record.quantidade THEN   
            RAISE_APPLICATION_ERROR(-20001, 'Quantidade a retirar maior que a do estoque');
        ELSE
            UPDATE estoque 
            SET quantidade = quantidade - materia_record.quantidade_utilizada 
            WHERE id_material = materia_record.id_material;
        END IF; 
    END LOOP;

    CLOSE materia_cursor; 
END;

--p2
CREATE OR REPLACE TRIGGER verifica_pagamento_pendente
BEFORE INSERT ON Agendamento
FOR EACH ROW
DECLARE

pagamentos_pendentes integer;
email_cliente VARCHAR2(100);


begin 

select count(*)
into pagamentos_pendentes
from atendimento 
join agendamento on atendimento.id_agendamento = agendamento.id 
where agendamento.id_cliente = :new.id_cliente
and atendimento.pago = 'N'; 


if pagamentos_pendentes >= 2 then
select pessoa.email
into email_cliente
from cliente 
join pessoa on cliente.cpf = pessoa.cpf
where cliente.id = :new.id_cliente;

DBMS_OUTPUT.PUT_LINE('Atenção: E-mail de lembrete enviado para: ' || email_cliente);
DBMS_OUTPUT.PUT_LINE(': Favor regularizar os pagamentos pendentes para continuar com novos agendamentos.');


RAISE_APPLICATION_ERROR(-20001, 'Erro: O cliente possui dois atendimentos anteriores com pagamentos pendentes. Agendamento bloqueado.');
end if;

EXCEPTION
    
    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('Erro inesperado: ' || SQLERRM);
END trg_verificar_pagamento_pendente;

--p3
CREATE OR REPLACE PROCEDURE Registrar_Pagamento(
    p_ID_Atendimento IN NUMBER,
    p_Valor IN NUMBER
) AS
    v_Existe_Atendimento NUMBER;
    v_Novo_ID NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_Existe_Atendimento
    FROM Atendimento
    WHERE ID = p_ID_Atendimento;

    IF v_Existe_Atendimento = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Atendimento não encontrado.');
    ELSE
        SELECT NVL(MAX(ID), 0) + 1
        INTO v_Novo_ID
        FROM Pagamento;

        INSERT INTO Pagamento (ID, Data, Horario, Valor, ID_Funcionario)
        VALUES (
            v_Novo_ID, 
            SYSDATE,
            SYSTIMESTAMP,
            p_Valor,
            (SELECT ID_Dentista FROM Agendamento WHERE ID = 
                (SELECT ID_Agendamento FROM Atendimento WHERE ID = p_ID_Atendimento))
        );


        UPDATE Atendimento
        SET Pago = 'S'
        WHERE ID = p_ID_Atendimento;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20002, 'Erro ao registrar pagamento: ' || SQLERRM);
END;

--Testes objetos de programacao

--teste 1
select * from atendimento at  right join
agendamento ag on at.ID_AGENDAMENTO = ag.id;

select * from tipo_atendimento;

select * from uso_materiais;

select * from estoque;

insert into atendimento values(5, 6, 'N');

select * from estoque;

insert into atendimento values(6, 5, 'N');


--teste2
select * from atendimento at  right join
agendamento ag on at.ID_AGENDAMENTO = ag.id;

Insert into AGENDAMENTO values ('8', to_date('29/12/23', 'DD/MM/RR'), null, '2', '1', '3');

--teste3
BEGIN
    Registrar_Pagamento(p_ID_Atendimento => 2, p_Valor => 200.00);
END;
select * from  pagamento;
