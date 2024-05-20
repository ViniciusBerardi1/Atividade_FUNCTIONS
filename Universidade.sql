-- criar tabelas

CREATE TABLE Areas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL
);

CREATE TABLE Cursos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    area_id INT,
    FOREIGN KEY (area_id) REFERENCES Areas(id)
);

CREATE TABLE Alunos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    sobrenome VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL
);

CREATE TABLE Matriculas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    aluno_id INT,
    curso_id INT,
    FOREIGN KEY (aluno_id) REFERENCES Alunos(id),
    FOREIGN KEY (curso_id) REFERENCES Cursos(id),
    UNIQUE(aluno_id, curso_id)
);

DELIMITER //

-- logica para inserir curso
CREATE PROCEDURE InserirCurso(IN nomeCurso VARCHAR(100), IN nomeArea VARCHAR(50))
BEGIN
    DECLARE areaID INT;
    
    SET areaID = (SELECT id FROM Areas WHERE nome = nomeArea);
    
    IF areaID IS NULL THEN
        INSERT INTO Areas (nome) VALUES (nomeArea);
        SET areaID = LAST_INSERT_ID();
    END IF;

    INSERT INTO Cursos (nome, area_id) VALUES (nomeCurso, areaID);
END //

DELIMITER ;

DELIMITER //
-- logica para matricula
CREATE PROCEDURE MatricularAluno(IN alunoID INT, IN cursoID INT)
BEGIN
    DECLARE contador INT;
    
    SET contador = (SELECT COUNT(*) FROM Matriculas WHERE aluno_id = alunoID AND curso_id = cursoID);
    
    IF contador = 0 THEN

        INSERT INTO Matriculas (aluno_id, curso_id) VALUES (alunoID, cursoID);
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O aluno já está matriculado neste curso.';
    END IF;
END //

DELIMITER ;

DELIMITER //
-- logica de gerar email
CREATE FUNCTION GerarEmail(nome VARCHAR(50), sobrenome VARCHAR(50)) RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    RETURN CONCAT(nome, '.', sobrenome, '@universidade.com');
END //

DELIMITER ;


DELIMITER //
-- logica para ID do curso
CREATE FUNCTION ObterIdCurso(nomeCurso VARCHAR(100), nomeArea VARCHAR(50)) RETURNS INT
READS SQL DATA
BEGIN
    DECLARE cursoID INT;
    
    SELECT c.id INTO cursoID
    FROM Cursos c
    JOIN Areas a ON c.area_id = a.id
    WHERE c.nome = nomeCurso AND a.nome = nomeArea;
    
    RETURN cursoID;
END //

DELIMITER ;


CALL InserirCurso('Engenharia de Software', 'Tecnologia');
CALL InserirCurso('Medicina', 'Saúde');
CALL InserirCurso('Direito', 'Ciências Humanas');
CALL InserirCurso('Administração', 'Negócios');
CALL InserirCurso('Ciências Contábeis', 'Negócios');
CALL InserirCurso('Psicologia', 'Saúde');
CALL InserirCurso('Biologia', 'Ciências Biológicas');
CALL InserirCurso('Enfermagem', 'Saúde');
CALL InserirCurso('Arquitetura e Urbanismo', 'Tecnologia');
CALL InserirCurso('Engenharia Civil', 'Tecnologia');
CALL InserirCurso('Engenharia Elétrica', 'Tecnologia');
CALL InserirCurso('Física', 'Ciências Exatas');
CALL InserirCurso('Matemática', 'Ciências Exatas');
CALL InserirCurso('Química', 'Ciências Exatas');
CALL InserirCurso('História', 'Ciências Humanas');
CALL InserirCurso('Geografia', 'Ciências Humanas');
CALL InserirCurso('Letras', 'Ciências Humanas');
CALL InserirCurso('Pedagogia', 'Ciências Humanas');
CALL InserirCurso('Farmácia', 'Saúde');
CALL InserirCurso('Odontologia', 'Saúde');
CALL InserirCurso('Nutrição', 'Saúde');
CALL InserirCurso('Fisioterapia', 'Saúde');
CALL InserirCurso('Engenharia Mecânica', 'Tecnologia');
CALL InserirCurso('Engenharia de Produção', 'Tecnologia');
CALL InserirCurso('Engenharia Química', 'Tecnologia');

