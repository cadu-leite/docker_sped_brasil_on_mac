FROM centos:7

RUN yum -y --setopt=protected_multilib=false install java-1.8.0-openjdk-devel which glibc.i686 libgcc.i686 \
    && rm -rf /var/cache/yum

RUN rpm -i http://li.nux.ro/download/nux/dextop/el7/x86_64/webcore-fonts-3.0-1.noarch.rpm \
    && mkdir -p /usr/lib/jvm/java-openjdk/lib/fonts \
    && cp /usr/share/fonts/webcore/* /usr/lib/jvm/java-openjdk/lib/fonts/

RUN curl http://www.receita.fazenda.gov.br/publico/programas/SpedPisCofinsPVA/EFDContribuicoes_linux_x64-4.0.0.jar --output /pva.jar
RUN adduser sped \
    && echo -e "1\n/home/sped/pva\nO\n1\nN\nN\nN" | java -jar /pva.jar \
    && chown -R sped:sped /home/sped \
    && cd /home/sped/pva/ \
    && tar zcf recursos.tgz recursos/

COPY docker-entrypoint.sh /home/sped/pva/

ENV JAVA_HOME /usr/lib/jvm/java-openjdk

USER sped

WORKDIR /home/sped/pva/


# build
# $> docker build -t sped_pva .


# A java application
# .. code-block:: bash
#     $> docker run -it  -e  DISPLAY=192.168.15.10:0 sped_pva


# também funciona com a variável de IP do host docker > 1.8
# .. code-block:: bash

#     $> docker run -it  -e  DISPLAY=host.docker.internal:0 gns3/xeyes


# dentro do container em execução ...

# $> java -jar efdcontribuicoes.jar


# fontes ...

# http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/
# https://medium.com/@kestenbroughton/running-guis-from-docker-on-osx-in-2019-e94b524f42bc
# https://www.youtube.com/watch?v=PKyj8sbZNYw



