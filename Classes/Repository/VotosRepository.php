<?php

namespace Repository;

use Database\Database;
use Util\ConstantesGenericasUtil;

/**
 * Classe que representa o repositório da tabela votos
 * @author jhon klebson
 */
class VotosRepository
{
    /**
     * Banco de dados
     */
    private object $Database;

    /**
     * Tabela votos
     */
    private const TABELA = 'votos';

    /**
     * VotosRepository constructor.
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
    public function insertVoto($dados)
    {
        if (!empty($dados['nomeVoto']) && is_numeric($dados['matriculaVoto']) && is_numeric($dados['idChapa'])) {
            $consultaInsert = 'INSERT INTO ' . self::TABELA . ' (nomeVoto, matriculaVoto, idChapa) VALUES (:nome, :matricula, :chapa)';
            $stmt = $this->Database->getDb()->prepare($consultaInsert);
            $stmt->bindValue(':nome', $dados['nomeVoto']);
            $stmt->bindValue(':matricula', $dados['matriculaVoto'], \PDO::PARAM_INT);
            $stmt->bindValue(':chapa', $dados['idChapa'], \PDO::PARAM_INT);

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
        $consultaUpdate = 'UPDATE ' . self::TABELA . ' SET nomeVoto = :nome, matriculaVoto = :matricula, idChapa = :chapa WHERE id = :id';
        $stmt = $this->Database->getDb()->prepare($consultaUpdate);
        $stmt->bindValue(':id', $id);
        $stmt->bindValue(':nome', $dados['nomeVoto']);
        $stmt->bindValue(':matricula', $dados['matriculaVoto'], \PDO::PARAM_INT);
        $stmt->bindValue(':chapa', $dados['idChapa'], \PDO::PARAM_INT);
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