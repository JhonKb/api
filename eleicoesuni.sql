-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 07/11/2023 às 15:06
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
(1, 'Geraldo Alcino', 22222222, 3),
(2, 'Lula Drão', 22222223, 3),
(3, 'Bozo Naro', 22222224, 3),
(4, 'Sicrana Tebet', 22222225, 3);

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
  `idTurma` int(11) NOT NULL,
  `idLider` int(11) NOT NULL,
  `idVice` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `chapas`
--

INSERT INTO `chapas` (`id`, `idTurma`, `idLider`, `idVice`) VALUES
(12345, 3, 1, 2),
(12543, 3, 3, 4);

-- --------------------------------------------------------

--
-- Estrutura para tabela `turmas`
--

CREATE TABLE `turmas` (
  `id` int(11) NOT NULL,
  `nomeTurma` varchar(45) NOT NULL,
  `cursoTurma` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `turmas`
--

INSERT INTO `turmas` (`id`, `nomeTurma`, `cursoTurma`) VALUES
(1, 'Psicologia 3/4', 'Psicologia'),
(2, 'ADS 1/2', 'ADS'),
(3, 'ADS 3/4', 'ADS'),
(4, 'Psicologia 1/2', 'Psicologia'),
(5, 'Direito 1/2', 'Direito'),
(6, 'Direito 3/4', 'Direito');

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
  `idVotante` int(11) NOT NULL,
  `idChapa` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `votos`
--

INSERT INTO `votos` (`id`, `idVotante`, `idChapa`) VALUES
(1, 1, 12345);

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
  ADD UNIQUE KEY `id_UNIQUE` (`id`),
  ADD UNIQUE KEY `idLider_UNIQUE` (`idLider`),
  ADD UNIQUE KEY `idVice_UNIQUE` (`idVice`),
  ADD KEY `idTurma_idx` (`idTurma`);

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
  ADD UNIQUE KEY `idVoto_UNIQUE` (`idVotante`),
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
-- AUTO_INCREMENT de tabela `turmas`
--
ALTER TABLE `turmas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `votos`
--
ALTER TABLE `votos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `alunos`
--
ALTER TABLE `alunos`
  ADD CONSTRAINT `idTurma_Alunos` FOREIGN KEY (`idTurma`) REFERENCES `turmas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Restrições para tabelas `chapas`
--
ALTER TABLE `chapas`
  ADD CONSTRAINT `idLider_Chapa` FOREIGN KEY (`idLider`) REFERENCES `alunos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `idTurma_Chapa` FOREIGN KEY (`idTurma`) REFERENCES `turmas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `idVice_Chapa` FOREIGN KEY (`idVice`) REFERENCES `alunos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `votos`
--
ALTER TABLE `votos`
  ADD CONSTRAINT `idChapa` FOREIGN KEY (`idChapa`) REFERENCES `chapas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `idVotante_Voto` FOREIGN KEY (`idVotante`) REFERENCES `alunos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
