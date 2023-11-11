<?php

namespace Service;

use Repository\AlunosRepository;
use Util\ConstantesGenericasUtil;

/**
 * Classe que representa os serviços da tabela alunos
 * Extende de ServicosGeneric
 * @author jhon klebson
 */
class AlunosService extends ServiceGeneric
{
    /**
     * Tabela alunos
     */
    public const TABELA = 'alunos';

    /**
     * Repositório da tabela alunos
     */
    private object $AlunosRepository;

    /**
     * AlunosService constructor.
     */
    public function __construct($dados = [])
    {
        $this->AlunosRepository = new AlunosRepository();
        parent::__construct($dados, $this->AlunosRepository, self::TABELA);
    }

    /**
     * Valida a chave estrangeiras da tabela alunos
     * @param mixed $dados
     * @return mixed
     */
    protected function verificarChaveEstrangeira($dados)
    {
        try {
            $this->AlunosRepository->getDatabase()->getOneByKey('turmas', $dados['IdTurma']);
            return true;
        } catch (\Exception $e) {
            throw new \InvalidArgumentException(ConstantesGenericasUtil::MSG_ERRO_CHAVE_ESTRANGEIRA);
        }
    }
}
