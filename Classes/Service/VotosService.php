<?php

namespace Service;

use Repository\VotosRepository;
use Util\ConstantesGenericasUtil;

/**
 * Classe que representa os serviços da tabela votos
 * Extende de ServicosGeneric
 * @author jhon klebson
 */
class VotosService extends ServiceGeneric
{
    /**
     * Tabela votos
     */
    public const TABELA = 'votos';

    /**
     * Repostório da tabela votos
     */
    private object $VotosRepository;

    /**
     * VotosService constructor.
     */
    public function __construct($dados = [])
    {
        $this->VotosRepository = new VotosRepository();
        parent::__construct($dados, $this->VotosRepository, self::TABELA);
    }

    /**
     * Valida as chaves estrangeiras da tabela votos
     * @param mixed $dados
     * @return mixed
     */
    protected function verificarChaveEstrangeira($dados)
    {
        try {
            $chapa = $this->VotosRepository->getDatabase()->getOneByKey('chapas', $dados['idChapa']);
        } catch (\Exception $e) {
            throw new \InvalidArgumentException(ConstantesGenericasUtil::MSG_ERRO_CHAVE_ESTRANGEIRA);
        }
        if ($this->verificarAluno($dados, $chapa)) {
            return true;
        }
    }

    /**
     * Verifica se matricula e nome pertecem ao mesmo aluno
     * Verifica se aluno pertence a mesma turma da chapa
     * @param mixed $dados
     * @return mixed
     */
    private function verificarAluno($dados, $chapa)
    {
        $votante = $dados['idVotante'];
        $alunos = $this->VotosRepository->getDatabase()->getAll('alunos');
        foreach ($alunos as $aluno) {
            if ($aluno['id'] === $votante) {
                if ($aluno['idTurma'] === $chapa['idTurma']) {
                    return true;
                }
                throw new \InvalidArgumentException('Turmas de aluno e chapa não correspondem!');
            }
            throw new \InvalidArgumentException('Aluno não existe!');
        }
    }
}