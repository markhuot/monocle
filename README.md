Monocle
====

role-leader

1. receive POST /walle REV, BRANCH
2. add to "to-build" queue...

role-builder

1. grab from "to-build" queue
2. clone (`./git-clone REPO_URL REV`)
3. parse Stackfile
	4. archive (`./archive PATH`)
	4. buildstep (`./buildstep APP_NAME BRANCH`)
	6. save the image (`.docker-save APP_NAME BRANCH > app.tar.gz`)
	7. cleanup (`./cleanup`)
	8. add to "to-run" queue...

e.g. `./git-clone /vagrant/debug/repo.git HEAD | ./buildstep repo master | ./docker-env repo master | ./docker-save repo master > test.tar.gz | ./cleanup`

role-host

1. grab from "to-run" queue
2. docker run
3. register with load balancer