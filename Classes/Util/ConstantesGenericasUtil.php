<?php

namespace Util;

/**
 * Classe abstrata com constantes gnéricas
 * @author jhon klebson
 */
abstract class ConstantesGenericasUtil
{
    /* REQUESTS */
    public const TIPO_REQUEST = ['GET', 'POST', 'DELETE', 'PUT'];
    
    /* RECURSOS */
    public const RECURSO_GET = ['listar'];
    public const RECURSO_DELETE = ['deletar'];
    public const RECURSO_POST = ['cadastrar'];
    public const RECURSO_PUT = ['atualizar'];

    /* ERROS */
    public const MSG_ERRO_TIPO_METODO = 'Método não permitido!';
    public const MSG_ERRO_TIPO_ROTA = 'Rota não permitida!';
    public const MSG_ERRO_RECURSO_INEXISTENTE = 'Recurso inexistente!';
    public const MSG_ERRO_GENERICO = 'Algum erro ocorreu na requisição!';
    public const MSG_ERRO_SEM_RETORNO = 'Nenhum registro encontrado!';
    public const MSG_ERRO_NAO_AFETADO = 'Nenhum registro afetado!';
    public const MSG_ERR0_JSON_VAZIO = 'O Corpo da requisição não pode ser vazio!';
    public const MSG_ERRO_ID_OBRIGATORIO = 'ID é obrigatório!';
    public const MSG_ERRO_DADOS_OBRIGATORIOS = 'Todos os dados são obrigatórios!';
    public const MSG_ERRO_CHAVE_ESTRANGEIRA = 'O ID da chave estrangeira não existe!';

    /* SUCESSO */
    public const MSG_REGISTRO_SUCESSO = 'Registrado com sucesso!';
    public const MSG_DELETADO_SUCESSO = 'Registro deletado com Sucesso!';
    public const MSG_ATUALIZADO_SUCESSO = 'Registro atualizado com Sucesso!';


    /* RETORNO JSON */
    const TIPO_SUCESSO = 'sucesso';
    const TIPO_ERRO = 'erro';

    /* OUTRAS */
    public const TIPO = 'tipo';
    public const RESPOSTA = 'resposta';
}