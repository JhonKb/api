-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 05/11/2023 às 11:46
-- Versão do servidor: 10.4.28-MariaDB
-- Versão do PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `eleicoesuni`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `alunos`
--

CREATE TABLE `alunos` (
  `id` int(11) NOT NULL,
  `nomeAluno` varchar(50) NOT NULL,
  `matriculaAluno` int(8) NOT NULL,
  `idTurma` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `alunos`
--

INSERT INTO `alunos` (`id`, `nomeAluno`, `matriculaAluno`, `idTurma`) VALUES
(1, 'Jhon Klebson da Silva Oliveira', 22218036, 2),
(2, 'João Vitor Alves', 22218040, 2),
(3, 'Davi Bezerra de Sousa', 22218038, 2);

--
-- Acionadores `alunos`
--
DELIMITER $$
CREATE TRIGGER `preencher_lacuna_alunos` BEFORE INSERT ON `alunos` FOR EACH ROW BEGIN
    DECLARE id_atual INT;
    DECLARE id_disponivel INT DEFAULT NULL;

    -- Inicia a busca a partir do ID 1
    SET id_atual = 1;

    -- Loop para encontrar o primeiro ID disponível
    WHILE id_disponivel IS NULL DO
        -- Verifica se o ID está vazio
        IF NOT EXISTS (SELECT 1 FROM alunos WHERE id = id_atual) THEN
            SET id_disponivel = id_atual; -- Atribui o ID vazio à nova inserção
        END IF;
        
        SET id_atual = id_atual + 1; -- Avança para o próximo ID
    END WHILE;

    -- Se encontrou um ID disponível, atribui à nova inserção
    IF id_disponivel IS NOT NULL THEN
        SET NEW.id = id_disponivel;
    ELSE
        -- Se não encontrou nenhum ID disponível, atribui o próximo ID sequencial
        SET NEW.id = (SELECT MAX(id) + 1 FROM alunos);
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `chapas`
--

CREATE TABLE `chapas` (
  `id` int(11) NOT NULL,
  `matriculaLider` int(8) NOT NULL,
  `matriculaVice` int(8) NOT NULL,
  `idTurma` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `chapas`
--

INSERT INTO `chapas` (`id`, `matriculaLider`, `matriculaVice`, `idTurma`) VALUES
(1, 22218036, 22218040, 2);

--
-- Acionadores `chapas`
--
DELIMITER $$
CREATE TRIGGER `preencher_lacuna_chapas` BEFORE INSERT ON `chapas` FOR EACH ROW BEGIN
    DECLARE id_atual INT;
    DECLARE id_disponivel INT DEFAULT NULL;

    -- Inicia a busca a partir do ID 1
    SET id_atual = 1;

    -- Loop para encontrar o primeiro ID disponível
    WHILE id_disponivel IS NULL DO
        -- Verifica se o ID está vazio
        IF NOT EXISTS (SELECT 1 FROM chapas WHERE id = id_atual) THEN
            SET id_disponivel = id_atual; -- Atribui o ID vazio à nova inserção
        END IF;
        
        SET id_atual = id_atual + 1; -- Avança para o próximo ID
    END WHILE;

    -- Se encontrou um ID disponível, atribui à nova inserção
    IF id_disponivel IS NOT NULL THEN
        SET NEW.id = id_disponivel;
    ELSE
        -- Se não encontrou nenhum ID disponível, atribui o próximo ID sequencial
        SET NEW.id = (SELECT MAX(id) + 1 FROM chapas);
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `turmas`
--

CREATE TABLE `turmas` (
  `id` int(11) NOT NULL,
  `nomeTurma` varchar(45) NOT NULL,
  `cursoTurma` varchar(45) NOT NULL,
  `qtdALunos` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `turmas`
--

INSERT INTO `turmas` (`id`, `nomeTurma`, `cursoTurma`, `qtdALunos`) VALUES
(1, 'Psicologia 3/4', 'Psicologia', 60),
(2, 'ADS 1/2', 'ADS', 60),
(3, 'ADS 3/4', 'ADS', 30),
(4, 'Psicologia 1/2', 'Psicologia', 60);

--
-- Acionadores `turmas`
--
DELIMITER $$
CREATE TRIGGER `preencher_lacuna_turmas` BEFORE INSERT ON `turmas` FOR EACH ROW BEGIN
    DECLARE id_atual INT;
    DECLARE id_disponivel INT DEFAULT NULL;

    -- Inicia a busca a partir do ID 1
    SET id_atual = 1;

    -- Loop para encontrar o primeiro ID disponível
    WHILE id_disponivel IS NULL DO
        -- Verifica se o ID está vazio
        IF NOT EXISTS (SELECT 1 FROM turmas WHERE id = id_atual) THEN
            SET id_disponivel = id_atual; -- Atribui o ID vazio à nova inserção
        END IF;
        
        SET id_atual = id_atual + 1; -- Avança para o próximo ID
    END WHILE;

    -- Se encontrou um ID disponível, atribui à nova inserção
    IF id_disponivel IS NOT NULL THEN
        SET NEW.id = id_disponivel;
    ELSE
        -- Se não encontrou nenhum ID disponível, atribui o próximo ID sequencial
        SET NEW.id = (SELECT MAX(id) + 1 FROM turmas);
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `votos`
--

CREATE TABLE `votos` (
  `id` int(11) NOT NULL,
  `nomeVoto` varchar(225) NOT NULL,
  `matriculaVoto` int(8) NOT NULL,
  `idChapa` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Acionadores `votos`
--
DELIMITER $$
CREATE TRIGGER `preencher_lacuna_votos` BEFORE INSERT ON `votos` FOR EACH ROW BEGIN
    DECLARE id_atual INT;
    DECLARE id_disponivel INT DEFAULT NULL;

    -- Inicia a busca a partir do ID 1
    SET id_atual = 1;

    -- Loop para encontrar o primeiro ID disponível
    WHILE id_disponivel IS NULL DO
        -- Verifica se o ID está vazio
        IF NOT EXISTS (SELECT 1 FROM votos WHERE id = id_atual) THEN
            SET id_disponivel = id_atual; -- Atribui o ID vazio à nova inserção
        END IF;
        
        SET id_atual = id_atual + 1; -- Avança para o próximo ID
    END WHILE;

    -- Se encontrou um ID disponível, atribui à nova inserção
    IF id_disponivel IS NOT NULL THEN
        SET NEW.id = id_disponivel;
    ELSE
        -- Se não encontrou nenhum ID disponível, atribui o próximo ID sequencial
        SET NEW.id = (SELECT MAX(id) + 1 FROM votos);
    END IF;
END
$$
DELIMITER ;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `alunos`
--
ALTER TABLE `alunos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `matriculaAluno_UNIQUE` (`matriculaAluno`),
  ADD KEY `idTurma_Alunos_idx` (`idTurma`);

--
-- Índices de tabela `chapas`
--
ALTER TABLE `chapas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nomeLider_UNIQUE` (`matriculaLider`),
  ADD UNIQUE KEY `nomeVice_UNIQUE` (`matriculaVice`),
  ADD KEY `idTurma_idx` (`idTurma`),
  ADD KEY `idAluno_Candidatura_idx` (`matriculaLider`,`matriculaVice`);

--
-- Índices de tabela `turmas`
--
ALTER TABLE `turmas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nomeTurma_UNIQUE` (`nomeTurma`);

--
-- Índices de tabela `votos`
--
ALTER TABLE `votos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `matriculaVoto_UNIQUE` (`matriculaVoto`),
  ADD KEY `idChapa_idx` (`idChapa`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `alunos`
--
ALTER TABLE `alunos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `chapas`
--
ALTER TABLE `chapas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `turmas`
--
ALTER TABLE `turmas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `votos`
--
ALTER TABLE `votos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `alunos`
--
ALTER TABLE `alunos`
  ADD CONSTRAINT `idTurma_Alunos` FOREIGN KEY (`idTurma`) REFERENCES `turmas` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

--
-- Restrições para tabelas `chapas`
--
ALTER TABLE `chapas`
  ADD CONSTRAINT `idTurma_Chapa` FOREIGN KEY (`idTurma`) REFERENCES `turmas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `votos`
--
ALTER TABLE `votos`
  ADD CONSTRAINT `idChapa` FOREIGN KEY (`idChapa`) REFERENCES `chapas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
