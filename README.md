# URLVault-
Fetches web pages, saves each as a timestamped text file, logs success or failure, computes hashes for integrity, and stores everything in a compressed archive



# URLVault CLI

URLVault CLI is a simple Bash tool that fetches web pages, saves each as a timestamped text file, logs success or failure, computes hashes for integrity, and stores everything in a compressed archive. It is designed for managing and archiving web content in an organized way.

## Features

- Fetch one or multiple URLs interactively or via command-line arguments
- Save each fetched page as a timestamped `.txt` file
- Log successes and failures in a central log file
- Compute SHA256 hashes for integrity verification
- Store all snapshots in a compressed archive (`tar.gz`)
- Interactive CLI with easy-to-read output
- Footer includes author socials for reference

## Installation

#### 1. Clone the repository:

```bash
git clone https://github.com/Neewtonium/URLVault.git
cd URLVault/scripts
````

#### 2. Make the script executable:



```bash
chmod +x urlvault.sh
```

### Usage

Run the script with URLs as arguments:

```bash
./urlvault.sh https://example.com https://another.com
```
Or run without arguments and enter URLs interactively:

```bash
./urlvault.sh
```

The fetched content will be saved in the archive web_archive.tar.gz, logs will be in logs/fetch.log, and hashes will be computed automatically.

### Author 

#### LinkedIn: https://www.linkedin.com/in/newton-ojwang-19b2262a8

#### GitHub: https://github.com/Neewtonium

#### WhatsApp: +254796763023

#### YouTube: https://youtube.com/@neewtonium?si=RDBlywA-IL5JHnoW
