<?php

namespace Validator;

use InvalidArgumentException;
use Service\AlunosService;
use Service\ChapasService;
use Util\ConstantesGenericasUtil;
use Util\JsonUtil;
use Service\TurmasService;
use Service\VotosService;

/**
 * Classe de validação
 * Valida e direciona a requisição
 * @author jhon klebson
 */
class RequestValidator
{
    private $request;
    private array $dadosRequest;

    const GET = 'GET';
    const DELETE = 'DELETE';

    /**
     * ReuestValidator construct
     */
    public function __construct($request)
    {
        $this->request = $request;
    }

    /**
     * Processa a requisição
     * Verifica o método da requisição
     * @return mixed
     */
    public function processarRequest()
    {
        $retorno = ConstantesGenericasUtil::MSG_ERRO_TIPO_METODO;

        if (in_array($this->request['metodo'], ConstantesGenericasUtil::TIPO_REQUEST, true)) {
            $retorno = $this->direcionarRequest();
        }
        return $retorno;
    }

    /**
     * Direciona a requisição para a rota especificada
     * @return mixed
     */
    private function direcionarRequest()
    {
        if($this->request['metodo'] !== self::GET && $this->request['metodo'] !== self::DELETE) {
            $this->dadosRequest = JsonUtil::tratarCorpoRequisicaoJson();
        }
        switch($this->request['rota']) {
            case 'turmas':
                $service = new TurmasService($this->request);
                break;
            case 'alunos':
                $service = new AlunosService($this->request);
                break;
            case 'chapas':
                $service = new ChapasService($this->request);
                break;
            case 'votos':
                $service = new VotosService($this->request);
                break;
            default:
                throw new InvalidArgumentException(ConstantesGenericasUtil::MSG_ERRO_TIPO_ROTA);
                break;
        }
        $metodo = $this->request['metodo'];
        return $this->$metodo($service);
    }

    /**
     * Método get
     * @param object $service
     * @return mixed
     */
    public function get($service)
    {
        return $service->validarGet();
    }

    /**
     * Método delete
     * @param object $service
     * @return mixed
     */
    public function delete($service)
    {
        return $service->validarDelete();
    }

    /**
     * Método post
     * @param object $service
     * @return mixed
     */
    public function post($service) {
        $service->setDadosCorpoRequest($this->dadosRequest);
        return $service->validarPost();
    }

    /**
     * Método put
     * @param object $service
     * @return mixed
     */
    public function put($service) {
        $service->setDadosCorpoRequest($this->dadosRequest);
        return $service->validarPut();
    } 
}
