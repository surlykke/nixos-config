function fish_user_key_bindings
	fish_vi_key_bindings
	bind -M insert \cg forward-char
	bind -M insert \ch backward-char
end
