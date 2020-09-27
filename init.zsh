######################################################################
#<
#
# Function: p6df::modules::helm::version()
#
#>
######################################################################
p6df::modules::helm::version() { echo "0.0.1" }

######################################################################
#<
#
# Function: p6df::modules::helm::deps()
#
#>
######################################################################
p6df::modules::helm::deps() {
    ModuleDeps=(
        ohmyzsh/ohmyzsh:plugins/helm
        p6m7g8/p6helm
    )
}

######################################################################
#<
#
# Function: p6df::modules::helm::external::brew()
#
#>
######################################################################
p6df::modules::helm::external::brew() {

    brew install helm
}

######################################################################
#<
#
# Function: p6df::modules::helm::langs()
#
#>
######################################################################
p6df::modules::helm::langs() {

  helm repo add bitnami              https://charts.bitnami.com/bitnami
  helm repo add incubator            https://storage.googleapis.com/kubernetes-charts-incubator
  helm repo add stable               https://kubernetes-charts.storage.googleapis.com
  helm repo add kubernetes-dashoard  https://kubernetes.github.io/dashboard/
  helm repo add jenkinsci            https://charts.jenkins.io
  helm repo add nginx                https://helm.nginx.com/stable
}

######################################################################
#<
#
# Function: p6df::modules::helm::init()
#
#>
#/ Operating System	Cache Path			Configuration Path		Data Path
#/ Linux		$HOME/.cache/helm		$HOME/.config/helm		$HOME/.local/share/helm
#/ macOS		$HOME/Library/Caches/helm	$HOME/Library/Preferences/helm	$HOME/Library/helm
#/ Windows		%TEMP%\helm			%APPDATA%\helm			%APPDATA%\helm
######################################################################
p6df::modules::helm::init() {
}

######################################################################
#<
#
# Function: p6df::prompt::helm::line()
#
#>
######################################################################
p6df::prompt::helm::line() {

    p6_helm_prompt_info
}

######################################################################
#<
#
# Function: p6df::modules::helm::kubernetes::dashboard::token()
#
#>
######################################################################
p6df::modules::helm::kubernetes::dashboard::token() {

  local secret
  secret=$(kubectl -n kube-system get secret | grep eks-admin | awk '{ print $1 }')

  kubectl -n kube-systemd describe secret "$secret" | awk '/^token/ { print $2 }'
}

######################################################################
#<
#
# Function: p6df::modules::helm::jenkins::admin::password()
#
#>
######################################################################
p6df::modules::helm::jenkins::admin::password() {

  printf $(kubectl -n jenkins get secret jenkins -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode);p6_echo
}

######################################################################
#<
#
# Function: p6df::modules::helm::external-dashboard::chart::add(zone_id, role_arn)
#
#  Args:
#	zone_id - 
#	role_arn - 
#
#>
######################################################################
p6df::modules::helm::external-dashboard::chart::add() {
  local zone_id="$1"
  local role_arn="$2"

  helm install -n kube-system bitnami/external-dns external-dns --set policy=sync --set txtOwnerId=$zone_id --set aws.assumeRoleArn=$role_arn --set log-level=debug
}

######################################################################
#<
#
# Function: p6df::modules::helm::jenkins::chart::add()
#
#>
######################################################################
p6df::modules::helm::jenkins::chart::add() {

  local str
  str=$(p6_template_process "share/jenkins-chart-values.yaml.in" "URL=x")
  p6_file_write "/tmp/jenkins-chart-values.yaml"

  helm install -f "/tmp/jenkins-chart-values.yaml" jenkins jenkinsci/jenkins  
}
