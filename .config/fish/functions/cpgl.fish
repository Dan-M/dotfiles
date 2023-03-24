function cpgl --description 'CP release notes git log'
  eval "git log $(git describe --abbrev=0 --tags)..HEAD --no-merges --pretty=format:'* %s' | sed -E 's/[*]+[[:space:]]//' | sed -E 's/([A-Z0-9]+-+[0-9]+)/https:\/\/axahealth.attlassian.net\/browse\/\1 /'"
end
