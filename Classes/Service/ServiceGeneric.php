<?php

namespace Service;

use InvalidArgumentException;
use Repository\ChapasRepository;
use Util\ConstantesGenericasUtil;

/**
 * Classe abstrata de serviços genéricos
 * @author jhon klebson
 */
abstract class ServiceGeneric
{
    /**
     * Dados da uri
     */
    private array $dados;

    /**
     * Dados inseridos pelo usuário
     */
    private array $dadosCorpoRequest = [];

    /**
     * Repositório genérico
     */
    private object $repository;

    /**
     * Tabela genérica
     */
    private $tabela;

    /**
     * ServiceGeneric constructor
     */
    public function __construct($dados = [], $repository, $tabela)
    {
        $this->dados = $dados;
        $this->repository = $repository;
        $this->tabela = $tabela;
    }

    /**
     * Função abstrata para verificar chave estrangeira
     * @param mixed $dados
     */
    abstract protected function verificarChaveEstrangeira($dados);

    /**
     * Valida se retorno é vazio
     * @param mixed $retorno
     * @return void
     */
    private function validarRetornoRequest($retorno)
    {
        if ($retorno === null) {
            throw new InvalidArgumentException(ConstantesGenericasUtil::MSG_ERRO_GENERICO);
        }
    }

    /**
     * Valida se o id foi informado
     * @param mixed $recurso
     * @return mixed
     */
    private function validarIdObrigatorio($recurso)
    {
        if ($this->dados['id'] > 0) {
            $retorno = $this->$recurso();
        } else {
            throw new InvalidArgumentException(ConstantesGenericasUtil::MSG_ERRO_ID_OBRIGATORIO);
        }
        return $retorno;
    }

    /**
     * Seta os dados inseridos pelo usuário
     * @param mixed $dadosRequest
     * @return void
     */
    public function setDadosCorpoRequest($dadosRequest)
    {
        $this->dadosCorpoRequest = $dadosRequest;
    }

    /**
     * Valida o método get
     * @return mixed
     */
    public function validarGet()
    {
        $retorno = null;
        $recurso = $this->dados['recurso'];
        if (in_array($recurso, ConstantesGenericasUtil::RECURSO_GET, true)) {
            $retorno = $this->dados['id'] > 0 ? $this->getOneByKey() : $this->$recurso();
        } else {
            throw new InvalidArgumentException(ConstantesGenericasUtil::MSG_ERRO_RECURSO_INEXISTENTE);
        }
        $this->validarRetornoRequest($retorno);
        return $retorno;
    }

    /**
     * Valida o método delete
     * @return mixed
     */
    public function validarDelete()
    {
        $retorno = null;
        $recurso = $this->dados['recurso'];
        if (in_array($recurso, ConstantesGenericasUtil::RECURSO_DELETE, true)) {
            $retorno = $this->validarIdObrigatorio($recurso);
        } else {
            throw new InvalidArgumentException(ConstantesGenericasUtil::MSG_ERRO_RECURSO_INEXISTENTE);
        }
        $this->validarRetornoRequest($retorno);
        return $retorno;
    }

    /**
     * Valida o método post
     * @return mixed
     */
    public function validarPost()
    {
        $retorno = null;
        $recurso = $this->dados['recurso'];
        if (in_array($recurso, ConstantesGenericasUtil::RECURSO_POST, true)) {
            if($this->verificarChaveEstrangeira($this->dadosCorpoRequest)) {
                $retorno = $this->$recurso();
            }
        } else {
            throw new InvalidArgumentException(ConstantesGenericasUtil::MSG_ERRO_RECURSO_INEXISTENTE);
        }
        $this->validarRetornoRequest($retorno);
        return $retorno;
    }

    /**
     * Valida o método put
     * @return mixed
     */
    public function validarPut()
    {
        $retorno = null;
        $recurso = $this->dados['recurso'];
        if (in_array($recurso, ConstantesGenericasUtil::RECURSO_PUT, true)) {
            if($this->verificarChaveEstrangeira($this->dadosCorpoRequest)) {
                $retorno = $this->validarIdObrigatorio($recurso);
            }
        } else {
            throw new InvalidArgumentException(ConstantesGenericasUtil::MSG_ERRO_RECURSO_INEXISTENTE);
        }
        $this->validarRetornoRequest($retorno);
        return $retorno;
    }

    /**
     * @return mixed
     */
    private function getOneByKey()
    {
        return $this->repository->getDatabase()->getOneByKey($this->tabela, $this->dados['id']);
    }

    /**
     * Recurso listar
     * @return array
     */
    private function listar()
    {
        return $this->repository->getDatabase()->getAll($this->tabela);
    }

    /**
     * Recurso deletar
     * @return string
     */
    private function deletar()
    {
        return $this->repository->getDatabase()->delete($this->tabela, $this->dados['id']);
    }

    /**
     * Recurso cadastrar
     * @return mixed
     */
    private function cadastrar()
    {
        //Transforma no método insert do repositório da tabela informada
        $insert = 'insert'.rtrim(ucfirst($this->tabela), "s");
            return ['id_Inserido' => $this->repository->$insert($this->dadosCorpoRequest)];
    }

    /**
     * Recurso atualizar
     * @return mixed
     */
    private function atualizar()
    {
        //Transforma no método update do repositório da tabela informada
        $update = 'update'.rtrim(ucfirst($this->tabela), "s");
        return $this->repository->$update($this->dados['id'], $this->dadosCorpoRequest);
    }
}