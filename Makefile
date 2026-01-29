dependencies:
	sudo apt-get install -y git make pip python npm node cargo ripgrep

docker-build:
	docker build -t akvim .

docker-run:
	docker run -it akvim nvim
