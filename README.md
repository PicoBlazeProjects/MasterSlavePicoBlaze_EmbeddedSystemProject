# MasterSlavePicoblaze_EmbeddedSystemProject

in this project: It is performed that a master-slave configurated picoblazes

How It Works
Algorithmic State Machine
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
