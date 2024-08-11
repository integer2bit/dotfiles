export XDG_SESSION_TYPE=x11
export GDK_BACKEND=x11
xset dpms 1800 2700 3600
xrdb -merge ~/.Xresources
exec gnome-session

