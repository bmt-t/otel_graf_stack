from flask import Flask, request
import subprocess

app = Flask(__name__)
ZABBIX_SERVER = '10.6.69.36'
ZABBIX_PORT = '10051'

@app.route('/otel', methods=['POST'])
def receive_otel():
    data = request.json
    for m in data.get('metrics', []):
        host = m.get('host', 'otel-host')
        key = m.get('name')
        val = m.get('value')
        if key and val is not None:
            subprocess.run([
                'zabbix_sender', '-z', ZABBIX_SERVER, '-p', ZABBIX_PORT,
                '-s', host, '-k', key, '-o', str(val)
            ], check=True)
    return 'OK'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)