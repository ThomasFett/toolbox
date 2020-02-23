# toolbox
A small collection of custom tools that improve my workflow.
Since I mostly work on MacOS, all tools are usually not tested on other operating systems.

## GIF Creator

### Setup
The computer needs to have the `ffmpeg` command available. You can use Homebrew to install ffmpeg.

After cloning this toolbox repository, you can add an alias to your `$HOME/.bash_profile` to easily call the GIF creator:

```
alias gif="sh $HOME/Documents/projects/toolbox/gif.sh"
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
