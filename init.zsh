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
        robbyrussell/oh-my-zsh:plugins/helm
    )
}

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

}

######################################################################
#<
#
# Function: p6df::modules::helm::init()
#
#>
#
#/ Operating System	Cache Path			Configuration Path		Data Path
#/ Linux		$HOME/.cache/helm		$HOME/.config/helm		$HOME/.local/share/helm
#/ macOS		$HOME/Library/Caches/helm	$HOME/Library/Preferences/helm	$HOME/Library/helm
#/ Windows		%TEMP%\helm			%APPDATA%\helm			%APPDATA%\helm
#
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
