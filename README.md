# Shef

Shef a simple automation tool for provisioning and deployment written in POSIX Shell.

**WARNING**: This software is in an early experimental stage, use it with caution.

## Installation

```sh
sudo make install
```

## Usage

```sh
shef -I path/to/custom/lib path/to/tasks...
```

## Environment variables

```sh
SHEF_INCLUDE_PATH=/home/user/.local/lib/shef:/usr/local/lib/shef
```

## Tasks configuration

You can use first task argument as config.

## Libraries names guarantees

`custom/`, `user/` and `project/` prefixes never be used by Shef libraries.

## TODO

### First priority:

- PIPEs for task running instead of temporary regular file

### Under consideration:

- Custom environments, e.g. `stage`, `prod`, `docker` etc (not only local/target)
- Ability to run tasks in other languages: `*.bash`, `*.py` etc
- Parallel execution for tasks in different environments (local/target)

## License

MIT License

See [LICENSE](LICENSE) to see the full text.
