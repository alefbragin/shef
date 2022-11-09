# Shef

Shef a simple automation tool for provisioning and deployment written in POSIX Shell.

Also Shef can be used to make scripts with conditional inclusion.
It is helpful for make packages for variuos platforms.

**WARNING**: This software is in an early experimental stage, use it with caution.

## Installation

```sh
sudo make install
```

## Usage

```sh
SHEF_REMOTE_SH_RUNNER='ssh -T root@example.com -- sh' \
    shef \
        -I lib -I prod-config \
        prepare.sh provision.remote.sh
```

## Configure runners

TODO

## Inclusion

TODO

## Base environment variables

TODO

## License

MIT License

See [LICENSE](LICENSE) to see the full text.
