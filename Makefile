default:
	echo targets: run build publish heroku
run:
	plumb http://localhost:8080/
	docker run -p 8080:8080 -it mehlon/tryplan9
build:
	docker build -t mehlon/tryplan9 .
publish:
	docker push mehlon/tryplan9

APPNAME=tryplan9front
heroku:
	heroku container:push web -a $(APPNAME)
	heroku container:release web -a $(APPNAME)

