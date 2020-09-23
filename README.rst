
*******************************************************
"Escrituração Fiscal Digital - EFDICMS IPI" - ON Mac OS
*******************************************************

O repositório consiste de um *Dockerfile* e um *docker-compose*
para executar o software Java,  "Escrituração Fiscal Digital - EFDICMS IPI", em um Mac OS utilizando Docker.

O sistema da receita é baixado pelo Dockerfile no "build"

    URL: http://www.receita.fazenda.gov.br/publico/programas/SpedPisCofinsPVA/EFDContribuicoes_linux_x64-4.0.1.jar

O Software da receita foi preparado para rodar em linux, e tem uma interface gráfica, então é necessário "expor" o X11 do Mac para que o software funcione no Docker, isso é feito atraves do XQuartz + socat.



Dependências
============

#. XQuartz: https://www.xquartz.org/
#. socat: https://formulae.brew.sh/formula/socat
#. Docker  / docker-compose


Instalação do *Xquartz* e do *socat*
====================================

Instale o Xquartz e reinicie o sistema

    .. note:: eu usei a instalação `.dmg` do projeto (site XQuartz).


Instale o socat

    .. code-block:: bash

        $> brew install socat


Para rodar a aplicação Docker com GUI
=====================================

.. code-block:: bash

    $>socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\"


.. note::
    Se der erro - `address already in use`:
        - pare o  XQuartz
        - restart o socat `socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\"`
        - reinicie o XQuartz

um docker com GUI para testar ...

.. code-block:: bash

    $> docker run -it -e  DISPLAY=192.168.15.10:0 gns3/xeyes

..


.. warning:: Não precisa desligar o FireWall do MAc OS.

..

.. warning:: Não precisa habilitar `xhost +${IP}` ou `xhost local:root`


Para Executar via docker-compose
================================

.. code-block:: bash

    $> docker-compose up



Fontes consultadas
==================

- http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/
- https://medium.com/@kestenbroughton/running-guis-from-docker-on-osx-in-2019-e94b524f42bc
- https://www.youtube.com/watch?v=PKyj8sbZNYw




