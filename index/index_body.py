#! /usr/bin/env python
# coding=utf-8

import os, glob
from subprocess import call

def parsefile(filepath):
    for index, file in enumerate(glob.glob(filepath)):
        mkd_file = open(file, 'r')
        first_line = mkd_file.readline().strip()
        print("<li><a href=" + '"' + file.replace(".txt", ".html") + '"' + '>' + first_line + "</a></li>")
        mkd_file.close()

def main():
    print("""
        <h1>记录</h1>
        <br>
        <ul>
        """)

    parsefile('txt/tech/*.txt')

    print("""
        </ul>
        <br>

        <h1>吐槽</h1>
        <br>
        <ul>
        """)

    parsefile('txt/life/*.txt')

    print("""
        </ul>
        """)


if __name__ == "__main__":
    main()

