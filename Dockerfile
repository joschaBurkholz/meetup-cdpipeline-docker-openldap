FROM debian:jessie

MAINTAINER Joscha Burkholz <joscha.burkholz@mgx.de>

ENV OPENLDAP_VERSION 2.4.40

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
        slapd=${OPENLDAP_VERSION}* ldap-utils=${OPENLDAP_VERSION}* && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mv /etc/ldap /etc/ldap.dist

EXPOSE 389

VOLUME ["/etc/ldap", "/var/lib/ldap"]

COPY modules/ /etc/ldap.dist/modules

COPY entrypoint.sh /entrypoint.sh
COPY load-devteam-ldif.sh /load-devteam-ldif.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["slapd", "-d", "32768", "-u", "openldap", "-g", "openldap"]
