ffrom flask import Flask, render_template
from datetime import datetime
import pytz

app = Flask(__name__)

@app.route('/')
def world_time():
    # Get current UTC time
    utc_now = datetime.now(pytz.utc)
    
    # Define time zones to display
    time_zones = {
        'UTC': pytz.utc,
        'New York': pytz.timezone('America/New_York'),
        'London': pytz.timezone('Europe/London'),
        'Tokyo': pytz.timezone('Asia/Tokyo'),
        'Sydney': pytz.timezone('Australia/Sydney'),
        'Dubai': pytz.timezone('Asia/Dubai'),
        'Moscow': pytz.timezone('Europe/Moscow'),
        'Beijing': pytz.timezone('Asia/Shanghai'),
    }
    
    # Get times for each zone
    times = {}
    for city, tz in time_zones.items():
        times[city] = utc_now.astimezone(tz).strftime('%Y-%m-%d %H:%M:%S')
    
    return render_template('world_time.html', times=times)

if __name__ == '__main__':
    app.run(debug=True)