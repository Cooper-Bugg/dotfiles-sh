#!/usr/bin/env python3
import json
import calendar
import datetime
import os

# Configuration
WEEKLY_DIR = os.path.expanduser("~/ai_agent_md/weekly")
CALC_APP = "qalculate-gtk" # Change to your preferred calculator
DATE_FORMAT = "%I:%M %p  //  %a %b %d"

def get_weekly_content(date):
    filename = f"week-{date.strftime('%Y-%m-%d')}.md"
    filepath = os.path.join(WEEKLY_DIR, filename)
    if os.path.exists(filepath):
        with open(filepath, 'r') as f:
            lines = f.readlines()
            # Get first 5 lines of content (skipping header if redundant)
            content = "".join(lines[:6]).strip()
            return f"<span color='#5a9fd4'><b>{filename}:</b></span>\n{content}\n"
    return f"<span color='#cc3333'><b>{filename}:</b></span> (No report found)\n"

def generate_calendar():
    now = datetime.datetime.now()
    cal = calendar.TextCalendar(calendar.SUNDAY)
    month_cal = cal.formatmonth(now.year, now.month)
    
    # Highlight today in the calendar
    today_str = str(now.day).rjust(2)
    month_cal = month_cal.replace(f" {today_str} ", f" <span color='#c8951a'><b><u>{today_str}</u></b></span> ")
    month_cal = month_cal.replace(f" {today_str}\n", f" <span color='#c8951a'><b><u>{today_str}</u></b></span>\n")

    # Get weekly notes
    # Tuesday of this week
    this_tue = now.date() - datetime.timedelta(days=(now.weekday() - 1) % 7)
    last_tue = this_tue - datetime.timedelta(days=7)
    next_tue = this_tue + datetime.timedelta(days=7)

    reports = "\n"
    reports += get_weekly_content(last_tue)
    reports += "\n" + get_weekly_content(this_tue)
    reports += "\n" + get_weekly_content(next_tue)

    header = f"<big><span color='#5a9fd4'><b>{now.strftime('%B %Y')}</b></span></big>\n"
    
    return f"{header}<tt>{month_cal}</tt>\n<span color='#c8951a'>──────────────────────────</span>\n{reports}"

if __name__ == "__main__":
    now = datetime.datetime.now()
    output = {
        "text": f"󱑊 {now.strftime(DATE_FORMAT)}",
        "tooltip": generate_calendar()
    }
    print(json.dumps(output))
