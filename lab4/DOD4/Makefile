# Создание и запуск контейнеров
build:
	docker-compose up --build -d

# Запуск 500 запросов для проверки балансировки
run:
	@echo "Отправка 500 запросов..."
	@for i in $$(seq 1 500); do \
		curl -sSL -q http://127.0.0.1/; \
	done | grep -E 'haproxy s[ab]!' | sort | uniq -c
	@echo "Запросы обработаны."

# Удаление контейнеров
clean:
	@echo "Удаление контейнеров..."
	docker rm -f sa sb haproxy
	@echo "Контейнеры удалены."

# Основная цель
all: build run