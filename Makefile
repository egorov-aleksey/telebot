PROJECT = telebot
PROJECT_DESCRIPTION = Telegram bot. Erlang edition.
PROJECT_VERSION = 0.1.0

DEPS = cowboy jsx
dep_cowboy_commit = master
dep_jsx_commit = master

include erlang.mk

start-app: all
	erl -pa ./ebin -eval "application:start($(PROJECT))"

start-app+ob: all
	erl -pa ./ebin -eval "application:start($(PROJECT)), observer:start()"
