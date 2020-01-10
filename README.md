# MasterSlavePicoblaze_EmbeddedSystemProject

![](Project_Report_and_Poster/schematic(1).png)

In this project: It is performed that a master-slave configurated PicoBlaze system which reads data from block ram and sends over 1 bit line to the slave PicoBlaze. FIFO structure is used for this purpose as datapath which provides asynchronous write/read capabilities for master and slave PicoBlaze. FIFO outputs are used as interrupt signals.

- FIFO full flag is interrupt signal for master PicoBlaze which writes data to the FIFO
- FIFO empty signal is interrupt signal for slave PicoBlaze which reads data from FIFO

How It Works:
- Master PicoBlaze enables read strobe
and reads data from block ram
- Master transfers data to the FIFO
block
- If FIFO is full, master PicoBlaze
goes into interrupt
- If FIFO is empty, slave PicoBlaze
goes into interrupt
- Slave PicoBlaze reads data from
FIFO block via 1 bit input
- Slave PicoBlaze converts 1 bit input in every 8 data received to
the 8 bit original data by shifting received bit to the left and
adding with new data
- Slave writes data to the out port

#### Installing project with git clone command: 
`git clone https://github.com/PicoBlazeProjects/MasterSlavePicoBlaze_EmbeddedSystemProject.git`

Install the project and open the project file with Vivado. Running the simulation will give the result. Further details can be found in the project report.

### Note:
If any of the source files are not shown in the project file, add them via add files section in vivado and add them from 'design' source folder
### Block RAM Configuration
Single Port RAM, Enable Port Type: Use ENA Pin, Write Width:8, Write Depth:64
### For any question and suggestion , please contact with us:
Ömer Demirci
[GitHub](https://github.com/demirgit)
demirciomer98@gmail.com

M. Akif Özkanoğlu 
[GitHub](https://github.com/makifozkanoglu)
makifozkanoglu@gmail.com
