all: up

up: shared
	vagrant up

shared:
	mkdir $@

ps:
	vagrant status

down:
	vagrant halt

ssh-server:
	vagrant ssh mliS

ssh-agent:
	vagrant ssh mliSW

clean:
	vagrant destroy -f

reload: clean up
