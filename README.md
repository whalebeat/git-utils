# git-utils
Utilities to make git easier for life
1. _GitPull.bat
- Clone/pull default branch of a bunch of git repos
- Repos are defined in _GetList.txt with folowing format:
	<Parent folder name>@<Git project link without ending ".git">
- Each repo will be clone/pull into <repo name> folder inside <Parent folder name> folder
