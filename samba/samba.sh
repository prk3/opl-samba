#!/bin/sh

# Starts samba with guests identifying as UID:GID provded through env variables.

if [ -z "$FORCE_USER_ID" ]; then
	echo "UID not provided"
	exit 1
fi

if [ -z "$FORCE_GROUP_ID" ]; then
	echo "GID not provided"
	exit
fi

# Retuns group name given group ID. Creates a group (ps2) if doesn't exist.
group_name() {
	name="$(cat /etc/group | grep "^[^:]*:[^:]:$1:" | head -1 | cut -d: -f1)"
	[ "$name" = "" ] && addgroup -g "$1" ps2 && echo ps2 || echo "$name"
}

# Retuns user name given user ID and group name. Creates a user (ps2) if
# doesn't exist and assigns it to the group.
user_name() {
	name="$(cat /etc/passwd | grep "^[^:]*:[^:]*:$1:" | head -1 | cut -d: -f1)"
	[ "$name" = "" ] && adduser -H -D -G "$2" -u "$1" ps2 && echo ps2 || echo "$name"
}

group="$(group_name "$FORCE_GROUP_ID")"
user="$(user_name "$FORCE_USER_ID" "$group")"

echo force user = $user
echo force group = $group
exec smbd \
	--foreground \
	--log-stdout \
	--no-process-group \
	--debuglevel=1 \
	--option="force user = ${user}" \
	--option="force group = ${group}"

