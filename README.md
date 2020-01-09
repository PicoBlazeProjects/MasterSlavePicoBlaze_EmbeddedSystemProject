# MasterSlavePicoblaze_EmbeddedSystemProject

![](Project_Report_and_Poster/schematic(1).png)

in this project: It is performed that a master-slave configurated picoblaze system which reads data from block ram and sends over 1 bit line to the slave picoblaze. FIFO structure is used for this purpose as datapath which provides asynchronous write/read capabilities for master and slave picoblazes. FIFO outputs are used as interrupt signals.

- FIFO full flag is interrupt signal for master picoblaze which writes data to the FIFO
- FIFO empty signal is interrupt signal for slave picoblaze which reads data from FIFO

How It Works:
- Master picoblaze enables read strobe
and reads data from block ram
- Master transfers data to the FIFO
block
- If FIFO is full, master picoblaze
goes into interrupt
- If FIFO is empty, slave picoblaze
goes into interrupt
- Slave picoblaze reads data from
FIFO block via 1 bit input
- Slave picoblaze converts 1 bit in-
put in every 8 data received to
the 8 bit original data by shift-
ing received bit to the left and
adding with new data
- Slave writes data to the out port

#### installing project with git clone command: 
`git clone https://github.com/PicoBlazeProjects/MasterSlavePicoblaze_EmbeddedSystemProject.git`

Install the project and open the project file with vivado. Run the simulation will give the result.

### For any question and suggestion , please contact with us:
Ömer Demirci
demirciomer98@gmail.com

M. Akif Özkanoğlu
makifozkanoglu@gmail.com
