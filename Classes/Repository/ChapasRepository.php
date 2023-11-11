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
        if (is_numeric($dados['Id']) && is_numeric($dados['IdLider']) && is_numeric($dados['IdVice']) && is_numeric($dados['IdTurma'])) {
            $consultaInsert = 'INSERT INTO ' . self::TABELA . ' (id, idLider, idVice, idTurma) VALUES (:id, :lider, :vice, :turma)';
            $stmt = $this->Database->getDb()->prepare($consultaInsert);
            $stmt->bindValue(':id', $dados['id'], \PDO::PARAM_INT);
            $stmt->bindValue(':lider', $dados['IdLider'], \PDO::PARAM_INT);
            $stmt->bindValue(':vice', $dados['IdVice'], \PDO::PARAM_INT);
            $stmt->bindValue(':turma', $dados['IdTurma'], \PDO::PARAM_INT);

            try {
                $this->Database->getDb()->beginTransaction();
                $stmt->execute();
                if ($stmt->rowCount() > 0) {
                    $this->Database->getDb()->commit();
                    return ConstantesGenericasUtil::MSG_REGISTRO_SUCESSO;
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
        $consultaUpdate = 'UPDATE ' . self::TABELA . ' SET idLider = :lider, idVice = :vice, idTurma = :turma WHERE id = :id';
        $stmt = $this->Database->getDb()->prepare($consultaUpdate);
        $stmt->bindValue(':id', $id);
        $stmt->bindValue(':lider', $dados['IdLider'], \PDO::PARAM_INT);
        $stmt->bindValue(':vice', $dados['IdVice'], \PDO::PARAM_INT);
        $stmt->bindValue(':turma', $dados['IdTurma'], \PDO::PARAM_INT);
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