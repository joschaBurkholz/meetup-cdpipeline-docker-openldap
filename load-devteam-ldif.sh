#!/bin/bash

ldapadd -c -x -D "cn=admin,dc=example,dc=de" -w secret -H ldap://127.0.0.1 -f /etc/ldap/modules/devteam.ldif
