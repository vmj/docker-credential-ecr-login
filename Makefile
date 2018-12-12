IMAGE_TAG=0.2.0
GIT_TAG=v0.2.0

.PHONY=push
push: image
	docker image push vmj0/docker-credential-ecr-login:$(IMAGE_TAG)

.PHONY=image
image: docker/Dockerfile docker/docker-credential-ecr-login
	cd docker && docker image build -t vmj0/docker-credential-ecr-login:$(IMAGE_TAG) .

docker/docker-credential-ecr-login: src/bin/local/docker-credential-ecr-login
	cp $<  $@

src/bin/local/docker-credential-ecr-login: src
	make -C src docker

src:
	git clone git@github.com:awslabs/amazon-ecr-credential-helper.git src
	git -C src checkout -b build $(GIT_TAG)

.PHONY=clean
clean:
	rm -rf src docker/docker-credential-ecr-login

reallyclean:
	docker image rm vmj0/docker-credential-ecr-login:$(IMAGE_TAG)


