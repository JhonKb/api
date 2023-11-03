<?php

use Util\ConstantesGenericasUtil;
use Util\JsonUtil;
use Validator\RequestValidator;
use Util\RotasUtil;

include 'config.php';

/**
 * Trata os dados recebidos
 * Dispara os erros e as mensagens
 * @author jhon klebson
 */
try {
    $ResquestValidator = new RequestValidator(RotasUtil::getRotas());
    $retorno = $ResquestValidator->processarRequest();

    $JsonUtil = new JsonUtil();
    $JsonUtil->processarArrayJson($retorno);
} catch (Exception $e) {
    echo  json_encode([
        ConstantesGenericasUtil::TIPO => ConstantesGenericasUtil::TIPO_ERRO,
        ConstantesGenericasUtil::RESPOSTA => $e->getMessage()
    ]);
    exit;
}