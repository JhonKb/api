<?php

namespace Repository;

use Database\Database;
use Util\ConstantesGenericasUtil;

/**
 * Classe que representa o repositório da tabela turmas
 * @author jhon klebson
 */
class TurmasRepository
{
    /**
     * Banco de dados
     */
    private object $Database;

    /**
     * Tabela turmas
     */
    private const TABELA = 'turmas';

    /**
     * TurmasRepository constructor.
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
     * @return int
     */
    public function insertTurma($dados)
    {
        if (!empty($dados['nomeTurma']) && !empty($dados['cursoTurma'])) {
            $consultaInsert = 'INSERT INTO ' . self::TABELA . ' (nomeTurma, cursoTurma) VALUES (:nome, :curso, )';
            $stmt = $this->Database->getDb()->prepare($consultaInsert);
            $stmt->bindValue(':nome', $dados['nomeTurma']);
            $stmt->bindValue(':curso', $dados['cursoTurma']);

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
    public function updateTurma($id, $dados)
    {
        $consultaUpdate = 'UPDATE ' . self::TABELA . ' SET nomeTurma = :nome, cursoTurma = :curso WHERE id = :id';
        $stmt = $this->Database->getDb()->prepare($consultaUpdate);
        $stmt->bindValue(':id', $id);
        $stmt->bindValue(':nome', $dados['nomeTurma']);
        $stmt->bindValue(':curso', $dados['cursoTurma']);
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
