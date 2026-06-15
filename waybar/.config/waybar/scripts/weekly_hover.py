#!/usr/bin/env python3
import json
import calendar
import datetime
import os
import html

# Configuration
TODO_FILE = os.path.expanduser("~/docs/md/todo.md")
DATE_FORMAT = "%I:%M %p  //  %a %b %d"

def get_todo_content():
    if not os.path.exists(TODO_FILE):
        return "<span color='#cc3333'><b>todo.md not found</b></span>\n"
    
    tasks = []
    current_section = ""
    with open(TODO_FILE, 'r') as f:
        for line in f:
            stripped = line.strip()
            if stripped.startswith("## "):
                current_section = stripped[3:].strip()
            elif stripped.startswith("- [ ]"):
                task_text = stripped[5:].strip()
                tasks.append((current_section, task_text))
                
    if not tasks:
        return "🎉 <span color='#5a9fd4'><b>No pending tasks!</b></span>\n"
        
    output = "<span color='#5a9fd4'><b>Active Tasks:</b></span>\n"
    for sec, task in tasks[:8]: # Show up to 8 tasks
        task_esc = html.escape(task)
        output += f"• {task_esc}\n"
    if len(tasks) > 8:
        output += f"<i>...and {len(tasks) - 8} more</i>\n"
    return output

def generate_calendar():
    now = datetime.datetime.now()
    cal = calendar.TextCalendar(calendar.SUNDAY)
    month_cal = cal.formatmonth(now.year, now.month)
    
    # Highlight today in the calendar
    today_str = str(now.day).rjust(2)
    month_cal = month_cal.replace(f" {today_str} ", f" <span color='#c8951a'><b><u>{today_str}</u></b></span> ")
    month_cal = month_cal.replace(f" {today_str}\n", f" <span color='#c8951a'><b><u>{today_str}</u></b></span>\n")
    
    header = f"<big><span color='#5a9fd4'><b>{now.strftime('%B %Y')}</b></span></big>\n"
    
    todo_content = get_todo_content()
    
    return f"{header}<tt>{month_cal}</tt>\n<span color='#c8951a'>──────────────────────────</span>\n{todo_content}"

if __name__ == "__main__":
    now = datetime.datetime.now()
    output = {
        "text": f"󱑊 {now.strftime(DATE_FORMAT)}",
        "tooltip": generate_calendar()
    }
    print(json.dumps(output))