-- Inserir alunos
INSERT INTO Alunos (nome, sobrenome, email) VALUES 
('Joao', 'Silva', GerarEmail('Joao', 'Silva')),
('Maria', 'Souza', GerarEmail('Maria', 'Souza')),
('Pedro', 'Oliveira', GerarEmail('Pedro', 'Oliveira')),
('Ana', 'Santos', GerarEmail('Ana', 'Santos')),
('Carlos', 'Pereira', GerarEmail('Carlos', 'Pereira')),
('Lucia', 'Ferreira', GerarEmail('Lucia', 'Ferreira')),
('Marcos', 'Costa', GerarEmail('Marcos', 'Costa')),
('Carla', 'Ribeiro', GerarEmail('Carla', 'Ribeiro')),
('Felipe', 'Martins', GerarEmail('Felipe', 'Martins')),
('Juliana', 'Almeida', GerarEmail('Juliana', 'Almeida')),
('Ricardo', 'Lima', GerarEmail('Ricardo', 'Lima')),
('Fernanda', 'Gomes', GerarEmail('Fernanda', 'Gomes')),
('Rafael', 'Rodrigues', GerarEmail('Rafael', 'Rodrigues')),
('Patricia', 'Nascimento', GerarEmail('Patricia', 'Nascimento')),
('Thiago', 'Araujo', GerarEmail('Thiago', 'Araujo')),
('Camila', 'Melo', GerarEmail('Camila', 'Melo')),
('Gustavo', 'Barbosa', GerarEmail('Gustavo', 'Barbosa')),
('Larissa', 'Dias', GerarEmail('Larissa', 'Dias')),
('Bruno', 'Moreira', GerarEmail('Bruno', 'Moreira')),
('Renata', 'Cardoso', GerarEmail('Renata', 'Cardoso')),
('Mateus', 'Campos', GerarEmail('Mateus', 'Campos')),
('Gabriela', 'Souza', GerarEmail('Gabriela', 'Souza')),
('Anderson', 'Carvalho', GerarEmail('Anderson', 'Carvalho')),
('Beatriz', 'Silva', GerarEmail('Beatriz', 'Silva')),
('Victor', 'Rocha', GerarEmail('Victor', 'Rocha')),
('Mariana', 'Rezende', GerarEmail('Mariana', 'Rezende')),
('Rodrigo', 'Brito', GerarEmail('Rodrigo', 'Brito')),
('Vanessa', 'Lopes', GerarEmail('Vanessa', 'Lopes')),
('Alexandre', 'Monteiro', GerarEmail('Alexandre', 'Monteiro')),
('Natalia', 'Santos', GerarEmail('Natalia', 'Santos')),
('Bruna', 'Castro', GerarEmail('Bruna', 'Castro')),
('Eduardo', 'Correia', GerarEmail('Eduardo', 'Correia')),
('Viviane', 'Moura', GerarEmail('Viviane', 'Moura')),
('Lucas', 'Fernandes', GerarEmail('Lucas', 'Fernandes')),
('Elaine', 'Pires', GerarEmail('Elaine', 'Pires')),
('Paulo', 'Teixeira', GerarEmail('Paulo', 'Teixeira')),
('Tatiane', 'Machado', GerarEmail('Tatiane', 'Machado')),
('Fernando', 'Silva', GerarEmail('Fernando', 'Silva')),
('Alessandra', 'Sousa', GerarEmail('Alessandra', 'Sousa')),
('Leonardo', 'Martins', GerarEmail('Leonardo', 'Martins')),
('Adriana', 'Lima', GerarEmail('Adriana', 'Lima')),
('Wagner', 'Oliveira', GerarEmail('Wagner', 'Oliveira')),
('Cintia', 'Gomes', GerarEmail('Cintia', 'Gomes')),
('Aline', 'Rodrigues', GerarEmail('Aline', 'Rodrigues')),
('Rogério', 'Nascimento', GerarEmail('Rogério', 'Nascimento')),
('Simone', 'Araujo', GerarEmail('Simone', 'Araujo')),
('Vinicius', 'Melo', GerarEmail('Vinicius', 'Melo')),
('Kelly', 'Barbosa', GerarEmail('Kelly', 'Barbosa')),
('Leandro', 'Dias', GerarEmail('Leandro', 'Dias')),
('Priscila', 'Moreira', GerarEmail('Priscila', 'Moreira')),
('Mauricio', 'Cardoso', GerarEmail('Mauricio', 'Cardoso')),
('Andressa', 'Campos', GerarEmail('Andressa', 'Campos')),
('Fabrício', 'Souza', GerarEmail('Fabrício', 'Souza')),
('Denise', 'Carvalho', GerarEmail('Denise', 'Carvalho')),
('Rafael', 'Silva', GerarEmail('Rafael', 'Silva')),
('Luciana', 'Rocha', GerarEmail('Luciana', 'Rocha')),
('Jonas', 'Rezende', GerarEmail('Jonas', 'Rezende')),
('Silvia', 'Brito', GerarEmail('Silvia', 'Brito')),
('André', 'Lopes', GerarEmail('André', 'Lopes')),
('Paula', 'Monteiro', GerarEmail('Paula', 'Monteiro')),
('Renato', 'Santos', GerarEmail('Renato', 'Santos')),
('Michele', 'Castro', GerarEmail('Michele', 'Castro')),
('Roberto', 'Correia', GerarEmail('Roberto', 'Correia')),
('Flavia', 'Moura', GerarEmail('Flavia', 'Moura')),
('Cesar', 'Fernandes', GerarEmail('Cesar', 'Fernandes')),
('Daniela', 'Pires', GerarEmail('Daniela', 'Pires')),
('Marcio', 'Teixeira', GerarEmail('Marcio', 'Teixeira')),
('Rita', 'Machado', GerarEmail('Rita', 'Machado')),
('Jorge', 'Silva', GerarEmail('Jorge', 'Silva')),
('Lucia', 'Sousa', GerarEmail('Lucia', 'Sousa')),
('Alberto', 'Martins', GerarEmail('Alberto', 'Martins')),
('Clarice', 'Lima', GerarEmail('Clarice', 'Lima')),
('Marina', 'Oliveira', GerarEmail('Marina', 'Oliveira')),
('Francisco', 'Gomes', GerarEmail('Francisco', 'Gomes')),
('Marta', 'Rodrigues', GerarEmail('Marta', 'Rodrigues')),
('Ricardo', 'Nascimento', GerarEmail('Ricardo', 'Nascimento')),
('Luana', 'Araujo', GerarEmail('Luana', 'Araujo')),
('Edson', 'Melo', GerarEmail('Edson', 'Melo')),
('Leticia', 'Barbosa', GerarEmail('Leticia', 'Barbosa')),
('Nicolas', 'Dias', GerarEmail('Nicolas', 'Dias')),
('Lidiane', 'Moreira', GerarEmail('Lidiane', 'Moreira')),
('Carlos', 'Cardoso', GerarEmail('Carlos', 'Cardoso')),
('Tatiana', 'Campos', GerarEmail('Tatiana', 'Campos')),
('José', 'Souza', GerarEmail('José', 'Souza')),
('Monica', 'Carvalho', GerarEmail('Monica', 'Carvalho')),
('Edmar', 'Silva', GerarEmail('Edmar', 'Silva')),
('Cristina', 'Rocha', GerarEmail('Cristina', 'Rocha')),
('Fábio', 'Rezende', GerarEmail('Fábio', 'Rezende')),
('Vanessa', 'Brito', GerarEmail('Vanessa', 'Brito')),
('Luis', 'Lopes', GerarEmail('Luis', 'Lopes')),
('Renata', 'Monteiro', GerarEmail('Renata', 'Monteiro')),
('Tiago', 'Santos', GerarEmail('Tiago', 'Santos')),
('Lais', 'Castro', GerarEmail('Lais', 'Castro')),
('Diogo', 'Correia', GerarEmail('Diogo', 'Correia')),
('Elaine', 'Moura', GerarEmail('Elaine', 'Moura')),
('Eduardo', 'Fernandes', GerarEmail('Eduardo', 'Fernandes')),
('Jaqueline', 'Pires', GerarEmail('Jaqueline', 'Pires')),
('Flavio', 'Teixeira', GerarEmail('Flavio', 'Teixeira')),
('Marcela', 'Machado', GerarEmail('Marcela', 'Machado')),
('João', 'Silva', GerarEmail('João', 'Silva')),
('Carla', 'Sousa', GerarEmail('Carla', 'Sousa')),
('Rafael', 'Martins', GerarEmail('Rafael', 'Martins')),
('Isabel', 'Lima', GerarEmail('Isabel', 'Lima')),
('Paulo', 'Oliveira', GerarEmail('Paulo', 'Oliveira')),
('Adriano', 'Gomes', GerarEmail('Adriano', 'Gomes')),
('Veronica', 'Rodrigues', GerarEmail('Veronica', 'Rodrigues')),
('Daniel', 'Nascimento', GerarEmail('Daniel', 'Nascimento')),
('Vitoria', 'Araujo', GerarEmail('Vitoria', 'Araujo')),
('José', 'Melo', GerarEmail('José', 'Melo')),
('Mariana', 'Barbosa', GerarEmail('Mariana', 'Barbosa')),
('Anderson', 'Dias', GerarEmail('Anderson', 'Dias')),
('Bárbara', 'Moreira', GerarEmail('Bárbara', 'Moreira')),
('Alexandre', 'Cardoso', GerarEmail('Alexandre', 'Cardoso')),
('Carolina', 'Campos', GerarEmail('Carolina', 'Campos')),
('Joana', 'Souza', GerarEmail('Joana', 'Souza')),
('Henrique', 'Carvalho', GerarEmail('Henrique', 'Carvalho')),
('Guilherme', 'Silva', GerarEmail('Guilherme', 'Silva')),
('Patrícia', 'Rocha', GerarEmail('Patrícia', 'Rocha')),
('Samuel', 'Rezende', GerarEmail('Samuel', 'Rezende')),
('Vania', 'Brito', GerarEmail('Vania', 'Brito')),
('Diego', 'Lopes', GerarEmail('Diego', 'Lopes')),
('Juliana', 'Monteiro', GerarEmail('Juliana', 'Monteiro')),
('Lucio', 'Santos', GerarEmail('Lucio', 'Santos')),
('Simone', 'Castro', GerarEmail('Simone', 'Castro')),
('Julio', 'Correia', GerarEmail('Julio', 'Correia')),
('Rosana', 'Moura', GerarEmail('Rosana', 'Moura')),
('Alex', 'Fernandes', GerarEmail('Alex', 'Fernandes')),
('Eliane', 'Pires', GerarEmail('Eliane', 'Pires')),
('Gilberto', 'Teixeira', GerarEmail('Gilberto', 'Teixeira')),
('Denise', 'Machado', GerarEmail('Denise', 'Machado')),
('Nelson', 'Silva', GerarEmail('Nelson', 'Silva')),
('Viviane', 'Sousa', GerarEmail('Viviane', 'Sousa')),
('Felipe', 'Martins', GerarEmail('Felipe', 'Martins')),
('Ana', 'Lima', GerarEmail('Ana', 'Lima')),
('Caio', 'Oliveira', GerarEmail('Caio', 'Oliveira')),
('Marcelo', 'Gomes', GerarEmail('Marcelo', 'Gomes')),
('Suzana', 'Rodrigues', GerarEmail('Suzana', 'Rodrigues')),
('Andre', 'Nascimento', GerarEmail('Andre', 'Nascimento')),
('Bruna', 'Araujo', GerarEmail('Bruna', 'Araujo')),
('Edson', 'Melo', GerarEmail('Edson', 'Melo')),
('Aline', 'Barbosa', GerarEmail('Aline', 'Barbosa')),
('Mauricio', 'Dias', GerarEmail('Mauricio', 'Dias')),
('Luciana', 'Moreira', GerarEmail('Luciana', 'Moreira')),
('Matheus', 'Cardoso', GerarEmail('Matheus', 'Cardoso')),
('Marina', 'Campos', GerarEmail('Marina', 'Campos')),
('Elias', 'Souza', GerarEmail('Elias', 'Souza')),
('Tatiane', 'Carvalho', GerarEmail('Tatiane', 'Carvalho')),
('Gustavo', 'Silva', GerarEmail('Gustavo', 'Silva')),
('Flavia', 'Rocha', GerarEmail('Flavia', 'Rocha')),
('Rodrigo', 'Rezende', GerarEmail('Rodrigo', 'Rezende')),
('Maria', 'Brito', GerarEmail('Maria', 'Brito')),
('Hugo', 'Lopes', GerarEmail('Hugo', 'Lopes')),
('Marcia', 'Monteiro', GerarEmail('Marcia', 'Monteiro')),
('Alexandre', 'Santos', GerarEmail('Alexandre', 'Santos')),
('Carla', 'Castro', GerarEmail('Carla', 'Castro')),
('Rafael', 'Correia', GerarEmail('Rafael', 'Correia')),
('Sandra', 'Moura', GerarEmail('Sandra', 'Moura')),
('Bruno', 'Fernandes', GerarEmail('Bruno', 'Fernandes')),
('Natalia', 'Pires', GerarEmail('Natalia', 'Pires')),
('Robson', 'Teixeira', GerarEmail('Robson', 'Teixeira')),
('Juliana', 'Machado', GerarEmail('Juliana', 'Machado')),
('Eduardo', 'Silva', GerarEmail('Eduardo', 'Silva')),
('Gabriela', 'Sousa', GerarEmail('Gabriela', 'Sousa')),
('Lucas', 'Martins', GerarEmail('Lucas', 'Martins')),
('Aline', 'Lima', GerarEmail('Aline', 'Lima')),
('Marcelo', 'Oliveira', GerarEmail('Marcelo', 'Oliveira')),
('Carlos', 'Gomes', GerarEmail('Carlos', 'Gomes')),
('Simone', 'Rodrigues', GerarEmail('Simone', 'Rodrigues')),
('Mariana', 'Nascimento', GerarEmail('Mariana', 'Nascimento')),
('Thiago', 'Araujo', GerarEmail('Thiago', 'Araujo')),
('Luan', 'Melo', GerarEmail('Luan', 'Melo')),
('Patricia', 'Barbosa', GerarEmail('Patricia', 'Barbosa')),
('Fernando', 'Dias', GerarEmail('Fernando', 'Dias')),
('Daniela', 'Moreira', GerarEmail('Daniela', 'Moreira')),
('Luciano', 'Cardoso', GerarEmail('Luciano', 'Cardoso')),
('Carolina', 'Campos', GerarEmail('Carolina', 'Campos')),
('Henrique', 'Souza', GerarEmail('Henrique', 'Souza')),
('Rita', 'Carvalho', GerarEmail('Rita', 'Carvalho')),
('Fábio', 'Silva', GerarEmail('Fábio', 'Silva')),
('Marta', 'Rocha', GerarEmail('Marta', 'Rocha')),
('Leonardo', 'Rezende', GerarEmail('Leonardo', 'Rezende')),
('Bruna', 'Brito', GerarEmail('Bruna', 'Brito')),
('Diego', 'Lopes', GerarEmail('Diego', 'Lopes')),
('Vania', 'Monteiro', GerarEmail('Vania', 'Monteiro')),
('Pedro', 'Santos', GerarEmail('Pedro', 'Santos')),
('Marcela', 'Castro', GerarEmail('Marcela', 'Castro')),
('Julio', 'Correia', GerarEmail('Julio', 'Correia')),
('Michele', 'Moura', GerarEmail('Michele', 'Moura')),
('Rodrigo', 'Fernandes', GerarEmail('Rodrigo', 'Fernandes')),
('Paula', 'Pires', GerarEmail('Paula', 'Pires')),
('Alex', 'Teixeira', GerarEmail('Alex', 'Teixeira')),
('Renata', 'Machado', GerarEmail('Renata', 'Machado')),
('Gustavo', 'Silva', GerarEmail('Gustavo', 'Silva')),
('Vinicius', 'soares', GerarEmail('vinicius', 'soares')),
('Gustavo', 'berni', GerarEmail('Gustavo', 'berni')),
('Milena', 'Tada', GerarEmail('Milena', 'Tada')),
('kleiton', 'Rodygues', GerarEmail('kleiton', 'Rodygues')),
('Gerson', 'Almeida', GerarEmail('Gerson', 'Almeida')),
('Julia', 'Beatriz', GerarEmail('Julia', 'Beatriz')),
('Francisco', 'Lorotas', GerarEmail('Chico', 'Lorotas')),
('Robson', 'Tangerina', GerarEmail('Robson', 'Tangerina')),
('Clementina', 'Pocan', GerarEmail('Clementina', 'Pocan'));

