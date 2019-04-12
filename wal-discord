#!/usr/bin/env bash
#
# thanks to Sweets from which I copied some function
# https://github.com/Sweets

CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
CONF_DIR="${CONFIG_HOME}/wal-discord"
OUT_DIR="${HOME}/.cache/wal-discord"
WAL_COLORS="${HOME}/.cache/wal/colors.scss"
WPG_COLORS="${HOME}/.config/wpg/formats/colors.scss"
FORCE_UPDATE=false
# generate BetterDiscord theme
BD_THEME=false
BD_THEME_HEADER='//META{"name":"wal-discord","description":"Generated based on pywal colors","author":"wal-discord","version":"1.0"}*//'
# generate firefox userContent.css
FIREFOX_CSS=false
backend=""
out_file="${OUT_DIR}/style.css"

usage() {
    printf "%s\\n" "\
    wal-discord - generate custom discord css files based on pywal colors
        -h  Display this help.
        -s  Output result to stdout.
        -b  Select backend to use.
            Supported backends by default are 'wal', 'haishoku'.
            It can be any \$value as long as ${CONF_DIR}/backends/\$value.scss exists.
            Default is 'wal'.
        -o  Set output file. Defaults to $out_file
        -t  Generate BetterDiscord theme.
        -x  Generate firefox userContent.css
        -u  Forces wal-discord update.\
        "
    exit 1
}

set_backend() {
    [[ ! -r "${CONF_DIR}/backends/${1}.scss" ]] && {
        printf "%s\\n" "Can't find backend $1"
        exit 1
    }
    backend="$1"
}

setup() {
    local exec_path="$0"
    [[ -L "$exec_path" ]] && exec_path="$(readlink "$0")"
    local repo_dir
    repo_dir="$(dirname "$exec_path")"
    [[ ! -d "${repo_dir}/config" ]] && {
        printf "%s\\n" "Can't find needed setup folder: ${repo_dir/config}"
        exit 1
    }
    cp -R "${repo_dir}/config/" "$CONF_DIR"
    ln -sf backends/wal.scss "${CONF_DIR}/backend.scss"

    local colors="$WAL_COLORS"
    
    # we assume we're using wpgtk if wal colors file doesn't exist
    [[ ! -r "$WAL_COLORS" ]] && colors="$WPG_COLORS"
    
    # only returns true if both files exist
    [[ "$WPG_COLORS" -nt "$WAL_COLORS" ]] && colors="$WPG_COLORS"
    
    ln -sf "$colors" "${CONF_DIR}/colors.scss"
}

generate_firefox_css() {    
    result="$(printf "@-moz-document domain(discordapp.com) {\\n%s\\n}" "$result")"
    
    [[ "$out_file" == "${OUT_DIR}/style.css" ]] || return
    
    profiles=(${HOME}/.mozilla/firefox/*.default)
    [[ -z "${profiles[0]}" ]] && {
        printf "%s\n" "No firefox profile found! Aborting."
        exit 1
    }
    
    OUT_DIR="${profiles[0]}/chrome"
    mkdir -p "$OUT_DIR"
    out_file="${OUT_DIR}/userContent.css"
}

init() {
    OPTIND=1
    while getopts 'hsutxb:o:' opt; do
        case "$opt" in
            h) usage;;
            s) out_file="";;
            o) out_file="$OPTARG" ;;
            b) set_backend "$OPTARG" ;;
            u) FORCE_UPDATE=true ;;
            t) BD_THEME=true ;;
            x) FIREFOX_CSS=true ;;
            *) ;;
        esac
    done
    
    [[ ! -d "$CONF_DIR" || $FORCE_UPDATE = true ]] && setup
}

main() {
    init "$@"
    
    type -p sassc &>/dev/null || {
        printf "%s\\n" "sassc is not installed and is required"
        exit 1
    }
    
    local master
    master="$(< "${CONF_DIR}/master.scss")"
    [[ -n "$backend" ]] && {
        local bp
        bp="backends/${backend}.scss"
        master="${master/backend.scss/$bp}"
    }
    
    local result
    result="$(sassc -t expanded -I "$CONF_DIR" -s <<< "$master")"
    
    [[ $BD_THEME = true ]] && {
        result="$(printf "${BD_THEME_HEADER}\\n%s" "$result")"
        [[ "$out_file" == "${OUT_DIR}/style.css" && -d "${CONFIG_HOME}/BetterDiscord/themes" ]] && {
            out_file="${CONFIG_HOME}/BetterDiscord/themes/wal_discord.theme.css"
        }
    }

    [[ $FIREFOX_CSS = true ]] && generate_firefox_css "$result"
    
    if [[ -n "$out_file" ]]; then
	    mkdir -p "$(dirname "$out_file")"
        printf "%s\\n" "$result" > "$out_file"
    else
        printf "%s\\n" "$result"
    fi
    
}

main "$@"
