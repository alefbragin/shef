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

## BUGS

- If there is no a newline (the `\n` character) at end of file file,
  last line will not be preprocessed

## TODO

```sh
# TODO allow preprocess script like for Shef
read_into --preprocess ma_pers_bk_script << 'EOF'
#!/bin/sh
#. shef/utils.sh
dump_name="$(date +%s)" || die
mkdir -p /root/ma-pers-dumps && gzip -c /var/lib/redis/dump.rdb > "/root/ma-pers-dumps/$(date +%s).rdb.gz"
EOF
```
