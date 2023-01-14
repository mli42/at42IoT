DEBIAN_ISO := debian-11.6.0-amd64-netinst.iso
DEBIAN_URL := https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/${DEBIAN_ISO}
QEMU_HDA := iot.qcow2
NPROC := ${shell nproc}

.PHONY: all
all: ${DEBIAN_ISO} ${QEMU_HDA}
	qemu-system-x86_64 -cdrom ${DEBIAN_ISO} \
		-hda ${QEMU_HDA} \
		-enable-kvm \
		-machine q35 \
		-cpu host \
		-m 12G \
		-smp ${NPROC} \
		-net user,hostfwd=tcp::5000-:22,hostfwd=tcp::8080-:80 \
		-net nic &

${DEBIAN_ISO}:
	curl -L ${DEBIAN_URL} -o $@

${QEMU_HDA}:
	qemu-img create -f qcow2 $@ 20G
