<?php

namespace Repository;

use Database\Database;
use Util\ConstantesGenericasUtil;

/**
 * Classe que representa o repositório da tabela alunos
 * @author jhon klebson
 */
class AlunosRepository
{
    /**
     * Banco de dados
     */
    private object $Database;

    /**
     * Tabela alunos
     */
    private const TABELA = 'alunos';

    /**
     * AlunosRepository constructor.
     */
    public function __construct()
    {
        $this->Database = new Database();
    }

    /**
     * @return object|Database
     */
    public function getDatabase()
    {
        return $this->Database;
    }

    /**
     * Query de inserção
     * @param mixed $dados
     * @return mixed
     */
    public function insertAluno($dados)
    {
        if (!empty($dados['NomeAluno']) && !empty($dados['MatriculaAluno']) && is_numeric($dados['IdTurma'])) {
            $consultaInsert = 'INSERT INTO ' . self::TABELA . ' (nomeAluno, matriculaAluno, idTurma) VALUES (:nome, :matricula, :turma)';
            $stmt = $this->Database->getDb()->prepare($consultaInsert);
            $stmt->bindValue(':nome', $dados['NomeAluno']);
            $stmt->bindValue(':matricula', $dados['MatriculaAluno']);
            $stmt->bindValue(':turma', $dados['IdTurma'], \PDO::PARAM_INT);

            try {
                $this->Database->getDb()->beginTransaction();
                $stmt->execute();
                $idInserido = $this->Database->getDb()->lastInsertId();
                if ($stmt->rowCount() > 0) {
                    $this->Database->getDb()->commit();
                    return $idInserido;
                }
            } catch (\Exception $e) {
                $this->Database->getDb()->rollBack();
                throw new \InvalidArgumentException(ConstantesGenericasUtil::MSG_ERRO_GENERICO);
            }
        }
        throw new \InvalidArgumentException(ConstantesGenericasUtil::MSG_ERRO_DADOS_OBRIGATORIOS);
    }


    /**
     * Query de update
     * @param mixed $id
     * @param mixed $dados
     * @return string
     */
    public function updateAluno($id, $dados)
    {
        $consultaUpdate = 'UPDATE ' . self::TABELA . ' SET nomeAluno = :nome, matriculaAluno = :matricula, idTurma = :turma WHERE id = :id';
        $stmt = $this->Database->getDb()->prepare($consultaUpdate);
        $stmt->bindValue(':id', $id);
        $stmt->bindValue(':nome', $dados['nomeAluno']);
        $stmt->bindValue(':matricula', $dados['matriculaAluno']);
        $stmt->bindValue(':turma', $dados['idTurma'], \PDO::PARAM_INT);
        try {
            $this->Database->getDb()->beginTransaction();
            $stmt->execute();
            if ($stmt->rowCount() > 0) {
                $this->Database->getDb()->commit();
                return ConstantesGenericasUtil::MSG_ATUALIZADO_SUCESSO;
            }
        } catch (\Exception $e) {
            $this->Database->getDb()->rollBack();
            throw new \InvalidArgumentException(ConstantesGenericasUtil::MSG_ERRO_GENERICO);
        }
    }
}