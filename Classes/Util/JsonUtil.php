<?php

namespace Util;

use InvalidArgumentException;
use JsonException;

/**
 * Classe utilitária
 * Processa e converte dados Json
 * @author jhon klebson
 */
class JsonUtil
{
    /**
     * Valida os dados recebidos 
     * @param mixed $retorno
     */
    public function processarArrayJson($retorno)
    {
        $dados = [];

        if ((is_array($retorno) && count($retorno) > 0) || strlen($retorno) > 10) {
            $dados[ConstantesGenericasUtil::TIPO] = ConstantesGenericasUtil::TIPO_SUCESSO;
            $dados[ConstantesGenericasUtil::RESPOSTA] = $retorno;
        }

        $this->retornarJson($dados);
    }

    /**
     * Insere informações no cabeçalho
     * Transforma o array de dados recebidos em Json
     */
    private function retornarJson($json)
    {
        header('Content-Type: application/json');
        header('Cache-Control: no-cache, no-store, must-revalidate');
        header('Access-Control-Allow-Methods: GET,POST,PUT,DELETE');
        echo json_encode($json);
        exit;
    }

    /**
     * Trata os dados inseridos pelo usuário
     * Transforma de Json para um array de strings
     * @return array
     */
    public static function tratarCorpoRequisicaoJson()
    {
        try {
            $postJson = json_decode(file_get_contents('php://input'), true, 512, JSON_THROW_ON_ERROR);
        } catch (JsonException $e) {
            throw new InvalidArgumentException(ConstantesGenericasUtil::MSG_ERR0_JSON_VAZIO);
        }

        if (is_array($postJson) && count($postJson) > 0) {
            return $postJson;
        }
    }
}
