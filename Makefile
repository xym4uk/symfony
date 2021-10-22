# Зеленый текст "printf"
_TITLE := "\033[32m[%s]\033[0m %s\n"

# Желтый текст "printf"
_INFO := "\033[33m%s\033[0m %s\n"

# Красный текст "printf"
_ERROR := "\033[31m[%s]\033[0m %s\n"

down:				## Остановка и удаление всех контейнеров Docker
	@printf $(_INFO) "Make: Останавливаем и удаляем все контейнеры Docker..."
	@docker-compose down
.PHONY: down

up:		##Запуск контейнеров
	@printf $(_INFO) "Make: Запускаем контейнеры"
	@docker-compose up -d
.PHONY: up