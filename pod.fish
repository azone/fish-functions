function pod --description="execute pod dynamically"
	if test -f Gemfile && grep --silent 'cocoapods' Gemfile
		bundle show cocoapods 2>&1 >/dev/null
		if test $status -ne 0
			set_color red; echo "cocoapods not installed, please execute \"bundle install\" to install." >&2
			exit 1
		end
		bundle exec pod $argv
	else
		set -l POD_SHELL (which pod)
		$POD_SHELL $argv
	end
end

