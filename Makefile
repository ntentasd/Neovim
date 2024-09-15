push:
	@git add . && \
	git commit -m "Added some plugins" && \
	git push origin main

pull:
	@git pull origin main
