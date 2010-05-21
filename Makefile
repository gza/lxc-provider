#Lxc-provider
# make install root=/some/root

none:

install:
	[[ -f ${root} ]] || mkdir -p ${root}
	install --mode=750 -D -T bin/lxc-provider ${root}/usr/sbin/lxc-provider
	install --mode=750 -D -T bin/lxc-template ${root}/usr/sbin/lxc-template
	install -d ${root}/var/cache/lxc-provider ${root}/var/tmp/lxc-provider ${root}/var/lib/lxc-provider 
	
	install -d ${root}/etc/lxc-provider
	cp -r etc/* ${root}/etc/lxc-provider/
	
	install -d ${root}/usr/libexec/lxc-provider
	cp -r libexec/* ${root}/usr/libexec/lxc-provider/
	find ${root}/usr/libexec/lxc-provider/ -type f -exec chmod +x {} \;
	
uninstall:
	rm ${root}/usr/sbin/lxc-template
	rm ${root}/usr/sbin/lxc-provider
	rm -rf ${root}/var/cache/lxc-provider ${root}/var/tmp/lxc-provider ${root}/var/lib/lxc-provider
#	rm -rf ${root}/etc/lxc-provider
	rm -rf ${root}/usr/libexec/lxc-provider
	rm -rf ${root}/usr/share/doc/lxc-provider

.PHONY: install uninstall none 
