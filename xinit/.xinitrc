export XDG_SESSION_TYPE=x11
export GDK_BACKEND=x11
xrdb -merge ~/.Xresources
exec gnome-session

