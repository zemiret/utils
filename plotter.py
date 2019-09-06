import plotly
from plotly.graph_objs import Scatter, Layout
import sys
import os

# Simple script for creating offline plots. Requieres python plotly lib
# Arguments:
# 1: limit (optional) - limit of records to be considered, the first coordinate upper limit
# 2-...: filenames - paths to files that contain plot data 
#
# Plot data files format: 
# \n separated records of form <x_coord> <y_coord>
# e.g.:
# 1 250
# 3 300
# 4 400
# and so on

if len(sys.argv) == 1:
    raise Exception("Supply file with data")

try:
    plot_range = int(sys.argv[1])
    sys.argv.pop(0)
except ValueError:
    plot_range = -1


data = []

for filename in sys.argv[1:]:
    with open(filename) as file:
        x_list = []
        y_list = []

        for line in file:
            line_vals = line.split(' ')
            x = int(line_vals[0])
            y = int(line_vals[1])

            x_list.append(x)
            y_list.append(y)

            if plot_range != -1 and x >= plot_range:
                break
        
        data.append(Scatter(x=x_list, y=y_list, name = os.path.basename(filename).split('.')[0]))

plotly.offline.plot({
    "data": data,
    "layout": Layout(title="Plot")
})
