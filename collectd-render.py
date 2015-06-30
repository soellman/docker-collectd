#!/usr/bin/env python

import os
import os.path
import string
import sys

from jinja2 import Template

main_template = "collectd.conf"
templates = {
    # main
    "collectd.conf":        ["HOSTNAME"],

    # builtin
    "df.conf":              ["DF_MOUNTS"],
    "disk.conf":            ["DISK_DISKS"],

    # custom
    "df-btrfs.conf":        ["BTRFS_MOUNTS"],
    "librato.conf":         ["LIBRATO_EMAIL", "LIBRATO_TOKEN"],
    "riak.conf":            ["RIAK_STATS_URL"]
}
multi = ["DF_MOUNTS", "DISK_DISKS", "BTRFS_MOUNTS"]


def list_module_templates(dir):
    files = filter((lambda x: x[-4:] == ".tpl"), os.listdir(dir))
    return map((lambda x: x[:-4]), files)

def check_requirements(template):
    for v in templates[template]:
        if os.getenv(v) == None:
            return False
    return True

def get_args(envs):
    args = {}
    for e in envs:
        if e in multi:
            args[e] = [string.strip(s) for s in string.split(os.getenv(e), ",")]
        else:
            args[e] = os.getenv(e)
    return args

def render_template(template, dir):
    args = get_args(templates[template])
    template = os.path.join(dir, template)
    
    with open(template+".tpl", 'r') as f:
        contents = f.read()
    t = Template(contents)
    result = t.render(args)
    
    with open(template, 'w') as f:
        f.write(result)

def main():
    if os.getenv("HOSTNAME") == "default":
        print "You must at least provide {}".format("HOSTNAME")
        sys.exit(1)

    main_dir = "."
    render_template(main_template, main_dir)

    module_dir = os.path.join(main_dir, "collectd.d")
    for f in list_module_templates(module_dir):
        if check_requirements(f):
            render_template(f, module_dir)

main()
