import os
import net.http
import regex

fn is_valid_package_name(name string) bool {
    // Simple regex to allow alphanumeric, hyphens, underscores, and dots
    mut re := regex.regex_opt(r'^[a-zA-Z0-9_\-\.]+$') or { return false }
    return re.matches_string(name)
}

fn main() {
    args := os.args[1..]
    if args.len == 0 {
        println('Nexus Package Manager')
        println("Type 'nexus help' for a list of commands.")
        return
    }

    command := args[0]
    httpserver := 'http://somepackagewebsite.com'

    if command == 'install' {
        if args.len > 1 {
            package_name := args[1]
            if !is_valid_package_name(package_name) {
                eprintln('Error: Invalid package name. Use alphanumeric, hyphens, underscores, or dots.')
                return
            }
            println("Preparing to install '$package_name'...")

            url := '$httpserver/$package_name'
            resp := http.get(url) or {
                eprintln('Error: Failed to download package: $err')
                return
            }
            if resp.status_code != 200 {
                eprintln('Error: Failed to download package. HTTP status: $resp.status_code')
                return
            }
            // Save the downloaded content (fixed: proper string concatenation)
            filename := package_name + '.pkg'
            os.write_file(filename, resp.body) or {
                eprintln('Error: Failed to save package: $err')
                return
            }
            println('Package $package_name installed successfully.')
        } else {
            println('Error: You must specify a package to install.')
            println('Example: nexus install my-package')
        }
    } else if command == 'help' || command == '-h' {
        println('Available Commands:')
        println('  install <package>   Installs a package.')
        println('  remove <package>    Removes a package.')
        println('  help                Shows this message.')
    } else if command == 'remove' || command == '-del' {
        

    } else {
        println("Error: Unknown command '$command'")
        println("Type 'nexus help' for a list of commands.")
    }
}