# Default configuration
dir="$HOME/Desktop/"
fps=15

# Help function
Help() {
    echo "This tool uses ffmpeg to convert an input file into a GIF."\\n

    echo "The following switches can be used to overwrite the default values:"
    echo "-d  The directory in which the script should be executed (default: Defined at the top of this script)."
    echo "-n  The name of the file that should be converted to a GIF (default: The last modified file in the directory)."
    echo "-f  The desired FPS frequency (default: 15 FPS)."
    echo "-w  The desired width fo the resulting GIF (default: same as input file)."
    echo "-o  name of the output file (default: same as input file)."
    echo "-h  Displays this help message. No further code is executed."\\n

    exit 1
}

# Parse optional parameters
while getopts ":d:n:f:w:o:h" opt; do
  case $opt in
    d)  # Overwrite default
        dir="$OPTARG"
        ;;
    n)
        filename="$OPTARG"
        ;;
    f)  # Overwrite default
        fps="$OPTARG"
        ;;
    w)
        width="$OPTARG"
        ;;
    o)
        output_name="$OPTARG"
        ;;
    h)  # Display Help
        Help
        ;;
    \?)
        echo "Invalid option -$OPTARG" >&2
        Help
        ;;
  esac
done

# Switch to the desired directory
cd $dir;

# Use the last modified file if no filename is provided
if [ -z "$filename" ]
    then
        filename="$(ls -1 -t | head -1)"
fi

# Set output file name for ffmpeg command
if [ -z "$output_name"]
    then
        command_output="$filename.gif"
    else
        command_output="$output_name.gif"
fi

# Set output GIF scale based on the provided width
if [ -z "$width" ]
    then
        command_scale=""
    else
        command_scale="scale=$width:-1,"
fi

echo "Creating a GIF from $dir$filename"\\n

ffmpeg -i "$filename" -filter_complex "[0:v] fps="$fps","$command_scale"split [a][b];[a] palettegen [p];[b][p] paletteuse" "$command_output";
