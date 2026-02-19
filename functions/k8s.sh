foc() {
    # https://en.wikipedia.org/wiki/Flag_of_convenience
    namespace=$1
    if [ -z $namespace ]; then
        echo "Please provide the namespace name: 'change-ns mywebapp'"
        return 1
    fi
    kubectl config set-context $(kubectl config current-context) --namespace $namespace
}

sail () {
	kubectl config use-context $1
}
 
# kubectx execute shell interactive
kxi () {
	local pod=$(kubectl get pods | tail -n+2 | fzf | awk '{print $1}')
	local containers=$(kubectl get pods "${pod}" -o jsonpath='{.spec.containers[*].name}')
	local container=${containers}
	if [[ $containers =~ ' ' ]]; then
		container=$(echo "${containers}" | tr ' ' '\n' | fzf)
	fi
	echo "${pod}" - "${container}"
	kubectl exec -it "${pod}" -c "${container}" -- "${@}"
}

# kubectl logs for pod and coantainer 
kli () {
	local pod=$(kubectl get pods | tail -n+2 | fzf | awk '{print $1}')
	local containers=$(kubectl get pods "${pod}" -o jsonpath='{.spec.containers[*].name}')
	local container=${containers}
	if [[ $containers =~ ' ' ]]; then
		container=$(echo "${containers}" | tr ' ' '\n' | fzf)
	fi
	echo "${pod}" - "${container}"
	kubectl logs "${@}" "${pod}" -c "${container}"
}

klfi () {
	kli -f --tail=10
}

# kubectl logs deployments interactive
klii () {
	foci
	local deployment=$(kubectl get deployments | tail -n+2 | fzf | awk '{print $1}')
	local cmd=$(echo kubectl logs "${@}" "deployments/${deployment}")
	print -s $cmd
	eval ${cmd}
}

# kubectl follow logs deployments interactive
klfii () {
	klii -f --tail=10 --all-pods=true --max-log-requests=20
}

# interactive change namespace also see kubens and kubectx
foci () {
	local ns=$(kubectl get namespace | tail -n+2 | fzf | awk '{print $1}')
	foc $ns
}

