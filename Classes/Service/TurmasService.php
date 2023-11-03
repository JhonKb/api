<?php

namespace Service;

use Repository\TurmasRepository;

/**
 * Classe que representa os serviços da tabela turmas
 * Extende de ServicosGeneric
 * @author jhon klebson
 */
class TurmasService extends ServiceGeneric
{
    public const TABELA = 'turmas';

    private object $TurmasRepository;

    /**
     * TurmasService constructor.
     */
    public function __construct($dados = [])
    {
        $this->TurmasRepository = new TurmasRepository();
        parent::__construct($dados, $this->TurmasRepository, self::TABELA);
    }

    /**
     * NO ACTION
     * Tabela turmas não tem chave estrangeira
     */
    protected function verificarChaveEstrangeira($dados){}
}
