import http.server
import socketserver
import signal
import sys
import time
import os

# Define the port and directory for the server
PORT = 3000
DIRECTORY = "website"

# Custom request handler class
class MyHttpRequestHandler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=DIRECTORY, **kwargs)

    # Override end_headers to disable caching
    def end_headers(self):
        self.send_header('Cache-Control', 'no-store, no-cache, must-revalidate, max-age=0')
        self.send_header('Pragma', 'no-cache')
        self.send_header('Expires', '0')
        super().end_headers()

    # Handle GET requests
    def do_GET(self):
        if self.path == '/favicon.ico':
            self.path = '/favicon.ico'
        return super().do_GET()

# Create an instance of the request handler
handler = MyHttpRequestHandler

# Create the server
httpd = socketserver.TCPServer(("", PORT), handler)

# Define the signal handler for graceful shutdown
def signal_handler(sig, frame):
    print('Shutting down server...')
    httpd.shutdown()
    httpd.server_close()
    sys.exit(0)

# Register signal handlers for SIGINT and SIGTERM
signal.signal(signal.SIGINT, signal_handler)
signal.signal(signal.SIGTERM, signal_handler)

print("Serving at port", PORT)

# Start the server in a separate thread
import threading
server_thread = threading.Thread(target=httpd.serve_forever)
server_thread.start()

# Keep the script running
try:
    while True:
        time.sleep(1)
except KeyboardInterrupt:
    signal_handler(signal.SIGINT, None)