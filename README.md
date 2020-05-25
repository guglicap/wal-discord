# wal-discord

<h4 align="center">Generate Discord themes based on pywal colors.</h4>
<br>

<img src="https://raw.githubusercontent.com/guglicap/wal-discord/master/images/readme_image.png" align="right" width="600px">

By default, wal-discord will only change colors of the Discord app.

However, it allows for customization of other aspects by writing custom backends.

Designed to work with dark theme only.

Supports BeautifulDiscord and BetterDiscord.

#### See the [wiki](https://github.com/guglicap/wal-discord/wiki) for more info.

### Quick Start

```
git clone https://github.com/guglicap/wal-discord.git
chmod +x ./wal-discord/wal-discord
ln -s "`pwd`/wal-discord/wal-discord" <directory in your $PATH>
wal-discord; beautifuldiscord --css ~/.cache/wal-discord/style.css
```
