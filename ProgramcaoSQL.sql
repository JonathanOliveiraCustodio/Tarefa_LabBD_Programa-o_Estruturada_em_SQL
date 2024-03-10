/*Exercícios:
1) Fazer em SQL Server os seguintes algoritmos:
a) Fazer um algoritmo que leia 1 número e mostre se são múltiplos de 2,3,5 ou nenhum deles
*/

DECLARE @Numero INT = 5;

IF @Numero % 2 = 0
    PRINT 'O número ' + CAST(@Numero AS NVARCHAR(10)) + ' é múltiplo de 2.';
 ELSE 
  IF @Numero % 3 = 0
    PRINT 'O número ' + CAST(@Numero AS NVARCHAR(10)) + ' é múltiplo de 3.';
 ELSE 
  IF @Numero % 5 = 0
    PRINT 'O número ' + CAST(@Numero AS NVARCHAR(10)) + ' é múltiplo de 5.';
ELSE
    PRINT 'O número ' + CAST(@Numero AS NVARCHAR(10)) + ' não é múltiplo de 2, 3 ou 5.';


--b) Fazer um algoritmo que leia 3 números e mostre o maior e o menor
DECLARE @Num1    INT = -1010;
DECLARE @Num2    INT = 5;
DECLARE @Num3    INT = 800;
DECLARE @Maior   INT;
DECLARE @Menor   INT;

IF @Num1 >= @Num2 AND @Num1 >= @Num3
    SET @Maior = @Num1;
ELSE IF @Num2 >= @Num1 AND @Num2 >= @Num3
    SET @Maior = @Num2;
ELSE
    SET @Maior = @Num3;

IF @Num1 <= @Num2 AND @Num1 <= @Num3
    SET @Menor = @Num1;
ELSE IF @Num2 <= @Num1 AND @Num2 <= @Num3
    SET @Menor = @Num2;
ELSE
    SET @Menor = @Num3;

PRINT 'O maior número é: ' + CAST(@Maior AS VARCHAR(10));
PRINT 'O menor número é: ' + CAST(@Menor AS VARCHAR(10));


--c) Fazer um algoritmo que calcule os 15 primeiros termos da série 1,1,2,3,5,8,13,21,... E calcule a soma dos 15 termos

DECLARE @numero INT = 15;
DECLARE @cont INT = 1;
DECLARE @num_anterior INT = 0;
DECLARE @num_atual INT = 1;
DECLARE @prox_num INT;
DECLARE @saida VARCHAR(MAX) = '';

SET @saida = @saida + CAST(@num_atual AS VARCHAR(10));
WHILE @cont < @numero
BEGIN
    SET @prox_num = @num_anterior + @num_atual;
    SET @num_anterior = @num_atual;
    SET @num_atual = @prox_num;
    SET @saida = @saida + ',' + CAST(@prox_num AS VARCHAR(10));
    SET @cont = @cont + 1;
END;
PRINT @saida;

--d) Fazer um algoritmo que separa uma frase, colocando todas as letras em maiúsculo e em minúsculo (Usar funções UPPER e LOWER)

DECLARE @Frase VARCHAR(MAX) = 'Testando Maisculo e Minusculo';
DECLARE @FraseMaiuscula VARCHAR(MAX);
DECLARE @FraseMinuscula VARCHAR(MAX);

SET @FraseMaiuscula = UPPER(@Frase);
SET @FraseMinuscula = LOWER(@Frase);

PRINT 'Frase Original:'+ @Frase
PRINT 'Frase em Maiúsculas:'+ @FraseMaiuscula
PRINT 'Frase em Minúsculas:'+ @FraseMinuscula 

--e) Fazer um algoritmo que inverta uma palavra (Usar a função SUBSTRING)

DECLARE @Palavra VARCHAR(100) = 'Jonathan';
DECLARE @Tamanho INT = LEN(@Palavra);
DECLARE @PalavraInvertida VARCHAR(100) = '';

DECLARE @Indice INT = @Tamanho;
WHILE @Indice > 0
BEGIN
    SET @PalavraInvertida = @PalavraInvertida + SUBSTRING(@Palavra, @Indice, 1);
    SET @Indice = @Indice - 1;
END

	PRINT @PalavraInvertida 
    SELECT @Palavra AS PalavraOriginal, @PalavraInvertida AS PalavraInvertida;



/*f) Considerando a tabela abaixo, gere uma massa de dados, com 100 registros, para fins de teste com as regras estabelecidas (Não usar constraints na criação da tabela)
Computador
ID			Marca          QtdRAM      TipoHD         QtdHD      FreqCPU
INT (PK)    VARCHAR(40)    INT         VARCHAR(10)    INT        DECIMAL(7,2)

• ID incremental a iniciar de 10001
• Marca segue o padrão simples, Marca 1, Marca 2, Marca 3, etc.
• QtdRAM é um número aleatório* dentre os valores permitidos (2, 4, 8, 16)
• TipoHD segue o padrão:
o Se o ID dividido por 3 der resto 0, é HDD
o Se o ID dividido por 3 der resto 1, é SSD
o Se o ID dividido por 3 der resto 2, é M2 NVME
• QtdHD segue o padrão:
o Se o TipoHD for HDD, um valor aleatório* dentre os valores permitidos (500, 1000 ou 2000)
o Se o TipoHD for SSD, um valor aleatório* dentre os valores permitidos (128, 256, 512)
• FreqHD é um número aleatório* entre 1.70 e 3.20
* Função RAND() gera números aleatórios entre 0 e 0,9999...
*/

USE aulaprogsql

DROP TABLE Computador
CREATE TABLE Computador (
ID			INT			    NOT NULL,
Marca		VARCHAR(40)     NOT NULL,
QtdRAM      INT			    NOT NULL,
TipoHD      VARCHAR(10)     NOT NULL,
QtdHD		INT			    NOT NULL,
FreqCPU	    DECIMAL(7,2)	NOT NULL
PRIMARY KEY (ID)
)
GO


DECLARE @Cont INT = 1;
DECLARE @ID INT = 10001;
DECLARE @Marca NVARCHAR(50);
DECLARE @QtdRAM INT;
DECLARE @TipoHD NVARCHAR(20);
DECLARE @QtdHD INT;
DECLARE @FreqCPU DECIMAL(4,2);

WHILE (@Cont <= 100) 
BEGIN
    SET @Marca = 'Marca ' + CAST(@Cont AS NVARCHAR(50));
    SET @QtdRAM = (CAST(RAND() * 4 + 1 AS INT)) * 2;

    IF (@ID - 10001) % 3 = 0
        SET @TipoHD = 'HDD';
    ELSE IF (@ID - 10001) % 3 = 1
        SET @TipoHD = 'SSD';
    ELSE
        SET @TipoHD = 'M2 NVME';

    IF @TipoHD = 'HDD'
        SET @QtdHD = (CAST(RAND() * 3 + 1 AS INT)) * 500;
    ELSE
        SET @QtdHD = (CAST(RAND() * 3 + 1 AS INT)) * 128;

    SET @FreqCPU = ROUND(RAND() * (3.20 - 1.70) + 1.70, 2);

    INSERT INTO Computador(ID, Marca, QtdRAM, TipoHD, QtdHD, FreqCPU)
    VALUES (@ID, @Marca, @QtdRAM, @TipoHD, @QtdHD, @FreqCPU);

    SET @ID = @ID + 1;
	 SET @Cont = @Cont + 1;
END;

SELECT * FROM Computador;


