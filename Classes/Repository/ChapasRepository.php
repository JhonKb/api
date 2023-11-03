<?php

namespace Repository;

use Database\Database;
use Util\ConstantesGenericasUtil;

/**
 * Classe que representa o repositório da tabela chapas
 * @author jhon klebson
 */
class ChapasRepository
{
    /**
     * Banco de dados
     */
    private object $Database;

    /**
     * Tabela chapas
     */
    private const TABELA = 'chapas';

    /**
     * ChapasRepository constructor.
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
    public function insertChapa($dados)
    {
        if (is_numeric($dados['matriculaLider']) && is_numeric($dados['matriculaVice']) && is_numeric($dados['idTurma'])) {
            $consultaInsert = 'INSERT INTO ' . self::TABELA . ' (matriculaLider, matriculaVice, idTurma) VALUES (:lider, :vice, :turma)';
            $stmt = $this->Database->getDb()->prepare($consultaInsert);
            $stmt->bindValue(':lider', $dados['matriculaLider'], \PDO::PARAM_INT);
            $stmt->bindValue(':vice', $dados['matriculaVice'], \PDO::PARAM_INT);
            $stmt->bindValue(':turma', $dados['idTurma'], \PDO::PARAM_INT);

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
     * @param $id
     * @param $dados
     * @return string
     */
    public function updateChapa($id, $dados)
    {
        $consultaUpdate = 'UPDATE ' . self::TABELA . ' SET matriculaLider = :lider, matriculaVice = :vice, idTurma = :turma WHERE id = :id';
        $stmt = $this->Database->getDb()->prepare($consultaUpdate);
        $stmt->bindValue(':id', $id);
        $stmt->bindValue(':lider', $dados['matriculaLider'], \PDO::PARAM_INT);
        $stmt->bindValue(':vice', $dados['matriculaVice'], \PDO::PARAM_INT);
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