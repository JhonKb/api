-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 11/11/2023 às 22:42
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
  `matriculaAluno` varchar(8) NOT NULL,
  `idTurma` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `alunos`
--

INSERT INTO `alunos` (`id`, `nomeAluno`, `matriculaAluno`, `idTurma`) VALUES
(1, 'João Turma2', '20000001', 2),
(2, 'Maria Turma2', '20000002', 2),
(3, 'José Turma2', '20000003', 2),
(4, 'Ana Turma2', '20000004', 2),
(5, 'Pedro Turma2', '20000005', 2),
(6, 'Laura Turma2', '20000006', 2),
(7, 'Carlos Turma2', '20000007', 2),
(8, 'Mariana Turma2', '20000008', 2),
(9, 'Lucas Turma2', '20000009', 2),
(10, 'Beatriz Turma2', '20000010', 2),
(11, 'João Turma3', '20000011', 3),
(12, 'Maria Turma3', '20000012', 3),
(13, 'José Turma3', '20000013', 3),
(14, 'Ana Turma3', '20000014', 3),
(15, 'Pedro Turma3', '20000015', 3),
(16, 'Laura Turma3', '20000016', 3),
(17, 'Carlos Turma3', '20000017', 3),
(18, 'Mariana Turma3', '20000018', 3),
(19, 'Lucas Turma3', '20000019', 3),
(20, 'Beatriz Turma3', '20000020', 3),
(21, 'João Turma4', '20000021', 4),
(22, 'Maria Turma4', '20000022', 4),
(23, 'José Turma4', '20000023', 4),
(24, 'Ana Turma4', '20000024', 4),
(25, 'Pedro Turma4', '20000025', 4),
(26, 'Laura Turma4', '20000026', 4),
(27, 'Carlos Turma4', '20000027', 4),
(28, 'Mariana Turma4', '20000028', 4),
(29, 'Lucas Turma4', '20000029', 4),
(30, 'Beatriz Turma4', '20000030', 4),
(31, 'João Turma5', '20000031', 5),
(32, 'Maria Turma5', '20000032', 5),
(33, 'José Turma5', '20000033', 5),
(34, 'Ana Turma5', '20000034', 5),
(35, 'Pedro Turma5', '20000035', 5),
(36, 'Laura Turma5', '20000036', 5),
(37, 'Carlos Turma5', '20000037', 5),
(38, 'Mariana Turma5', '20000038', 5),
(39, 'Lucas Turma5', '20000039', 5),
(40, 'Beatriz Turma5', '20000040', 5);

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
(11, 2, 1, 2),
(12, 2, 3, 4),
(13, 2, 5, 6),
(17, 4, 21, 22),
(21, 5, 33, 34),
(22, 5, 35, 36),
(29, 4, 25, 26),
(38, 4, 23, 24),
(40, 5, 31, 32),
(41, 3, 11, 12),
(52, 3, 13, 14),
(63, 3, 15, 16);

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
(6, 'Direito 3/4', 'Direito'),
(7, 'Enfermagem 1/2', 'Enfermagem'),
(8, 'Enfermagem 3/4', 'Enfermagem'),
(9, 'Psicologia 5/6', 'Psicologia'),
(10, 'ADS 5', 'ADS'),
(11, 'Direito 5/6', 'Direito'),
(12, 'Enfermagem 5/6', 'Enfermagem'),
(13, 'Psicologia 7/8', 'Psicologia'),
(14, 'Direito 7/8', 'Direito'),
(15, 'Enfermagem 7/8', 'Enfermagem'),
(16, 'Psicologia 9/10', 'Psicologia'),
(17, 'Direito 9/10', 'Direito'),
(18, 'Enfermagem 9/10', 'Enfermagem');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT de tabela `turmas`
--
ALTER TABLE `turmas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

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
