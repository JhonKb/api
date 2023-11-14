<?php

namespace Service;

use Repository\ChapasRepository;
use Util\ConstantesGenericasUtil;
use Util\ServiceGeneric;

/**
 * Classe que representa os serviços da tabela chapas
 * Extende de ServicosGeneric
 * @author jhon klebson
 */
class ChapasService extends ServiceGeneric
{
    /**
     * Tabela chapas
     */
    public const TABELA = 'chapas';

    /**
     * Repositório da tabela chapas
     */
    private object $ChapasRepository;

    /**
     * ChapasService constructor.
     */
    public function __construct($dados = [])
    {
        $this->ChapasRepository = new ChapasRepository();
        parent::__construct($dados, $this->ChapasRepository, self::TABELA);
    }

    /**
     * Valida a chave estrangeira da tabela chapas
     * @param mixed $dados
     * @return mixed
     */
    protected function verificarChaveEstrangeira($dados)
    {
        try {
            $this->ChapasRepository->getDatabase()->getOneByKey('turmas', $dados['IdTurma']);
        } catch (\Exception $e) {
            throw new \InvalidArgumentException(ConstantesGenericasUtil::MSG_ERRO_CHAVE_ESTRANGEIRA);
        }
        if ($this->verificarAlunos($dados)) {
            return true;
        }
    }

    /**
     * Verifica se os alunos são a mesma pessoa
     * Verifica se ambos fazem parte da mesma turma da chapa
     * @param mixed $dados
     * @return mixed
     */
    private function verificarAlunos($dados)
    {
        $a1 = false;
        $a2 = false;
        $lider = $dados['IdLider'];
        $vice = $dados['IdVice'];
        $turma = $dados['IdTurma'];
        if ($lider !== $vice) {
            $array = $this->ChapasRepository->getDatabase()->getAll('alunos');
            foreach ($array as $aluno) {
                if ($aluno['id'] === $lider && $aluno['idTurma'] === $turma) {
                    $a1 = true;
                } else if ($aluno['id'] === $vice && $aluno['idTurma'] === $turma) {
                    $a2 = true;
                }
            }
            if ($a1 && $a2) {
                return true;
            }
            throw new \InvalidArgumentException('O aluno informado não existe ou não pertence a esta turma!');
        }
        throw new \InvalidArgumentException('Aluno duplicado na chapa!');
    }
}
