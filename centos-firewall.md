
Use this command to find your active zone(s):

```bash
firewall-cmd --get-active-zones
```

It will say either public, dmz, or something else. You should only apply to the zones required.

In the case of dmz try:

```bash
firewall-cmd --zone=dmz --add-port=2888/tcp --permanent
```

Otherwise, substitute dmz for your zone, for example, if your zone is public:

```bash
firewall-cmd --zone=public --add-port=2888/tcp --permanent
```

Then remember to reload the firewall for changes to take effect.

```bash
firewall-cmd --reload
```

[source link](https://stackoverflow.com/questions/24729024/centos-7-open-firewall-port#24729895)
