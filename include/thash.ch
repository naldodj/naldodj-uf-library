/*
 * Header file for tHash() class
 *
 * Copyright 1999 {Marinaldo de Jesus and marinaldo DOT jesus AT gmail DOT com}
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2, or (at your option)
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; see the file LICENSE.txt.  If not, write to
 * the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301 USA (or visit https://www.gnu.org/licenses/).
 *
 * As a special exception, the Harbour Project gives permission for
 * additional uses of the text contained in its release of Harbour.
 *
 * The exception is that, if you link the Harbour libraries with other
 * files to produce an executable, this does not by itself cause the
 * resulting executable to be covered by the GNU General Public License.
 * Your use of that executable is in no way restricted on account of
 * linking the Harbour library code into it.
 *
 * This exception does not however invalidate any other reasons why
 * the executable file might be covered by the GNU General Public License.
 *
 * This exception applies only to the code released by the Harbour
 * Project under the name Harbour.  If you copy code from other
 * Harbour Project or Free Software Foundation releases into a copy of
 * Harbour, as the General Public License permits, the exception does
 * not apply to the code that you add in this way.  To avoid misleading
 * anyone as to the status of such modified files, you must delete
 * this exception notice from them.
 *
 * If you write modifications of your own for Harbour, it is your choice
 * whether to permit this exception to apply to your modifications.
 * If you do not wish that, delete this exception notice.
 *
 */

#IFNDEF _THASH_CH

    #DEFINE _THASH_CH

    /*/
        Arquivo:thash.ch
        Autor:Marinaldo de Jesus
        Data:04/12/2011
        Descricao:Arquivo de Cabecalho utilizado na Classe THASH e derivadas
        Sintaxe:#include "thash.ch"
    /*/

    #DEFINE HASH_SECTION_POSITION  1
    #DEFINE HASH_PROPERTY_POSITION 2

    #DEFINE HASH_PROPERTY_KEY      1
    #DEFINE HASH_PROPERTY_VALUE    2
    #DEFINE HASH_PROPERTY_FILE     3
    #DEFINE HASH_PROPERTY_TYPE     4
    #DEFINE HASH_PROPERTY_CLSNAME  5

    #DEFINE HASH_PROPERTY_ELEMENTS 5

    #DEFINE SECTION_POSITION       HASH_SECTION_POSITION
    #DEFINE PROPERTY_POSITION      HASH_PROPERTY_POSITION

    #DEFINE PROPERTY_KEY           HASH_PROPERTY_KEY
    #DEFINE PROPERTY_VALUE         HASH_PROPERTY_VALUE
    #DEFINE PROPERTY_FILE          HASH_PROPERTY_FILE
    #DEFINE PROPERTY_TYPE          HASH_PROPERTY_TYPE
    #DEFINE PROPERTY_CLSNAME       HASH_PROPERTY_CLSNAME

    #DEFINE PROPERTY_ELEMENTS      HASH_PROPERTY_ELEMENTS

    #DEFINE HASH_KEY_POS        1
    #DEFINE HASH_KEY_INDEX      2
    #DEFINE HASH_KEY_ELEMENTS   2

    #DEFINE HASH_KEY_SIZE       6

    #ifndef __NToS
        #define __NToS
        /*#xtranslate [<n,...>])=>LTrim(Str([<n>]))*/
    #endif

    #ifndef __CLS_NAME_THASH
        #define __CLS_NAME_THASH
        #define CLS_NAME_THASH "|DNA.TECH.JSONHASH|DNA.TECH.JSONARRAY|DNA.TECH.THASH|DNA.TECH.TFINI|DNA.TECH.THASH_TFINI|"
    #endif

#ENDIF
