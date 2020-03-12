# toolbox
A small collection of custom tools that improve my workflow.
Since I mostly work on MacOS, all tools are usually not tested on other operating systems.

## GIF Creator

### Setup
The computer needs to have the `ffmpeg` command available. You can use Homebrew to install ffmpeg.

After cloning this toolbox repository, you can add an alias to your `$HOME/.bash_profile` to easily call the GIF creator:

```
alias gif="sh $HOME/repositories/toolbox/gif.sh"
```

Then you can call the GIF creator anywhere by simply running `gif` in your terminal.

The default directory in which the script runs is `$HOME/Desktop`, since that is the directory in which I save all my screenshots and screencaptures per default. If your standard directory for this is a different one, just adjust `dir="$HOME/Desktop/"` in the 2nd line of `gif.sh` to the directory of your choice.

### Options
| param  |  default  |  description  |
|---|---|---|
| -d  | Defined at the top of the script with $dir | The directory in which the script should be executed. |
| -n  | The last modified file in the directory | The name of the file that should be converted to a GIF. |
| -f  | 15 | The desired FPS frequency. |
| -w  | Same as input | The desired width fo the resulting GIF. The height is adjusted automatically. |
| -o  | Same as input | Name of the output file. |
| -h  | n/a | Displays the help message. |

## Port Killer

### Setup

After cloning this toolbox repository, you can add an alias to your $HOME/.bash_profile to easily call the port killer:

```
alias killport="sh $HOME/repositories/toolbox/killport.sh"
```

Then you can call the port killer anywhere by simply running `killport` with the desired arguments in your terminal.

If you want to use `sudo`, please be aware that you can't simply run `sudo` with an alias.
One simple solution to this can be to add a second alias that runs the `killport` command directly with sudo:

```
alias sudokillport="sudo sh $HOME/repositories/toolbox/killport.sh"
```

### Options
| param  |  description  |
|---|---|
| -p  | Defines for which ports you want to kill the processes.<br>You can provide a single port: "-p 8080"<br>You can provide multiple ports, separated by commas: "-p 8080,8090"<br> You can provide a range of ports, separating the first and last port with a colon: "-p 8080:8090" <br> You can also use a mix of the above.|
| -s  | Kills the processes with SIGKILL (-9) instead of the default. |
| -l  | Shows a list of processes that have listening ports open (uses the `lsof` command). |
| -h  | Displays the help message. |
