[user]
	name = {{ op://Work/Identity/username }}
	email = {{ op://Work/Identity/email }}

[includeIf "gitdir:~/Sources/github.com/"]
	path = ./user.private

; vim: ft=gitconfig
