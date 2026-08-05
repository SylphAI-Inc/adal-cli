#!/usr/bin/env python3
"""Tiny HTTP capture server for installer E2E tests.

Usage: capture_server.py <log_file> <port_file>
Writes each POST's headers + body to <log_file> and its bound port to
<port_file>, then returns 200. Exits when the log file contains a line
beginning with "STOP" (written by the test) or on SIGTERM.
"""
import http.server
import os
import socketserver
import sys

log_file, port_file = sys.argv[1], sys.argv[2]


class Handler(http.server.BaseHTTPRequestHandler):
    def do_POST(self):
        length = int(self.headers.get("Content-Length", 0))
        body = self.rfile.read(length)
        with open(log_file, "a") as f:
            f.write("PATH: %s\n" % self.path)
            for k, v in self.headers.items():
                f.write("%s: %s\n" % (k, v))
            f.write("BODY: %s\n" % body.decode("utf-8", "replace"))
            f.write("---\n")
        self.send_response(200)
        self.end_headers()
        if b"STOP" in body:
            os._exit(0)

    def log_message(self, *args):
        pass


with socketserver.TCPServer(("127.0.0.1", 0), Handler) as srv:
    with open(port_file, "w") as f:
        f.write(str(srv.server_address[1]))
    srv.serve_forever()
