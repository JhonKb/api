<?php

namespace Util;

/**
 * Classe utilitária de rotas
 * Captura as urls e transforma em um array de dados
 * @author jhon klebson
 */
class RotasUtil
{
    /**
     * Atribui as keys de cada componente do array
     * @return array
     */
    public static function getRotas()
    {
        $urls = self::getUrls();
        $request = [];
        $request['rota'] = $urls[0];
        $request['id'] = $urls[1] ?? null;
        $request['metodo'] = $_SERVER['REQUEST_METHOD'];

        return $request;
    }

    /**
     * Separa a uri pelas barras(/)
     * @return array
     */
    public static function getUrls()
    {
        $uri = str_replace('/' . DIR_PROJETO, '', $_SERVER['REQUEST_URI']);
        return explode('/', trim($uri, '/'));
    }
}
