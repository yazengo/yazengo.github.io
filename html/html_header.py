#! /usr/bin/env python
# coding=utf-8

import os, glob
import sys

def title(file):
    mkd_file = open(file, 'r')
    first_line = mkd_file.readline().strip()
    print("\t\t<title>" + first_line + "</title>")
    mkd_file.close()

def main():
    if len(sys.argv) < 2:
        return

    print("""<!DOCTYPE html>
<html lang="zh-CN">
    <head>
        <meta charset="UTF-8">
    """)

    title(sys.argv[1])

    print("""
        <link rel="stylesheet" media="all" href="../../Han/han.min.css">
        <link rel="stylesheet" media="all" href="../../stylesheets/main.css">
    </head>
    <body>
        <div id="container">
    """)

if __name__ == "__main__":
    main()

