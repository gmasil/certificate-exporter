#! /bin/bash

CONTENT=$(eval "$1")

echo -ne "HTTP/1.0 200 OK\n"
echo -ne "Content-Length: ${#CONTENT}\n"
echo -ne "Content-Type: text/plain; charset=utf-8\n"
echo -ne "\n"
echo -ne "${CONTENT}"
