all: up

up: shared
	vagrant up

shared:
	mkdir $@

ps:
	vagrant status

down:
	vagrant halt

clean:
	vagrant destroy -f

reload: clean up
