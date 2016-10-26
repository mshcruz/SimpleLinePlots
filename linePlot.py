import csv
import matplotlib.pyplot as plt

implementations = ["gpu", "cpuParallel", "cpuSerial"]
input_file_suffix = ".csv"
x_values = range(10, 20)
y_values = []
for i in implementations:
    implementation_y_values = []
    csv_file = open(i + input_file_suffix)
    reader = csv.reader(csv_file)
    # Skip the first line with the columns' names
    next(reader)
    for row in reader:
        implementation_y_values.append(row[0])
    y_values.append(implementation_y_values)

# Format figure
plt.rcParams["figure.figsize"] = [10, 10]
plt.rcParams["figure.facecolor"] = 'white'
    
# Construct the plot with lines for different implementations
gpuLine, = plt.plot(x_values, y_values[0],
                    '-ko', linewidth=4, markersize=20)
cpuParallelLine, = plt.plot(x_values, y_values[1],
                            '-k^', linewidth=4, markersize=20)
cpuSerialLine, = plt.plot(x_values, y_values[2],
                          '-ks', linewidth=4, markersize=20)

# Format axes
plt.ylabel("Elapsed time (s)", fontname='Times New Roman', fontsize=35)
plt.xlabel("|R|", fontname='Times New Roman', fontsize=35)
x_labels = ["$\mathregular{2^{" + str(label) + "}}$" for label in x_values]
plt.xticks(x_values, x_labels, fontname='Times New Roman')
plt.yticks(fontname='Times New Roman')
plt.tick_params(axis='x', top='off', which='both', labelsize=35, pad=15)
plt.tick_params(axis='y', right='off', which='both', labelsize=35)
plt.tick_params(axis='y', left='off', which='minor')
plt.yscale('log', nonposy='clip')
plt.axis([9, 20, 0.05, 50000])
plt.axes().yaxis.grid()
plt.tight_layout()

# Format legend
plt.legend([cpuSerialLine, cpuParallelLine, gpuLine],
           ["CPU (Serial)", "CPU (Parallel)", "GPU"],
           frameon=False, fontsize=30,
           prop={'family': 'Times New Roman', 'size': 32},
           numpoints=1, loc=2)

plt.show()

# Export figure
plt.savefig('linePlot.pdf', format='pdf')
