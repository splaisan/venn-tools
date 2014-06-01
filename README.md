venn-tools
==========

Standalone R scripts to plot Venn diagrams for 2, 3 or 4 groups **from pre-computed counts**.

# Introduction

These scripts are meant for vizalization of summary counts obtained from CLI applications (e.g. intersect counts between several 'algorithm-X' runs of variant lists obtained by different callers or datasets). 

Unlike other such tools, the scripts take the counts passed by command-line arguments to plot the numbers in the corresponding Venn areas. The arguments allow some level of customization like generating white, grey, or colored backgrounds venn diagrams (run with -h for more details).

# Requirements

In order to use these scripts, you will need [R] and RScript installed on your computer (done by most package installers including yum and apt-get).

You will also need the following three [R] packages:

* **gridBase** [http://cran.r-project.org/web/packages/gridBase/](http://cran.r-project.org/web/packages/gridBase/) required for *colorfulVennPlot* plotting.
* **colorfulVennPlot** [http://cran.r-project.org/web/packages/colorfulVennPlot/](http://cran.r-project.org/web/packages/colorfulVennPlot/) to actually plot the Venn diagrams.
* **optparse** [http://cran.r-project.org/web/packages/optparse/](http://cran.r-project.org/web/packages/optparse/) to handle command line arguments.

Installing the dependencies is documented on the top of the code. Please read the respective package documentations if you wish to improve these scripts.

# How to Use the scripts

Type the script name followed by -h or --help will list all available parameters

**2DVenn.R -h**
<pre>
Usage: /opt/biotools/bin/2DVenn.R [options]


Options:
	-a A.COUNT, --a.count=A.COUNT
		counts for A-only

	-b B.COUNT, --b.count=B.COUNT
		counts for B-only

	-i AB.COUNT, --ab.count=AB.COUNT
		counts for AB-intersect

	-A A.LABEL, --a.label=A.LABEL
		label for A

	-B B.LABEL, --b.label=B.LABEL
		label for B

	-t TITLE, --title=TITLE
		Graph Title

	-x FORMAT, --format=FORMAT
		file format for output 1:PNG, 2:PDF [default: 1]

	-o FILE, --file=FILE
		file name for output [default: 2Dvenn.png]

	-u FILL, --fill=FILL
		fill with 1:colors, 2:greys or 3:white [default: 3]

	-h, --help
		Show this help message and exit

</pre>

# Example screenshots

The output of the three scripts with default parameters (empty venn plots)

|               | 2D  | 3D  | 4D  |
|---------------|-----|-----|-----|
| color (-U 1)  | <img src="pictures/2Dvenn_color.png?raw=true" alt="2D color" style="width: 30px;"/> | <img src="pictures/3Dvenn_color.png?raw=true" alt="3D color" style="width: 30px;"/> | <img src="pictures/4Dvenn_color.png?raw=true" alt="4D color" style="width: 30px;"/> |
| grey (-U 2)   | <img src="pictures/2Dvenn_grey.png?raw=true" alt="2D grey" style="width: 30px;"/> | <img src="pictures/3Dvenn_grey.png?raw=true" alt="3D grey" style="width: 30px;"/> | <img src="pictures/4Dvenn_grey.png?raw=true" alt="4D grey" style="width: 30px;"/> |
| white (-U 3*) | <img src="pictures/2Dvenn_white.png?raw=true" alt="2D white" style="width: 30px;"/> | <img src="pictures/3Dvenn_white.png?raw=true" alt="3D white" style="width: 30px;"/> | <img src="pictures/4Dvenn_white.png?raw=true" alt="4D white" style="width: 30px;"/> |
<pre>'*' default is set to white</pre>
------------
enjoy!

<h4>Please send comments and feedback to <bits@vib.be></h4>
------------

![Creative Commons License](http://i.creativecommons.org/l/by-sa/3.0/88x31.png?raw=true)

This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License](http://creativecommons.org/licenses/by-sa/3.0/).
