# Путь к директориям и файлам
INVENTORY_FILE = inventory/hosts.yml
PLAYBOOK_FILE = playbooks/gather_system_info.yml

# Создание или запуск контейнеров
build:
	@echo "Создание и запуск контейнеров..."
	docker start container1 || docker create --name container1 --hostname container1 -p 2222:22 ssh-enabled-ubuntu
	docker start container2 || docker create --name container2 --hostname container2 -p 2223:22 ssh-enabled-ubuntu
	@echo "Контейнеры созданы и запущены."

# Запуск плейбука Ansible
run:
	@echo "Запуск плейбука Ansible..."
	ansible-playbook -i $(INVENTORY_FILE) $(PLAYBOOK_FILE)
	@echo "Плейбук выполнен."

# Демонстрация выполнения команды ansible -m ping
demo:
	@echo "Демонстрация выполнения команды ansible -m ping..."
	ansible -i $(INVENTORY_FILE) -m ping container1,container2
	@echo "Демонстрация выполнения команды ansible -m shell для получения hostname..."
	ansible -i $(INVENTORY_FILE) -m shell -a "hostname" container1,container2

# Удаление контейнеров
clean:
	@echo "Удаление контейнеров..."
	docker rm -f container1 container2 || true
	@echo "Контейнеры удалены."

# Основная цель (все шаги)
all: build-containers run-playbook
