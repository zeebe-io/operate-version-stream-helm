DIR := "operate-version-stream"
OS := $(shell uname)

build: clean
	rm -rf requirements.lock
	helm3 version
	#helm init --client-only
	helm3 repo add zeebe http://helm.zeebe.io
	helm3 repo update
	helm3 dependency build ${DIR}
	helm3 lint ${DIR}

install: 
	helm3 upgrade ${OPERATE} ${DIR} --install --namespace ${NAMESPACE} --debug --set global.zeebe=${CLUSTER_NAME}-zeebe

delete:
	helm3 delete --purge --no-hooks ${OPERATE} --namespace ${NAMESPACE}

clean:
