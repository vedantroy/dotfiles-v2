import traceback
import os
import subprocess
from datetime import datetime
from enum import Enum, auto
from pathlib import Path


class Color(Enum):
    DEFAULT = None
    DISABLED = "#a89984"
    GREEN = "#98971a"
    RED = "#cc241d"


class Action(Enum):
    ERROR = auto()
    LOG_TOO_LARGE = auto()


def strip_trailing_newline(s):
    assert s[-1] == "\n"
    return s[:-1]


def print_i3blocks(long_msg, short_msg=None, color=Color.DEFAULT):
    if short_msg is None:
        short_msg = long_msg
    print(long_msg)
    print(short_msg)
    if color is not Color.DEFAULT:
        print(color.value)


def readfile(path):
    return Path(path).read_text()


home_dir = os.path.expanduser("~")


def set_except_hook(filepath):
    filename = os.path.basename(filepath)
    logfile = f"{home_dir}/blocks_{filename}.log"

    def hook(exception_type, value, traceback_):
        msg = f"{filename}: ERROR"
        print_i3blocks(msg, color=Color.RED)
        action = Action.ERROR
        max_kbs = 5
        try:
            size_in_bytes = os.path.getsize(logfile)
            if (size_in_bytes >> 10) >= max_kbs:
                action = Action.LOG_TOO_LARGE
        except FileNotFoundError:
            pass

        # need binary mode to seek backwards
        with open(logfile, "ab+") as f:
            if action is action.ERROR:
                f.write(
                    bytes(
                        f"[{datetime.now().strftime('%Y-%m-%d %H:%M:%S')}]:\n",
                        encoding="ascii",
                    )
                )
                f.write(
                    bytes(
                        "".join(
                            traceback.format_exception(
                                exception_type, value, traceback_
                            )
                        ),
                        encoding="ascii",
                    )
                )
            elif action is action.LOG_TOO_LARGE:
                # check if the log too large warning has already been printed
                # append mode puts the file cursor at the end, so we need to seek backwards
                # to get the last line
                # https://stackoverflow.com/questions/46258499
                while f.read(1) != b"\n":
                    f.seek(-2, os.SEEK_CUR)
                last_line = f.readline()
                end_log_marker = bytes("===END LOG===\n", encoding="ascii")
                if last_line != end_log_marker:
                    f.write(
                        bytes(
                            "Log has reached max size limit -- nothing else will be printed\n",
                            encoding="ascii",
                        )
                    )
                    f.write(end_log_marker)

    return hook


def safe_execute(cmd, shell=True, text=True):
    completed = subprocess.run(cmd, shell=shell, text=text, capture_output=True)
    retval = completed.returncode
    if retval != 0:
        raise Exception(f'"{cmd}" returned {retval} with stderr:\n{completed.stderr}')
    return completed.stdout
