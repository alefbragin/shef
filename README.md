# Shef

Shef a simple automation tool for provisioning and deployment written in POSIX Shell.

## Installation

```sh
sudo make install
```

## Usage

```sh
shef -c path/to/config1 -c path/to/config2 -e target_host=example.com path/to/tasks...
```

## Environment configuration

```sh
SHEF_LIBRARY_PATH=/home/user/.local/lib/shef:/usr/local/lib/shef
```

## Tasks configuration

Tasks configuration can be passed via `--config` (`-c`) option.
Configuration is just shell script which includes into beginning of each local or remote run.

## License

MIT License

See [LICENSE](LICENSE) to see the full text.
