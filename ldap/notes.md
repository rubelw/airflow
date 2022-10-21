

```bash
git clone git@github.com:TalkingQuickly/kubernetes-sso-guide.git

cd kubernetes-sso-guide
helm upgrade --install openldap ./charts/openldap --values charts/openldap/values.yaml
Release "openldap" does not exist. Installing it now.
NAME: openldap
LAST DEPLOYED: Fri Oct 21 01:30:16 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
OpenLDAP has been installed. You can access the server from within the k8s cluster using:

  openldap.default.svc.cluster.local:389


You can access the LDAP adminPassword and configPassword using:

  kubectl get secret --namespace default openldap -o jsonpath="{.data.LDAP_ADMIN_PASSWORD}" | base64 --decode; echo
  kubectl get secret --namespace default openldap -o jsonpath="{.data.LDAP_CONFIG_PASSWORD}" | base64 --decode; echo


You can access the LDAP service, from within the cluster (or with kubectl port-forward) with a command like (replace password and domain):
  ldapsearch -x -H ldap://openldap.default.svc.cluster.local:389 -b dc=example,dc=org -D "cn=admin,dc=example,dc=org" -w $LDAP_ADMIN_PASSWORD


Test server health using Helm test:
  helm test openldap


You can also consider installing the helm chart for phpldapadmin to manage this instance of OpenLDAP, or install Apache Directory Studio, and connect using kubectl port-forward.



Bind DN or user: cn=admin,dc=ssotest,dc=staging,dc=talkingquickly,dc=co,dc=uk
Bind password: password
```


Add user

ldif
```bash
dn: uid=adam,ou=People,dc=ssotest,dc=staging,dc=talkingquickly,dc=co,dc=uk
objectClass: top
objectClass: account
objectClass: posixAccount
objectClass: shadowAccount
cn: adam
uid: adam
uidNumber: 16859
gidNumber: 100
homeDirectory: /home/adam
loginShell: /bin/bash
gecos: adam
userPassword: {crypt}x
shadowLastChange: 0
shadowMax: 0
shadowWarning: 0

```

```bash
 ldapadd -x -W -D "cn=admin,dc=ssotest,dc=staging,dc=talkingquickly,dc=co,dc=uk" -h localhost:3890 -f adam.ldif

```

Set ldap password

```bash
ldappasswd -s adam -W -D "cn=admin,dc=ssotest,dc=staging,dc=talkingquickly,dc=co,dc=uk" -x "uid=adam,ou=People,dc=ssotest,dc=staging,dc=talkingquickly,dc=co,dc=uk" -h localhost:3890
Enter LDAP Password:
```