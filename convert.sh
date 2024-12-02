#!/bin/zsh

# Prompt user for input file
echo "Enter the file you want to convert:"
read input_file

# Check if the file exists
if [[ ! -f "$input_file" ]]; then
    echo "File not found!"
    exit 1
fi

# Determine the file type based on the extension
file_extension="${input_file##*.}"

# Pandoc file type mapping (adjustable)
case "$file_extension" in
    md)
        file_type="markdown"
        ;;
    html | htm)
        file_type="html"
        ;;
    docx)
        file_type="docx"
        ;;
    pdf)
        file_type="pdf"
        ;;
    txt)
        file_type="plain text"
        ;;
    *)
        echo "Unsupported file type: $file_extension"
        exit 1
        ;;
esac

echo "Detected file type: $file_type"

# Prompt user for output format
echo "Enter the desired output format (e.g., pdf, html, docx, markdown, etc.):"
read output_format

# Construct output filename
output_file="${input_file%.*}.$output_format"

# Run pandoc to convert the file
echo "Converting $input_file to $output_file..."
pandoc "$input_file" -o "$output_file" -f "$file_type" -t "$output_format"

# Check if the conversion was successful
if [[ $? -eq 0 ]]; then
    echo "Conversion successful! Output saved as $output_file"
else
    echo "Conversion failed."
fi
